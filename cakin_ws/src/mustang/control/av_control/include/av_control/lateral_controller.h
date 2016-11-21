#ifndef MUSTANG_AV_CONTROL_LATERAL_CONTROLLER_H
#define MUSTANG_AV_CONTROL_LATERAL_CONTROLLER_H
#include <av_msgs/Trajectory.h>
#include <av_control/controller_comm.h>
#include <deque>
namespace av_control {

class LateralController {
public:
	LateralController();

	virtual enum ErrorCode GenerateControlSignal(const av_msgs::Trajectory &trajectory, const VehicleState &vehicle_state, const uint64_t &time, double &steer_signal, double &ref_curvature, bool replanning_flag) = 0;

protected:

    bool simulation_;
    bool debug_;
    //vehicle parameters
    double road_friction_coef_, vehicle_mass_, front_axle_cog_distance_, rear_axle_cog_distance_, front_tire_cornering_stiff_, rear_tire_cornering_stiff;

	void GetLateralControlError(const std::vector<av_msgs::Pose>& ref_poses, const VehicleState& vehicle_state, double& e_pos, double& e_ang, double& e_pos_current, double& e_ang_current, double &ref_curvature);

private:
	const static int max_list_size_ = 50;
	double preview_time_;

	void GetPreviewState(const VehicleState& raw_state, VehicleState& preview_state);

	void GetAscendingPoseIndex(const std::vector<av_msgs::Pose> &ref_pose_vector, const VehicleState &vehicle_state, std::vector<int>& indexes);

	double GetProportionalFactor(const std::vector<av_msgs::Pose> &ref_pose_vector, const int nearest_1_index, const int nearest_2_index, const VehicleState &vehicle_state);

	double GetLateralPositionError(const std::vector<av_msgs::Pose>& ref_pose_vector, const int nearest_1_index, const int nearest_2_index, const double k, const VehicleState &vehicle_state);

	double GetLateralAngleError(const std::vector<av_msgs::Pose>& ref_pose_vector, const int nearest_1_index, const int nearest_2_index, const double k, const VehicleState &vehicle_state);

    double GetLateralCurvature(const std::vector<av_msgs::Pose> &ref_pose_vector, const int nearest_1_index, const int nearest_2_index, const double k);
};

} // namespace av_control

#endif
