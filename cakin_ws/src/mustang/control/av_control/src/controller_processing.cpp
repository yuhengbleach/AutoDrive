#include <av_control/controller_processing.h>
#include <av_comm/comm.h>
#include <math.h>
#include <std_msgs/String.h>
#include <functional>
#include <vector>
#include <fstream>
#include <iostream>
#include <av_control/json.hpp>
#include <av_msgs/VehicleState.h>
#include <av_control/fir_filter.h>
#include <av_control/state_fir_filter.h>
#include <av_control/state_filter.h>

using namespace std;
using json = nlohmann::json;

namespace av_control {

ControllerProcessing::ControllerProcessing() : simulation_mode_(true), rate_(50), debug_(true){
    ros::param::get("~debug", debug_);
	ros::param::get("~simulation", simulation_mode_);
	ros::param::get("~control_rate", rate_);
	ros::param::get("~limit_acc_pedal", limit_acc_pedal_);
	ros::param::get("~limit_brake_pedal", limit_brake_pedal_);
	ros::param::get("~limit_steering_angle", limit_steering_angle_);

    pub_vehicle_state_ = nh_.advertise<av_msgs::VehicleState>("av_control/vehicle_state", rate_);

	pub_simulation_ = nh_.advertise<av_msgs::ControlSignal>("av_control/control_signal", rate_);
	pub_gateway_ = nh_.advertise<std_msgs::String>("gateway_ag", rate_);

    state_filter_ptr_ = std::move(std::unique_ptr<StateFilter> (new StateFirFilter));
}

bool ControllerProcessing::SendControlSignal(double acc_pedal, double brake_pedal, double steering_angle, uint64_t &time) {
	limitControlSignal(acc_pedal, brake_pedal, steering_angle);
    state_filter_ptr_ -> SignalProcess(acc_pedal, brake_pedal, steering_angle);
	av_msgs::ControlSignal control_signal;
    control_signal.timestamp = time;
	control_signal.acc_pedal_pos = acc_pedal;
	control_signal.brake_pedal_pos = brake_pedal;
	control_signal.steering_angle = steering_angle;

	pub_simulation_.publish(control_signal);
	
    json j = {
		{"id", 267},
		{"signals",{
			{ {"name", "ACU_STAT_AccPedalPos"}, {"value", acc_pedal} }, 
			{ {"name", "ACU_VLC_TarDece"}, {"value", brake_pedal} }, 
			{ {"name", "ACU_Steering_Angle"}, {"value", steering_angle} }, 
		}}
	};
	std_msgs::String msg;
	msg.data = j.dump();
	pub_gateway_.publish(msg);
	return true;
}

bool ControllerProcessing::parseGatewayMsg(const std::string& gateway_msg, double& vel_x, double& vel_ang, double& acc_x, double& acc_y) {
	json j = json::parse(gateway_msg);
	json signals = j["signals"];
	bool vel_x_valid = false, acc_x_valid = false, acc_y_valid = false, vel_ang_valid = false;
	for (json::iterator it = signals.begin(); it != signals.end(); ++it) {
		auto signal_json = *it;
		if(signal_json["name"] == "VehicleSpeed") {
			vel_x = signal_json["value"].get<double>();
			vel_x_valid = true;
		}
		if(signal_json["name"] == "LongAcceleration") {
			acc_x = signal_json["value"].get<double>();
			acc_x_valid = true;
		}	
		if(signal_json["name"] == "LatAcceleration") {
			acc_y = signal_json["value"].get<double>();
			acc_y_valid = true;
		}
		if(signal_json["name"] == "YawRate") {
			vel_ang = signal_json["value"].get<double>();
			vel_ang_valid = true;
		}
		if(signal_json["name"] == "VehicleSpeedValid") {
			int vel_x_valid_raw = signal_json["value"].get<int>();
			vel_x_valid = (vel_x_valid_raw == 0);
		}
		if(signal_json["name"] == "STAT_AXSStat") {
			int acc_x_valid_raw = signal_json["value"].get<int>();
			acc_x_valid = (acc_x_valid_raw == 0);
		}		
		if(signal_json["name"] == "STAT_AYSStat") {
			int acc_y_valid_raw = signal_json["value"].get<int>();
			acc_y_valid = (acc_y_valid_raw == 0);
		}
		if(signal_json["name"] == "STAT_YawStat") {
			int vel_ang_valid_raw = signal_json["value"].get<int>();
			vel_ang_valid = (vel_ang_valid_raw == 0);
		}
	}
	bool msg_valid = vel_x_valid & acc_x_valid & acc_y_valid & vel_ang_valid;
	return msg_valid;
}

void ControllerProcessing::limitControlSignal(double& acc_pedal, double& brake_pedal, double& steering_angle) {
	acc_pedal = acc_pedal < 0 ? 0 : acc_pedal;
	acc_pedal = acc_pedal > limit_acc_pedal_ ? limit_acc_pedal_ : acc_pedal;

	brake_pedal = brake_pedal < 0 ? 0 : brake_pedal;
	brake_pedal = brake_pedal > limit_brake_pedal_ ? limit_brake_pedal_ : brake_pedal;

	steering_angle = steering_angle < -limit_steering_angle_ ? -limit_steering_angle_ : steering_angle;
	steering_angle = steering_angle > limit_steering_angle_ ? limit_steering_angle_ : steering_angle;
}

void ControllerProcessing::EmergencyStop() {
    uint64_t time = av_comm::Now();
	SendControlSignal(0, 1000, 0, time);
}

bool ControllerProcessing::CheckTrajectory(const av_msgs::Trajectory& trajectory) {
	const std::vector<av_msgs::Pose>& poses = trajectory.poses;
	if(poses.size() < 2) {
		ROS_ERROR("trajectory too short!");
		return false;
	}
	uint64_t time_now = av_comm::Now();
	if(time_now < poses.front().timestamp || time_now > poses.back().timestamp){
		ROS_ERROR("trajectory time out!");
		return false;
	}
	return true;
}

void ControllerProcessing::UpdateVehicleState(const av_msgs::Pose& initial_pose, const av_msgs::Localize& localize, const std::string& gateway_msg, VehicleState& vehicle_state, bool gateway_ready) {
	double vel_x, vel_ang, acc_x, acc_y;
	bool is_valid = false;
	if(gateway_ready)
		is_valid = parseGatewayMsg(gateway_msg, vel_x, vel_ang, acc_x, acc_y);
	if(is_valid) {
		vehicle_state.vel_x = vel_x;
		vehicle_state.vel_ang = vel_ang;
		vehicle_state.acc_x = acc_x;
		vehicle_state.acc_y = acc_y;
	} else {
		vehicle_state.vel_x = localize.vel_x;
		vehicle_state.vel_ang = localize.angular_vel_z;
		vehicle_state.acc_x = localize.acc_x;
		vehicle_state.acc_y = localize.acc_y;
	}

	vehicle_state.x = localize.pose_x;
	vehicle_state.y = localize.pose_y;
	vehicle_state.ang = localize.heading;
	vehicle_state.vel_y = localize.vel_y;
	vehicle_state.acc_ang = 0;

    // state_filter_ptr_ -> Process(vehicle_state);
 
    uint64_t time = av_comm::Now();    

    vehicle_state_msg.x = vehicle_state.x;
    vehicle_state_msg.y = vehicle_state.y;
    vehicle_state_msg.ang = vehicle_state.ang;
    vehicle_state_msg.vel_x = vehicle_state.vel_x;
    vehicle_state_msg.vel_y = vehicle_state.vel_y;
    vehicle_state_msg.vel_ang = vehicle_state.vel_ang;
    vehicle_state_msg.acc_x = vehicle_state.acc_x;
    vehicle_state_msg.acc_y = vehicle_state.acc_y;
    vehicle_state_msg.acc_ang = vehicle_state.acc_ang;
    vehicle_state_msg.timestamp = time;
	transformCoordinate(initial_pose.x, initial_pose.y, initial_pose.theta, vehicle_state.x, vehicle_state.y, vehicle_state.ang);
}

void ControllerProcessing::transformCoordinate(double x_0, double y_0, double angle_0, double& x, double& y, double& angle) {
	double x_t = x - x_0;
	double y_t = y - y_0;
	angle = angle - angle_0;
	x = cos(angle_0) * x_t + sin(angle_0) * y_t;
	y = -sin(angle_0) * x_t + cos(angle_0) * y_t;
}

void ControllerProcessing::SendVehicleState(const double &ref_curvature) {
    vehicle_state_msg.ref_curvature = ref_curvature;
    pub_vehicle_state_.publish(vehicle_state_msg);
}

}
