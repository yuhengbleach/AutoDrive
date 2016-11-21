#include <ros/ros.h>
#include <av_control/longitudinal_pid_controller.h>
#include <std_msgs/String.h>
#include <av_control/json.hpp>
using namespace av_control;
using json = nlohmann::json;

LongitudinalPIDController::LongitudinalPIDController(ros::NodeHandle& nh) : rate_(0),gain_p_(0), gain_i_(0), gain_d_(0), ratio_acc_pedal_(0), ratio_brake_pedal_(0), PID_output_(0), e_vel_index_1(0), e_vel_index_2(0){
	ros::param::get("~control_rate", rate_);
	ros::param::get("~/longitudinal_pid_controller/gain_p", gain_p_);
	ros::param::get("~/longitudinal_pid_controller/gain_i", gain_i_);
	ros::param::get("~/longitudinal_pid_controller/gain_d", gain_d_);
	ros::param::get("~/longitudinal_pid_controller/ratio_acc_pedal", ratio_acc_pedal_);
	ros::param::get("~/longitudinal_pid_controller/ratio_brake_pedal", ratio_brake_pedal_);

	pub_longitudinal_pid = nh.advertise<std_msgs::String>("av_control/control_debug/pid", rate_);
}

enum ErrorCode LongitudinalPIDController::GenerateControlSignal(const av_msgs::Trajectory &trajectory, const VehicleState &vehicle_state, const uint64_t &time, double &acc_pedal, double &brake_pedal, bool replanning_flag) {
	av_msgs::Pose desired_pose_;

    SelectDesiredPose(trajectory, time,desired_pose_);

    double current_velocity_ = vehicle_state.vel_x;
    double origin_velocity_ = current_velocity_;

	GetControlSignal(desired_pose_.velocity, current_velocity_, PID_output_, replanning_flag);
	DetermineControlMode(PID_output_, acc_pedal, brake_pedal);
    if(debug_){
        json j = {
            { "longitudinal_pid", {
                {{"name", "origin_velocity"},{"value", origin_velocity_}},
                {{"name", "desired_velocity"},{"value", desired_pose_.velocity}},
                {{"name", "filter_velocity"},{"value", current_velocity_}},
                {{"name", "PID_output"}, {"value", PID_output_}},
                {{"name", "current_acceleration"}, {"value", vehicle_state.acc_x}},
            }}
        };
        std_msgs::String msg;
        msg.data = j.dump();
        pub_longitudinal_pid.publish(msg);
    }

	return ErrorCode::SUCCESS;
}


void LongitudinalPIDController::GetControlSignal(const double &desired_velocity, const double &current_velocity, double &PID_output, bool& replanning_flag)
{
	double e_vel = desired_velocity - current_velocity;

	double delta_p = gain_p_ * (e_vel - e_vel_index_1);
	double delta_i = gain_i_ * e_vel;
	double delta_d = gain_d_ * (e_vel- 2 * e_vel_index_1 + e_vel_index_2);
	
	double delta_PID = delta_p + delta_i + delta_d;

	if(replanning_flag){
		PID_output = PID_output + delta_PID;
	}

	e_vel_index_2 = e_vel_index_1;
	e_vel_index_1 = e_vel;
}

void LongitudinalPIDController::DetermineControlMode(const double &PID_output, double &acc_pedal, double &brake_pedal)
{
	if(PID_output >=0 )
	{
		acc_pedal = ratio_acc_pedal_ * PID_output;
		brake_pedal = 0;
	} else {
		brake_pedal =-ratio_brake_pedal_ * PID_output;
		acc_pedal = 0;
	}
}
