#ifndef MUSTANG_AV_CONTROL_LATERAL_KINEMATIC_CONTROLLER_H
#define MUSTANG_AV_CONTROL_LATERAL_KINEMATIC_CONTROLLER_H
#include <av_msgs/Trajectory.h>
#include <av_control/controller_comm.h>
#include <av_control/lateral_controller.h>
#include <fstream>
#define EPSILON 1

namespace av_control {

class LateralKinematicController : public LateralController{
public:
	LateralKinematicController(ros::NodeHandle &nh);

	enum ErrorCode GenerateControlSignal
	(const av_msgs::Trajectory &trajectory, const VehicleState &vehicle_state, const uint64_t &time, double &steer_signal, double &ref_curvature, bool replanning_flag = false);
	
private:
	ros::Publisher pub_kinematic;

	int rate_;

	double kp_steer_,kd_phi_,steer_ratio_;
	double steer_angle, temp_phi, temp_velocity, temp_e_p;	
	double GetSteeringAngle(const double phi, const double e_p, const VehicleState &vehicle_state, bool &replanning_flag);
	std::fstream record;
};

} // namespace av_control

#endif
