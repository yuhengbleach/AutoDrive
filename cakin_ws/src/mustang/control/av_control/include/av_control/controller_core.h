#ifndef MUSTANG_AV_CONTROL_CONTROLLER_CORE_H
#define MUSTANG_AV_CONTROL_CONTROLLER_CORE_H

#include <ros/ros.h>
#include <av_comm/comm.h>
#include <av_msgs/Trajectory.h>
#include <av_msgs/Localize.h>
#include <av_msgs/ControlSignal.h>
#include <std_msgs/String.h>
#include <av_control/longitudinal_controller.h>
#include <av_control/longitudinal_pos_controller.h>
#include <av_control/lateral_controller.h>
#include <av_control/controller_processing.h>
#include <string>
#include <memory>

namespace av_control {

class ControllerCore {
public:
    ControllerCore(const ros::NodeHandle& nh);
    ~ControllerCore() {};

public:
    void Start();

private:
	void SubscribeLocalizeCallback(const av_msgs::Localize &localize);
	void SubscribeTrajectoryCallback(const av_msgs::Trajectory &trajectory);
	void SubscribeGatewayCallback(const std_msgs::String &gateway_msg);
	
	void ConfigureParams();
	void ConfigureControllers();
private:
    ros::NodeHandle nh_;
    
    //config
	int rate_;
	int localize_queue_size_;
	int trajectory_queue_size_;
	int gateway_queue_size_;

	bool enable_controller_;
	bool trajectory_ready_, localize_ready_, gateway_ready_;
	int replanning_steps_;
	
	
	av_msgs::Trajectory trajectory_;
	av_msgs::Localize localize_;
	std::string gateway_msg_;
	

	std::unique_ptr<LongitudinalController> longitudinal_controller_ptr_;
	std::unique_ptr<LongitudinalPosController> longitudinal_pos_controller_ptr_;
	std::unique_ptr<LateralController> lateral_controller_ptr_;
	std::unique_ptr<ControllerProcessing> controller_processing_ptr_;

}; // ControllerCore

} // namespace av_control

#endif //MUSTANG_AV_CONTROL_CONTROLLER_CORE_H
