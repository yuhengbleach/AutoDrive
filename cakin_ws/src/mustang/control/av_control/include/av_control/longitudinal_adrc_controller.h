#ifndef MUSTANG_AV_CONTROL_LONGITUDINAL_ADRC_CONTROLLER_H
#define MUSTANG_AV_CONTROL_LONGITUDINAL_ADRC_CONTROLLER_H
#include <av_msgs/Trajectory.h>
#include <av_control/controller_comm.h>
#include <av_control/longitudinal_controller.h>
#include <fstream>
namespace av_control {

class LongitudinalADRCController : public LongitudinalController{
public:
    LongitudinalADRCController(ros::NodeHandle& nh);

	enum ErrorCode GenerateControlSignal(const av_msgs::Trajectory &current_trajectory ,const VehicleState &current_vehicle_state, const uint64_t &time, double &acc_pedal, double &brake_pedal, bool replanning_flag = false);

private:
	ros::Publisher pub_adrc;
	ros::Publisher pub_eso;

	int rate_;
    int td_r_;
    double td_h_;
    double  eso_h_, eso_b01_, eso_b02_, eso_b03_, eso_b04_, eso_b0_, eso_a01_, eso_a02_, eso_a03_, eso_a04_, eso_h0_;
    double sef_a01_, sef_a02_, sef_h0_, sef_b0_, sef_kp_, sef_kd_;
	double td_v1_, td_v2_, eso_u_, eso_z1_,eso_z2_, eso_z3_, eso_z4_, sef_u_;
	
	double longitudinal_preview_time_;	
	double pd_u, temp_sef_u;	
	void TrackingDifference(const VehicleState &vehicle_state, const av_msgs::Pose &desired_pose, const uint64_t &time, double &td_v1, double &td_v2, bool &replanning_flag);
	void  ExtendingStateObserver(const double &velocity, const double &eso_u, double &eso_z1,double &eso_z2, double &eso_z3, double &eso_z4 );
	void StateErrorFeedback(const double &td_v1 ,const double &td_v2, const double &eso_z1, const double &eso_z2, const double &eso_z3, const double &eso_z4,double &sef_u, bool &replanning_flag);

	void DetermineControlMode(double &sef_u_, double &acc_pedal, double &brake_pedal);

	int Sign(const double &d);
	void  fal(const double &e, const double &a, const double &h, double &fal);
	void filter(double &u, double &filter_y);

private:
	//for debug
	std::fstream record;
	
};

}

#endif
