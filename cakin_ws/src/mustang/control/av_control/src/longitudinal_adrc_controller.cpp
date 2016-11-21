#include <ros/ros.h>
#include <av_control/longitudinal_adrc_controller.h>
#include <av_control/fir_filter.h>
#include <vector>
#include <cmath>
#include <fstream>
#include <std_msgs/String.h>
#include <av_control/json.hpp>

using namespace std;
using namespace av_control;
using json = nlohmann::json;

LongitudinalADRCController::LongitudinalADRCController(ros::NodeHandle& nh):rate_(0), pd_u(0), temp_sef_u(0), td_v1_(0), td_v2_(0), eso_z1_(0), eso_z2_(0), eso_z3_(0), eso_z4_(0), eso_u_(0), sef_u_(0), longitudinal_preview_time_(0){
     ros::param::get("~control_rate", rate_);
	 ros::param::get("~/longitudinal_ADRC_controller/ratio_acc_pedal", ratio_acc_pedal_);
     ros::param::get("~/longitudinal_ADRC_controller/ratio_brake_pedal", ratio_brake_pedal_);
	 ros::param::get("~/longitudianl_ADRC_controller/max_acc_pedal", max_acc_pedal_); 
     ros::param::get("~/longitudinal_ADRC_controller/threshold_acc2brake", threshold_acc2brake_);
     ros::param::get("~/longitudinal_ADRC_controller/threshold_brake2acc", threshold_brake2acc_);
     ros::param::get("~/longitudinal_ADRC_controller/td_r", td_r_);
     ros::param::get("~/longitudinal_ADRC_controller/td_h", td_h_);
     ros::param::get("~/longitudinal_ADRC_controller/eso_h", eso_h_);
     ros::param::get("~/longitudinal_ADRC_controller/eso_b01", eso_b01_);
     ros::param::get("~/longitudinal_ADRC_controller/eso_b02", eso_b02_);
     ros::param::get("~/longitudinal_ADRC_controller/eso_b03", eso_b03_);
     ros::param::get("~/longitudinal_ADRC_controller/eso_b04", eso_b04_);
     ros::param::get("~/longitudinal_ADRC_controller/eso_b0", eso_b0_);
     ros::param::get("~/longitudinal_ADRC_controller/eso_a01", eso_a01_);
     ros::param::get("~/longitudinal_ADRC_controller/eso_a02", eso_a02_);
     ros::param::get("~/longitudinal_ADRC_controller/eso_a03", eso_a03_);
     ros::param::get("~/longitudinal_ADRC_controller/eso_a04", eso_a04_); 
     ros::param::get("~/longitudinal_ADRC_controller/eso_h0", eso_h0_);
     ros::param::get("~/longitudinal_ADRC_controller/sef_a01", sef_a01_);
     ros::param::get("~/longitudinal_ADRC_controller/sef_a02", sef_a02_);
     ros::param::get("~/longitudinal_ADRC_controller/sef_h0", sef_h0_);     
     ros::param::get("~/longitudinal_ADRC_controller/sef_b0", sef_b0_);
     ros::param::get("~/longitudinal_ADRC_controller/sef_kp", sef_kp_);     
     ros::param::get("~/longitudinal_ADRC_controller/sef_kd", sef_kd_);    

	 ros::param::get("~/longitudinal_ADRC_controller/longitudinal_preview_time",longitudinal_preview_time_ );

	 pub_adrc = nh.advertise<std_msgs::String>("av_control/control_debug/adrc",rate_);
}

enum ErrorCode LongitudinalADRCController::GenerateControlSignal(const av_msgs::Trajectory &current_trajectory ,const VehicleState &current_vehicle_state, const uint64_t &time, double &acc_pedal, double &brake_pedal, bool replanning_flag) {
	av_msgs::Pose desired_pose_;
	
	SelectDesiredPose(current_trajectory, time + int(1000*longitudinal_preview_time_),desired_pose_);
		
	double current_velocity_ = current_vehicle_state.vel_x;
	double origin_velocity_ = current_velocity_;
	
	TrackingDifference(current_vehicle_state, desired_pose_, time, td_v1_, td_v2_, replanning_flag);
	if(control_mode_)
		eso_u_ = acc_pedal / ratio_acc_pedal_;
	else
		eso_u_ = brake_pedal / ratio_brake_pedal_;
	
///	InputFilter(current_velocity_);

