#ifndef MUSTANG_AV_CONTROL_LONGITUDINAL_POS_CONTROLLER_H
#define MUSTANG_AV_CONTROL_LONGITUDINAL_POS_CONTROLLER_H
#include <av_msgs/Trajectory.h>
#include <av_control/controller_comm.h>
#include <av_control/fir_filter.h>
#include <deque>

namespace av_control {

class LongitudinalPosController {
public:
	LongitudinalPosController();

	virtual enum ErrorCode GenerateControlSignal(const av_msgs::Trajectory &trajectory, const VehicleState &vehicle_state, const uint64_t &time, double &acc_pedal, double &brake_pedal, bool replanning_flag = false) = 0;
	
protected:
	//compute desire value
	bool debug_, record_, simulation_;
	bool control_mode_; // true: acceleration mode, false: brake mode

    void GetPosControlError(const std::vector<av_msgs::Pose> &ref_poses, const VehicleState &vehicle_state, double &e_pos);
 
private:
	void loadParams();
    void GetAscendingPoseIndex(const std::vector<av_msgs::Pose> &ref_poses, const VehicleState &vehicle_state, std::vector<int>& indexes);
    double GetProportionalFactor(const std::vector<av_msgs::Pose> &ref_pose_vector, const int nearest_1_index, const int nearest_2_index, const VehicleState &vehicle_state);
};

} // namespace av_control

#endif
