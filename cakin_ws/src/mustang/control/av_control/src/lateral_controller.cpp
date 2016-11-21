#include<ros/ros.h>
#include<av_control/lateral_controller.h>

using namespace std;
using namespace av_control;

LateralController::LateralController():simulation_(true), debug_(true)
{
    ros::param::get("~simulation", simulation_);
    ros::param::get("~debug", debug_);

	ros::param::get("~/lateral_controller/preview_time", preview_time_);

    ros::param::get("~/vehicle_parameters/road_friction_coef", road_friction_coef_); 
    ros::param::get("~/vehicle_parameters/vehicle_mass", vehicle_mass_);
    ros::param::get("~/vehicle_parameters/front_axle_cog_distance", front_axle_cog_distance_);
    ros::param::get("~/vehicle_parameters/rear_axle_cog_distance", rear_axle_cog_distance_);
    ros::param::get("~/vehicle_parameters/front_tire_cornering_stiff", front_tire_cornering_stiff_);
    ros::param::get("~/vehicle_parameters/rear_tire_cornering_stiff", rear_tire_cornering_stiff);
}

void LateralController::GetLateralControlError(const std::vector<av_msgs::Pose>& ref_poses, const VehicleState& vehicle_state, double& e_pos, double& e_ang, double& e_pos_current, double& e_ang_current, double& ref_curvature) {
	std::vector<int> indexes;
	VehicleState preview_state;
	
	GetPreviewState(vehicle_state, preview_state);
	GetAscendingPoseIndex(ref_poses, preview_state, indexes);
	int nearest_1_index = indexes[0];
	int nearest_2_index = indexes[1];

	double k = GetProportionalFactor(ref_poses, nearest_1_index, nearest_2_index, preview_state);
	e_pos = GetLateralPositionError(ref_poses, nearest_1_index, nearest_2_index, k, preview_state);
	e_ang = GetLateralAngleError(ref_poses, nearest_1_index, nearest_2_index, k, preview_state);
       
    std::vector<int> indexes_current;
    GetAscendingPoseIndex(ref_poses, vehicle_state, indexes_current);
 	int nearest_1_index_current = indexes_current[0];
	int nearest_2_index_current = indexes_current[1];  

	double k_current = GetProportionalFactor(ref_poses, nearest_1_index_current, nearest_2_index_current, vehicle_state);
    ref_curvature = GetLateralCurvature(ref_poses, nearest_1_index_current, nearest_2_index_current, k_current);
    e_pos_current = GetLateralPositionError(ref_poses, nearest_1_index_current, nearest_2_index_current, k_current, vehicle_state);
    e_ang_current = GetLateralAngleError(ref_poses, nearest_1_index_current, nearest_2_index_current, k_current, vehicle_state);
 
}

void LateralController::GetPreviewState(const VehicleState& raw_state, VehicleState& preview_state) {
   	const double eps = 1e3;
	double delta_x = 0, delta_y = 0, delta_ang = 0;

	if(raw_state.vel_ang < eps) {
		delta_x = raw_state.vel_x * preview_time_;
	} else{
		delta_ang = raw_state.vel_ang * preview_time_;
		double radius = raw_state.vel_x / raw_state.vel_ang;
		delta_x = radius * sin(delta_ang);
		delta_y = radius * (1 - cos(delta_ang));
	}
    
	double delta_x_t = cos(raw_state.ang) * delta_x - sin(raw_state.ang) * delta_y;
	double delta_y_t = sin(raw_state.ang) * delta_x + cos(raw_state.ang) * delta_y;

	preview_state = raw_state;
	preview_state.x += delta_x_t;
	preview_state.y += delta_y_t;
	preview_state.ang += delta_ang;
    preview_state.vel_x += raw_state.acc_x * preview_time_;
}
 
void LateralController::GetAscendingPoseIndex(const std::vector<av_msgs::Pose> &ref_poses, const VehicleState &vehicle_state, std::vector<int>& indexes) {
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

double LateralController::GetProportionalFactor(const std::vector<av_msgs::Pose> &ref_pose_vector, const int nearest_1_index, const int nearest_2_index, const VehicleState &vehicle_state) {
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
    
double LateralController::GetLateralPositionError(const std::vector<av_msgs::Pose>& ref_pose_vector, const int nearest_1_index, const int nearest_2_index, const double k, const VehicleState &vehicle_state) {
	double current_x_ = vehicle_state.x;
	double current_y_ = vehicle_state.y;
	double current_theta_ = vehicle_state.ang;
	
    double x_1 = ref_pose_vector[nearest_1_index].x;
    double y_1 = ref_pose_vector[nearest_1_index].y;
    double x_2 = ref_pose_vector[nearest_2_index].x;
    double y_2 = ref_pose_vector[nearest_2_index].y;

    double x_0 = x_1 + k * (x_2 - x_1);
    double y_0 = y_1 + k * (y_2 - y_1);
    double temp_x_diff = x_0 - current_x_;
    double temp_y_diff = y_0 - current_y_;
	
    int temp_oriental_flag = 0;
    temp_oriental_flag = (sin(current_theta_) * temp_x_diff - cos(current_theta_) * temp_y_diff >= 0) ? 1 : -1;
    double e_p = temp_oriental_flag * sqrt(pow((current_x_ - x_0), 2) + pow((current_y_ - y_0), 2));
    return e_p; 
}
	
double LateralController::GetLateralAngleError(const std::vector<av_msgs::Pose>& ref_pose_vector, const int nearest_1_index, const int nearest_2_index, const double k, const VehicleState &vehicle_state) {
	double current_theta_ = vehicle_state.ang;
	
    double theta_1 = ref_pose_vector[nearest_1_index].theta;
    double theta_2 = ref_pose_vector[nearest_2_index].theta;
    double expected_theta = theta_1 + k * (theta_2 - theta_1);

	return current_theta_ - expected_theta;
}	


double LateralController::GetLateralCurvature(const std::vector<av_msgs::Pose> &ref_pose_vector, const int nearest_1_index, const int nearest_2_index, const double k){
    
    double curvature_1 = ref_pose_vector[nearest_1_index].curvature;
    double curvature_2 = ref_pose_vector[nearest_2_index].curvature;

    double curvature = curvature_1 + k * (curvature_2 - curvature_1);
     return curvature;
}