	ExtendingStateObserver(current_velocity_, eso_u_, eso_z1_,eso_z2_, eso_z3_, eso_z4_ );

	
	StateErrorFeedback(td_v1_ ,td_v2_, eso_z1_, eso_z2_,eso_z3_, eso_z4_,sef_u_, replanning_flag);

//	OutputFilter(sef_u_);
	DetermineControlMode(sef_u_, acc_pedal, brake_pedal);
	if(debug_){
		json j = {
			{ "adrc", {
				{{"name", "origin_velocity"}, {"value", origin_velocity_}},
				{{"name", "filter_velocity"}, {"value", current_velocity_}},
 				{{"name", "desired_velocity"}, {"value", desired_pose_.velocity}},
                {{"name", "current_acceleration"}, {"value", current_vehicle_state.acc_x}},
 				{{"name", "td_v1"}, {"value", td_v1_}},
 				{{"name", "td_v2"}, {"value", td_v2_}},
 				{{"name", "eso_u"}, {"value", eso_u_}},
 				{{"name", "eso_z1"}, {"value", eso_z1_}},
 				{{"name", "eso_z2"}, {"value", eso_z2_}},
 				{{"name", "eso_z3"}, {"value", eso_z3_}},
 				{{"name", "eso_z4"}, {"value", eso_z4_}},
 				{{"name", "sef_u"}, {"value", sef_u_}},
			}}
		};
		std_msgs::String msg;
		msg.data = j.dump();
		pub_adrc.publish(msg);
	}	
	if(record_){
		record.open("control/longitudinal_adrc_control/record_td.txt", std::fstream::in | std::fstream::out | std::fstream::app);
		record << time <<","<<desired_pose_.velocity<<","<<td_v1_<<","<<td_v2_<<"\n";
		record.close();	

		record.open("control/longitudinal_adrc_control/record_eso.txt", std::fstream::in | std::fstream::out | std::fstream::app);
		record << time <<","<<current_velocity_<<","<<eso_z1_<<","<<eso_z2_<<","<<eso_z3_<<","<<eso_z4_ <<"\n";
		record.close();				

		record.open("control/longitudinal_adrc_control/record_sef.txt", std::fstream::in | std::fstream::out | std::fstream::app);
		record << time <<sef_u_<<"\n";
		record.close();
	}
		
	return ErrorCode::SUCCESS;
}

void LongitudinalADRCController::TrackingDifference(const VehicleState &vehicle_state, const av_msgs::Pose &desired_pose, const uint64_t &time, double &td_v1, double &td_v2, bool &replanning_flag){
	td_v1 = desired_pose.velocity;		

	if(simulation_){
		td_v2 = desired_pose.acceleration;
	} else{
		td_v2  = desired_pose.acceleration;
	}
}

void LongitudinalADRCController::ExtendingStateObserver(const double &velocity, const double &eso_u, double &eso_z1,double &eso_z2, double &eso_z3, double &eso_z4 ){
	double e, g1, g2, g3,g4;
	double temp_z1 = eso_z1;
	double temp_z2 = eso_z2;
	double temp_z3 = eso_z3;
	double temp_z4 = eso_z4;

	e = temp_z1 - velocity;
	fal(e, eso_a01_, eso_h0_, g1);
	fal(e, eso_a02_, eso_h0_, g2);
	fal(e, eso_a03_, eso_h0_, g3);
	fal(e, eso_a04_, eso_h0_, g4);
	
	eso_z1 = temp_z1 + (temp_z2 -eso_b01_ * g1)*eso_h_;
	eso_z2 = temp_z2 + (temp_z3 -eso_b02_ * g2)*eso_h_;
	eso_z3 = temp_z3 + (temp_z4 - eso_b03_ * g3 + eso_b0_ * eso_u)*eso_h_;
	eso_z4 = temp_z4 + (-eso_b04_ * g4)*eso_h_;
}

void LongitudinalADRCController::StateErrorFeedback(const double &td_v1 ,const double &td_v2, const double &eso_z1, const double &eso_z2, const double &eso_z3,const double &eso_z4,double &sef_u, bool &replanning_flag){
	double temp_pd_u = 0, delta_pd_u = 0;

	double fal_p, fal_d;
	double e1, e2;

	e1 = td_v1 - eso_z1;
	e2 = td_v2 - eso_z3;
	fal(e1, sef_a01_, sef_h0_, fal_p);
	fal(e2, sef_a02_, sef_h0_, fal_d);
	
	temp_pd_u = pd_u;
	pd_u = sef_kp_ * fal_p + sef_kd_ * fal_d;
	delta_pd_u = pd_u - temp_pd_u;
	
	if (delta_pd_u < 0) delta_pd_u = 3 * delta_pd_u;

	if(replanning_flag)
	{
		temp_sef_u = temp_sef_u + delta_pd_u;
	} else {
	}
	
    sef_u = temp_sef_u - eso_z4/eso_b0_;
}

void LongitudinalADRCController::DetermineControlMode(double &sef_u_, double &acc_pedal, double &brake_pedal){
/*	if(control_mode_  && sef_u_ < threshold_acc2brake_) {
		control_mode_ = false;
	} else if(!control_mode_ && sef_u_ > threshold_brake2acc_) {
		control_mode_ = true;
	}
*/	
	if(sef_u_ >= 0 ) {
		acc_pedal = sef_u_ * ratio_acc_pedal_;
		brake_pedal = 0;
        control_mode_ = 1;
	} else {
		brake_pedal = -sef_u_ * ratio_brake_pedal_;
		acc_pedal = 0;
        control_mode_ = 0;
	}
	acc_pedal = acc_pedal < 0 ? 0 : acc_pedal;
	brake_pedal = brake_pedal < 0 ? 0 : brake_pedal;
}

int LongitudinalADRCController::Sign(const double &d){
	if(d < 0){
		return -1;
	}
	else if(d == 0){
		return 0;
	}
	else{
		return 1;
	}
}

void LongitudinalADRCController::fal(const double &e, const double &a, const double &h, double &fal){
	if (fabs(e) > h){
		fal = pow(fabs(e), a) * Sign(e); 
	}
	else{
		fal = e/pow(h, (1-a));
	}
}

