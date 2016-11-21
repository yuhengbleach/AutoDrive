#ifndef MUSTANG_AV_CONTROL_LONGITUDINAL_PID_POS_CONTROLLER_H
#define MUSTANG_AV_CONTROL_LONGITUDINAL_PID_POS_CONTROLLER_H
#include <av_msgs/Trajectory.h>
#include <av_control/controller_comm.h>
#include <av_control/longitudinal_pos_controller.h>

namespace av_control {

class LongitudinalPIDPosController : public LongitudinalPosController{
public:
	LongitudinalPIDPosController(ros::NodeHandle& nh);

	enum ErrorCode GenerateControlSignal(const av_msgs::Trajectory &trajectory, const VehicleState &vehicle_state, const uint64_t &time, double &acc_pedal, double &brake_pedal, bool replanning_flag = false);

private:
    int rate_;
    ros::Publisher pub_longitudinal_pid_pos;
    double pos_gain_p_, pos_gain_i_, pos_gain_d_, vel_gain_p_, vel_gain_i_, vel_gain_d_;
    double ratio_acc_pedal_, ratio_brake_pedal_;
    double pos_loop_output_, vel_loop_output_;
    double e_pos_index_1, e_pos_index_2, e_vel_index_1, e_vel_index_2;
    double e_pos_min_;
    bool is_reached_, is_overstep_;
    double vel_initial, e_pos_initial, deceleration_ratio;
    double final_brake_;

    void GetPosLoopOutput(const double &e_pos, double &desired_velocity, bool &replanning_flag);
    void GetVelLoopOutput(const double &desired_velocity, const double &current_velocity, double &vel_loop_output, bool &replanning_flag);
    void DetermineControlMode(const double &e_pos, const double &velocity, const double &vel_loop_output, double &acc_pedal, double &brake_pedal);
};

} // namespace av_control

#endif
