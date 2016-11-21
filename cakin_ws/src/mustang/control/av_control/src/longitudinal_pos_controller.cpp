#include<ros/ros.h>
#include<av_control/longitudinal_pos_controller.h>
#include<iostream>
#include<cmath>
using namespace std;
using namespace av_control;

LongitudinalPosController::LongitudinalPosController() : debug_(false), simulation_(false), control_mode_(true){
	loadParams();
}

void LongitudinalPosController::loadParams() {
	ros::param::get("~/debug", debug_);	
	ros::param::get("~/simulation", simulation_);
	
}

void LongitudinalPosController::GetPosControlError(const std::vector<av_msgs::Pose> &ref_poses, const VehicleState &vehicle_state, double &e_pos){
    std::vector<int> indexes;
    GetAscendingPoseIndex(ref_poses, vehicle_state, indexes);
    int nearest_1_index = indexes[0];
    int nearest_2_index = indexes[1];
    double k = GetProportionalFactor(ref_poses, nearest_1_index, nearest_2_index, vehicle_state);
    double x_1 = ref_poses[nearest_1_index].x;
    double y_1 = ref_poses[nearest_1_index].y;
    double x_2 = ref_poses[nearest_2_index].x;
    double y_2 = ref_poses[nearest_2_index].y;

    double x_0 = x_1 + k * (x_2 - x_1);
    double y_0 = y_1 + k * (y_2 - y_1);

    double x_final = ref_poses.back().x;
    double y_final = ref_poses.back().y;

    e_pos = sqrt(pow((x_0 - x_final), 2) + pow((y_0 - y_final), 2));
}


void LongitudinalPosController::GetAscendingPoseIndex(const std::vector<av_msgs::Pose> &ref_poses, const VehicleState &vehicle_state, std::vector<int>& indexes) {
    std::vector<double> distance_diff_vector;
    std::vector<av_msgs::Pose>::const_iterator iter_pose;
    double current_x_ = vehicle_state.x;
    double current_y_ = vehicle_state.y;
    for(iter_pose = ref_poses.begin(); iter_pose != ref_poses.end(); iter_pose++) { 
        double euclidean_square_distance = pow((iter_pose->x - current_x_), 2) + pow((iter_pose->y - current_y_), 2); 
        distance_diff_vector.push_back(euclidean_square_distance);
    }
    indexes.resize(distance_diff_vector.size());
    std::iota(indexes.begin(), indexes.end(), 0);
 
    std::sort(indexes.begin(), indexes.end(), [&distance_diff_vector](int a, int b){ return distance_diff_vector[a] < distance_diff_vector[b]; });
}

double LongitudinalPosController::GetProportionalFactor(const std::vector<av_msgs::Pose> &ref_pose_vector, const int nearest_1_index, const int nearest_2_index, const VehicleState &vehicle_state) {
    double current_x_ = vehicle_state.x;
    double current_y_ = vehicle_state.y;
 
    double x_1 = ref_pose_vector[nearest_1_index].x;
    double y_1 = ref_pose_vector[nearest_1_index].y;
    double x_2 = ref_pose_vector[nearest_2_index].x;
    double y_2 = ref_pose_vector[nearest_2_index].y;

    // Calculate for proportional factor k
    double k = ((current_x_ - x_1) * (x_2 - x_1) + (current_y_ - y_1) * (y_2 - y_1))
                    / (pow((x_2 - x_1), 2) + pow((y_2 - y_1), 2));

    if (k<0) k = 0;
    if (k>1) k = 1;

    return k;
}
