#ifndef MUSTANG_AV_CONTROL_CONTROLLER_PROCESSING_H
#define MUSTANG_AV_CONTROL_CONTROLLER_PROCESSING_H

#include <ros/ros.h>
#include <av_comm/comm.h>
#include <av_msgs/Trajectory.h>
#include <av_msgs/Localize.h>
#include <av_msgs/ControlSignal.h>
#include <av_msgs/VehicleState.h>
#include <av_control/controller_comm.h>
#include <string>
#include <av_control/state_filter.h>

namespace av_control {

class ControllerProcessing {
public:
    ControllerProcessing();
    ~ControllerProcessing() {};

	bool SendControlSignal(double acc_pedal, double brake_pedal, double steering_angle, uint64_t &time);

	void EmergencyStop();

	bool CheckTrajectory(const av_msgs::Trajectory& trajectory);

	void UpdateVehicleState(const av_msgs::Pose& initial_pose, const av_msgs::Localize& localize, const std::string& gateway_msg, VehicleState& vehicle_state, bool gateway_ready);
    
    void SendVehicleState(const double &ref_curvature);

private:
	void transformCoordinate(double x_0, double y_0, double angle_0, double& x, double& y, double& angle);

	void limitControlSignal(double& acc_pedal, double& brake_pedal, double& steering_angle);

	bool parseGatewayMsg(const std::string& gateway_msg, double& vel_x, double& vel_ang, double& acc_x, double& acc_y);


private:
	ros::NodeHandle nh_;
	ros::Publisher pub_vehicle_state_, pub_simulation_, pub_gateway_;
	double limit_acc_pedal_, limit_brake_pedal_, limit_steering_angle_;
	bool simulation_mode_;
	double rate_;
    bool debug_;
    av_msgs::VehicleState vehicle_state_msg;
    
   std::unique_ptr<StateFilter> state_filter_ptr_;
}; // ControllerProcessing

} // namespace av_control

#endif //MUSTANG_AV_CONTROL_CONTROLLER_PROCESSING_H
