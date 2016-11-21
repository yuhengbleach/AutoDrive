#include <av_control/controller_core.h>
#include <av_control/longitudinal_pid_controller.h>
#include <av_control/longitudinal_pid_pos_controller.h>
#include <av_control/longitudinal_adrc_controller.h>
#include <av_control/lateral_kinematic_controller.h>
#include <av_control/lateral_pbc_controller.h>
#include <av_control/controller_processing.h>
#include <av_comm/comm.h>
#include <math.h>

#include <functional>
#include <vector>
#include <fstream>
#include <iostream>

using namespace std;

namespace av_control {

ControllerCore::ControllerCore(const ros::NodeHandle& nh) : rate_(50), 
															trajectory_queue_size_(10), 
															localize_queue_size_(10), 
															gateway_queue_size_(10), 
															enable_controller_(false), 
															trajectory_ready_(false), 
															localize_ready_(false),
															gateway_ready_(false), 
															replanning_steps_(0)  {
	ConfigureParams();
	ConfigureControllers();
}

void ControllerCore::Start() {
	//subscribe perception information
	ros::Subscriber sub_trajectory = 
		nh_.subscribe("/av_planning/planning/trajectory", trajectory_queue_size_, &ControllerCore::SubscribeTrajectoryCallback, this);
    ros::Subscriber sub_localize =
        		nh_.subscribe("/av_localization/localization/localize", localize_queue_size_, &ControllerCore::SubscribeLocalizeCallback, this);
    ros::Subscriber sub_gateway =
        		nh_.subscribe("/av_gateway/gateway_ag", gateway_queue_size_, &ControllerCore::SubscribeGatewayCallback, this);
	ros::Rate loop_rate(rate_);
	
	VehicleState current_vehicle_state;
	av_msgs::Trajectory current_trajectory;

	double acc_pedal = 0;
	double brake_pedal = 0;
	double steer_signal = 0;
    double ref_curvature = 0;
	
	while (ros::ok()) {
		ros::spinOnce();
		enable_controller_ = trajectory_ready_ & localize_ready_ & gateway_ready_;
		if(enable_controller_) {
			current_trajectory = trajectory_;
			bool trajectory_valid = controller_processing_ptr_ -> CheckTrajectory(current_trajectory);
			if(!trajectory_valid) {
				trajectory_ready_ = false;
				controller_processing_ptr_ -> EmergencyStop();
				ROS_ERROR("invalid trajectory, vehicle stopping!");
				continue;
			}
			replanning_steps_ ++;
			controller_processing_ptr_ -> UpdateVehicleState(current_trajectory.initial_pose, localize_, gateway_msg_, current_vehicle_state, gateway_ready_);

			uint64_t time = av_comm::Now();
            if(current_trajectory.driving_state == 0) {
    			longitudinal_controller_ptr_ -> GenerateControlSignal(current_trajectory, current_vehicle_state, time, acc_pedal, brake_pedal, replanning_steps_>2);
			    lateral_controller_ptr_ -> GenerateControlSignal(current_trajectory, current_vehicle_state, time, steer_signal, ref_curvature, replanning_steps_>2);
            } else if(current_trajectory.driving_state == 1) {
                longitudinal_pos_controller_ptr_ -> GenerateControlSignal(current_trajectory, current_vehicle_state, time, acc_pedal, brake_pedal, replanning_steps_>2);
                steer_signal = 0;
            }
			//ROS_INFO("acc_pedal = %f, brake_pedal = %f", acc_pedal, brake_pedal);
            controller_processing_ptr_ -> SendVehicleState(ref_curvature);
			controller_processing_ptr_ -> SendControlSignal(acc_pedal, brake_pedal, steer_signal, time);
		}
		
		loop_rate.sleep();
	}
}

void ControllerCore::ConfigureParams () {
	ros::param::get("~control_rate", rate_);
	ros::param::get("~trajectory_queue_size", trajectory_queue_size_);
	ros::param::get("~localize_queue_size", localize_queue_size_);
	ros::param::get("~gateway_queue_size", gateway_queue_size_);
}

void ControllerCore::ConfigureControllers () {
	ROS_INFO("configuring controllers");
	std::string longitudinal_controller_type, longitudinal_pos_controller_type, lateral_controller_type;
	ros::param::get("~longitudinal_controller_type", longitudinal_controller_type);
	ros::param::get("~longitudinal_pos_controller_type", longitudinal_pos_controller_type);
	ros::param::get("~lateral_controller_type", lateral_controller_type);
	
	ROS_INFO("longitudinal controller type: %s, longitudinal position controller type: %s, lateral controller type: %s", longitudinal_controller_type.c_str(), longitudinal_pos_controller_type.c_str(), lateral_controller_type.c_str());

	if(longitudinal_controller_type == "adrc") {
		longitudinal_controller_ptr_ = std::move(std::unique_ptr<LongitudinalController> (new LongitudinalADRCController(nh_)));
	} else if(longitudinal_controller_type == "pid") {
		longitudinal_controller_ptr_ = std::move(std::unique_ptr<LongitudinalController> (new LongitudinalPIDController(nh_)));
	} else {
		ROS_ERROR("undefined longitudinal controller, setting to PID controller");
		longitudinal_controller_ptr_ = std::move(std::unique_ptr<LongitudinalController> (new LongitudinalPIDController(nh_)));
	}

    if(longitudinal_pos_controller_type == "pid") {
        longitudinal_pos_controller_ptr_ = std::move(std::unique_ptr<LongitudinalPosController> (new LongitudinalPIDPosController(nh_)));
    } else {
		ROS_ERROR("undefined longitudinal position controller, setting to PID controller");
        longitudinal_pos_controller_ptr_ = std::move(std::unique_ptr<LongitudinalPosController> (new LongitudinalPIDPosController(nh_)));
    }

	if(lateral_controller_type == "kinematic") {
		lateral_controller_ptr_  = std::move(std::unique_ptr<LateralController> (new LateralKinematicController(nh_)));
	} else if(lateral_controller_type == "pbc") {
        lateral_controller_ptr_  = std::move(std::unique_ptr<LateralController> (new LateralPBCController(nh_)));
    }else {
		ROS_ERROR("undefined lateral controller, setting to kinematic controller");
		lateral_controller_ptr_  = std::move(std::unique_ptr<LateralController> (new LateralKinematicController(nh_)));
	}

	controller_processing_ptr_ = std::move(std::unique_ptr<ControllerProcessing>(new ControllerProcessing));
}

void ControllerCore::SubscribeTrajectoryCallback(const av_msgs::Trajectory &trajectory) {
    trajectory_ = trajectory;
	trajectory_ready_ = true;
	replanning_steps_ = 0;
}

void ControllerCore::SubscribeLocalizeCallback(const av_msgs::Localize &localize){
    localize_ = localize;
	localize_ready_ = true;
}

void ControllerCore::SubscribeGatewayCallback(const std_msgs::String &gateway_msg){
    gateway_msg_ = gateway_msg.data;
	gateway_ready_ = true;
}

}

int main(int argc, char** argv) {
    ros::init(argc, argv, "control_node");
    ros::NodeHandle nh;
    av_control::ControllerCore controller(nh);
    controller.Start();
    return 0;
}
