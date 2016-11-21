#include<ros/ros.h>
#include<av_control/longitudinal_controller.h>

using namespace std;
using namespace av_control;

LongitudinalController::LongitudinalController() : debug_(false), simulation_(false), time_scale_(50),  control_mode_(true){
	loadParams();
}

void LongitudinalController::loadParams() {
	ros::param::get("~/debug", debug_);	
	ros::param::get("~/simulation", simulation_);
	ros::param::get("~/time_scale", time_scale_);
	
}

void LongitudinalController::SelectDesiredPose(const av_msgs::Trajectory &trajectory, const uint64_t &time, av_msgs::Pose &desired_pose){
	std::vector<av_msgs::Pose>::const_iterator iter_pose;
	uint64_t min_time_diff = 1e6, time_diff = 0;
	int desired_pose_index = 0;
	for(iter_pose = trajectory.poses.begin(); iter_pose < trajectory.poses.end(); iter_pose++) {
		if(time < iter_pose->timestamp) {
			time_diff = iter_pose->timestamp - time;
		} else {
			time_diff = time - iter_pose->timestamp;
		}
		if (time_diff < min_time_diff){
			min_time_diff = time_diff;
			desired_pose = *(iter_pose);
			desired_pose_index = iter_pose - trajectory.poses.begin();
		}
	}
}

