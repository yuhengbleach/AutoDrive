#ifndef MUSTANG_AV_CONTROL_LONGITUDINAL_PID_CONTROLLER_H
#define MUSTANG_AV_CONTROL_LONGITUDINAL_PID_CONTROLLER_H
#include <av_msgs/Trajectory.h>
#include <av_control/controller_comm.h>
#include <av_control/longitudinal_controller.h>

namespace av_control {

class LongitudinalPIDController : public LongitudinalController{
public:
	LongitudinalPIDController(ros::NodeHandle& nh);

	enum ErrorCode GenerateControlSignal(const av_msgs::Trajectory &trajectory, const VehicleState &vehicle_state, const uint64_t &time, double &acc_pedal, double &brake_pedal, bool replanning_flag = false);

private:
	int rate_;
	ros::Publisher pub_longitudinal_pid;
	double gain_p_, gain_i_, gain_d_;
	double ratio_acc_pedal_, ratio_brake_pedal_;
	double PID_output_, e_vel_index_1, e_vel_index_2;

	void GetControlSignal(const double &desired_velocity, const double &current_velocity, double &PID_output, bool& replanning_flag);
	void DetermineControlMode(const double &PID_output, double &acc_pedal, double &brake_pedal);

};

} // namespace av_control

#endif
