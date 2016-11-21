#include <ros/ros.h>
#include <av_control/lateral_controller.h>
#include <av_control/lateral_pbc_controller.h>

#include <std_msgs/String.h>
#include <av_control/json.hpp>

#include <cmath>

using namespace av_control;
using namespace std;
using json = nlohmann::json;

LateralPBCController::LateralPBCController(ros::NodeHandle &nh):rate_(0),e_p_temp(0), z_temp(0), PI_output_(0)
{
    ros::param::get("~/control_rate", rate_);

    ros::param::get("~/lateral_pbc_controller/pbc_k0", pbc_k0_);
    ros::param::get("~/lateral_pbc_controller/pbc_emax", pbc_emax_);
    ros::param::get("~/lateral_pbc_controller/pbc_kp", pbc_kp_);
    ros::param::get("~/lateral_pbc_controller/pbc_ki", pbc_ki_);
    ros::param::get("~/lateral_pbc_controller/pbc_lambda", pbc_lambda_);
    ros::param::get("~/lateral_pbc_controller/steer_ratio", steer_ratio_);


    pub_pbc = nh.advertise<std_msgs::String>("av_control/control_debug/lateral_pbc", rate_);
}

enum ErrorCode LateralPBCController::GenerateControlSignal(const av_msgs::Trajectory &trajectory, const VehicleState &vehicle_state, const uint64_t &time, double &steer_signal, double &ref_curvature, bool replanning_flag)
{
    const std::vector<av_msgs::Pose>& ref_poses = trajectory.poses;

    double e_pos_preview = 0, e_ang_preview = 0, e_pos_current = 0, e_ang_current = 0;
    ref_curvature = 0;

    GetLateralControlError(ref_poses, vehicle_state, e_pos_preview, e_ang_preview, e_pos_current, e_ang_current, ref_curvature);
    
//    GetSteeringAngle(e_pos_preview, ref_curvature, vehicle_state, steer_signal, replanning_flag);
    double FF_output_;     
    GetPIOutput(e_pos_preview, PI_output_, replanning_flag);
    GetFeedForwardOutput(ref_curvature, vehicle_state.vel_x, FF_output_, replanning_flag);

    double PBC_output = PI_output_ + FF_output_;
    
    steer_signal = PBC_output / M_PI * 180;
    steer_signal = steer_signal * steer_ratio_;

    if (FF_output_ > 1) ROS_ERROR("ff too large!");
  //  std::cout << "pbc: "<< PBC_output << ", pi: "<< PI_output_ <<", ff: "<< FF_output_ <<", signal:" << steer_signal<<std::endl;


    if(debug_ ){
        json j = {
            {"lateral_pbc",{
                {{"name", "pbc_e_pose"}, {"value", e_pos_current}},
                {{"name", "pbc_e_angle"}, {"value", e_ang_current}},
                {{"name", "pbc_steer_signal"}, {"value", steer_signal}},
                {{"name", "pbc_pi_output"}, {"value", PI_output_}},
                {{"name", "pbc_ff_output"}, {"value", FF_output_}},
                {{"name", "pbc_output"}, {"value", PBC_output}},
            }}
        };
        std_msgs::String msg;
        msg.data = j.dump();
        pub_pbc.publish(msg);
    }
    return ErrorCode::SUCCESS;
}


void LateralPBCController::GetSteeringAngle(const double &e_p, double &ref_curvature, const VehicleState &vehicle_state, double &steering_signal, bool &replanning_flag)
{
    double FF_output_;

    GetPIOutput(e_p, PI_output_, replanning_flag);
    GetFeedForwardOutput(ref_curvature, vehicle_state.vel_x, FF_output_, replanning_flag);

    double PBC_output = PI_output_ + FF_output_;
   
    steering_signal = PBC_output / M_PI * 180;
    steering_signal = steering_signal * steer_ratio_;
}

void LateralPBCController::GetNonLinearGain(const double &e, double &ke)
{
    double e_sat;
    if( fabs(e) < pbc_emax_)  e_sat = e;
    else if(e >= 0)  e_sat = pbc_emax_; 
    else e_sat = pbc_emax_;
    
    ke = 0.5 * (exp(pbc_k0_ * e_sat) + exp(-pbc_k0_ * e_sat));

//    std::cout << "e : "<< e <<", ke: "<< ke  <<std::endl;
}

void LateralPBCController::GetPIOutput(const double &e_p, double &PI_output, bool &replanning_flag)
{
    //std::cout << "e_p :"<<e_p<<", e_p_temp: "<<e_p_temp <<std::endl;
    double z = 0;
    if(replanning_flag){ 
         z = (e_p - e_p_temp) * rate_ + pbc_lambda_ * e_p;
    } 
    double ke;
    GetNonLinearGain(e_p, ke);
    double delta_PI = -ke* (pbc_ki_ * z + pbc_kp_ * (z - z_temp));
    if(replanning_flag){
        PI_output += delta_PI;
    } 
    z_temp = z; 
    e_p_temp = e_p;
}

void LateralPBCController::GetFeedForwardOutput(const double &ref_curvature, const double &vel_x, double &ff_output,bool &replanning_flag)
{
    double L_f = front_axle_cog_distance_;
    double L_r = rear_axle_cog_distance_;
    double C_f = front_tire_cornering_stiff_;
    double C_r = rear_tire_cornering_stiff;
  //  ff_output = ref_curvature * ((L_f + L_r)
  //              + vehicle_mass_ * pow(vel_x, 2) * (L_r * C_r - L_f * C_f)/(road_friction_coef_ * C_f * C_r * (L_f + L_r)));

    ff_output = ref_curvature * ((L_f + L_r));
//    std::cout << "ff_output: "<< ref_curvature << " , "<< ff_output<<std::endl;
}
