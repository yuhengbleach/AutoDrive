#ifndef MUSTANG_AV_CONTROL_LONGITUDINAL_CONTROLLER_H
#define MUSTANG_AV_CONTROL_LONGITUDINAL_CONTROLLER_H
#include <av_msgs/Trajectory.h>
#include <av_control/controller_comm.h>
#include <av_control/fir_filter.h>
#include <deque>

namespace av_control {

class LongitudinalController {
public:
	LongitudinalController();

	virtual enum ErrorCode GenerateControlSignal(const av_msgs::Trajectory &trajectory, const VehicleState &vehicle_state, const uint64_t &time, double &acc_pedal, double &brake_pedal, bool replanning_flag = false) = 0;
	
protected:
	//compute desire value
	void SelectDesiredPose(const av_msgs::Trajectory &trajectory, const uint64_t &time, av_msgs::Pose &desired_pose);
	bool debug_, record_, simulation_;
	int time_scale_;
	bool control_mode_; // true: acceleration mode, false: brake mode
	double max_acc_pedal_;
	double ratio_acc_pedal_, ratio_brake_pedal_;
	double threshold_acc2brake_, threshold_brake2acc_;

private:
	const static int max_list_size_ = 50;
	void loadParams();
};

} // namespace av_control

#endif
