#include <ros/ros.h>
#include <av_control/longitudinal_pid_pos_controller.h>
#include <std_msgs/String.h>
#include <av_control/json.hpp>
#include <iostream>
#include <cmath>

using namespace av_control;
using json = nlohmann::json;

LongitudinalPIDPosController::LongitudinalPIDPosController(ros::NodeHandle& nh): pos_loop_output_(0), vel_loop_output_(0),e_pos_index_1(0), e_pos_index_2(0), e_vel_index_1(0), e_vel_index_2(0), e_pos_min_(0.1), is_reached_(false), is_overstep_(false), vel_initial(0), e_pos_initial(0), deceleration_ratio(0), final_brake_(3000) {
	ros::param::get("~control_rate", rate_);
	ros::param::get("~/longitudinal_pid_pos_controller/pos_gain_p", pos_gain_p_);
	ros::param::get("~/longitudinal_pid_pos_controller/pos_gain_i", pos_gain_i_);
	ros::param::get("~/longitudinal_pid_pos_controller/pos_gain_d", pos_gain_d_);
	ros::param::get("~/longitudinal_pid_pos_controller/vel_gain_p", vel_gain_p_);
	ros::param::get("~/longitudinal_pid_pos_controller/vel_gain_i", vel_gain_i_);
	ros::param::get("~/longitudinal_pid_pos_controller/vel_gain_d", vel_gain_d_);
	ros::param::get("~/longitudinal_pid_pos_controller/ratio_acc_pedal", ratio_acc_pedal_);
	ros::param::get("~/longitudinal_pid_pos_controller/ratio_brake_pedal", ratio_brake_pedal_); 
	ros::param::get("~/longitudinal_pid_pos_controller/e_pos_min", e_pos_min_);
	ros::param::get("~/longitudinal_pid_pos_controller/final_brake", final_brake_);
    
	pub_longitudinal_pid_pos = nh.advertise<std_msgs::String>("av_control/control_debug/pid_pos", rate_);

}

enum ErrorCode LongitudinalPIDPosController::GenerateControlSignal(const av_msgs::Trajectory &trajectory, const VehicleState &vehicle_state, const uint64_t &time, double &acc_pedal, double &brake_pedal, bool replanning_flag) {
    if(!replanning_flag) {
        is_reached_ = false;
        vel_initial = vehicle_state.vel_x;
        GetPosControlError(trajectory.poses, vehicle_state, e_pos_initial);
        deceleration_ratio = vehicle_state.vel_x / e_pos_initial;
    }

    if(is_reached_ == true) 
    {
        acc_pedal = 0;
        return ErrorCode::SUCCESS; 
    }
    const std::vector<av_msgs::Pose>& ref_poses = trajectory.poses;
    double e_pos_, desired_velocity_ ;

    GetPosControlError(ref_poses, vehicle_state, e_pos_);
   
    GetPosLoopOutput(e_pos_, pos_loop_output_, replanning_flag);

    desired_velocity_ = pos_loop_output_;

    GetVelLoopOutput(desired_velocity_, vehicle_state.vel_x, vel_loop_output_, replanning_flag);
    
    DetermineControlMode(e_pos_, vehicle_state.vel_x, vel_loop_output_, acc_pedal, brake_pedal);
        
    if(debug_){
        json j = {
            { "longitudinal_pid_pos", {
                {{"name" , "e_pos"}, {"value", e_pos_}},
                {{"name" , "pos_loop_output"}, {"value", pos_loop_output_}},
                {{"name" , "vel_loop_output"}, {"value", vel_loop_output_}},
                {{"name" , "desired_vel"}, {"value", desired_velocity_}},
                {{"name" , "current_vel"}, {"value", vehicle_state.vel_x}},
            }}
        };
        std_msgs::String msg;
        msg.data = j.dump();
        pub_longitudinal_pid_pos.publish(msg);

    }
	return ErrorCode::SUCCESS;
}

void LongitudinalPIDPosController::GetPosLoopOutput(const double &e_pos, double &desired_velocity, bool &replanning_flag) {

   desired_velocity = e_pos * deceleration_ratio;

}

void LongitudinalPIDPosController::GetVelLoopOutput(const double &desired_velocity, const double &current_velocity, double &vel_loop_output, bool &replanning_flag){
    double e_vel = desired_velocity - current_velocity;

    vel_gain_p_ = pow(5, current_velocity/10);
    double delta_vel_p = vel_gain_p_ * (e_vel - e_vel_index_1);
    double delta_vel_i = vel_gain_i_ * e_vel;
    double delta_vel_d = vel_gain_d_ * (e_vel- 2 * e_vel_index_1 + e_vel_index_2);

    double delta_vel_PID = delta_vel_p + delta_vel_i + delta_vel_d;
    
    if(replanning_flag) {
        vel_loop_output = vel_loop_output + delta_vel_PID;
    }

    e_vel_index_2 = e_vel_index_1;
    e_vel_index_1 = e_vel;
}

void LongitudinalPIDPosController::DetermineControlMode(const double &e_pos, const double &velocity, const double &vel_loop_output, double &acc_pedal, double &brake_pedal){
    if(vel_loop_output >=0 )
    {
        acc_pedal = ratio_acc_pedal_ * vel_loop_output;
        brake_pedal = 0;
    } else {
        brake_pedal =-ratio_brake_pedal_ * vel_loop_output;
        acc_pedal = 0;
    }
    if (velocity <0.1 || e_pos < e_pos_min_)
    {
        acc_pedal = 0;
        brake_pedal = final_brake_;
        is_reached_ = true;
    }
}

