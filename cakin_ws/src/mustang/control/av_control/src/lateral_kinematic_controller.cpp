#include <ros/ros.h>
#include <av_control/lateral_kinematic_controller.h>
#include <av_control/lateral_controller.h>
#include <fstream>

#include <std_msgs/String.h>
#include <av_control/json.hpp>
using namespace av_control;
using namespace std;
using json = nlohmann::json;

LateralKinematicController::LateralKinematicController(ros::NodeHandle &nh):rate_(0), steer_angle(0), temp_phi(0), temp_velocity(0), temp_e_p(0)
{
	ros::param::get("~/control_rate", rate_);

	ros::param::get("~/lateral_kinematic_controller/kp_steer", kp_steer_);
	ros::param::get("~/lateral_kinematic_controller/kd_phi", kd_phi_);
	ros::param::get("~/lateral_kinematic_controller/steer_ratio", steer_ratio_);

    pub_kinematic = nh.advertise<std_msgs::String>("av_control/control_debug/lateral_kinematic", rate_);
}

enum ErrorCode LateralKinematicController::GenerateControlSignal(const av_msgs::Trajectory &trajectory, const VehicleState &vehicle_state, const uint64_t &time, double &steer_signal, double &ref_curvature, bool replanning_flag){
    const std::vector<av_msgs::Pose>& ref_poses = trajectory.poses;

	double e_pos = 0, e_ang = 0, e_pos_current = 0, e_ang_current = 0;
    ref_curvature = 0;

	GetLateralControlError(ref_poses, vehicle_state, e_pos, e_ang, e_pos_current, e_ang_current, ref_curvature); 
	
	steer_signal = GetSteeringAngle(e_ang, e_pos, vehicle_state, replanning_flag);

//	OutputFilter(steer_signal); 

    if(debug_ ){
        json j = {
            {"lateral",{
                {{"name", "kinematic_e_pose"}, {"value", e_pos_current}},
                {{"name", "kinematic_e_angle"}, {"value", e_ang_current}},
				{{"name", "kinematic_steer_signal"}, {"value", steer_signal}},
            }}
        };
        std_msgs::String msg;
        msg.data = j.dump();
        pub_kinematic.publish(msg);
    }	
	return ErrorCode::SUCCESS;
}

double LateralKinematicController::GetSteeringAngle(const double phi, const double e_p, const VehicleState &vehicle_state, bool &replanning_flag){
	double current_velocity_ = vehicle_state.vel_x;

	double delta_phi = phi - temp_phi;
	double delta_atan = kp_steer_ * ((e_p - temp_e_p) * (EPSILON + current_velocity_) - e_p *(current_velocity_ - temp_velocity)) / (pow((EPSILON + current_velocity_),2) + pow(kp_steer_ * e_p,2));

	double delta_steer_angle = delta_phi + delta_atan;

	if(replanning_flag){
		steer_angle = steer_angle + delta_steer_angle;
	}

	temp_phi = phi;
	temp_velocity = current_velocity_;
	temp_e_p = e_p;

	double steer_signal = -steer_angle / M_PI * 180;
	steer_signal = steer_signal * steer_ratio_;
	return steer_signal;
}
