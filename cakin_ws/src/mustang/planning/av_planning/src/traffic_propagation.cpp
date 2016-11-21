#include <ros/ros.h>

#include <av_planning/traffic_propagation.h>

#include <cmath>
#include <vector>
#include <thread>
#include <sys/time.h>

using namespace av_planning;

TrafficPropagation::TrafficPropagation() {
    LoadConfiguration();
}

enum ErrorCode TrafficPropagation::InferRiskMap(const PlanningFusionMap &planning_fusion_map,
                                                std::vector<RiskMap> &certain_risk_maps,
                                                std::vector<RiskMap> &uncertain_risk_maps) {
    std::vector<std::vector<BoxModelPose> > mdl_trajectories;
    std::vector<PossibleTrajectory> possible_trajectories;
    // TODO need to distinguish vechicle, pedestrain and bike 
    for(auto iter =  planning_fusion_map.dynamic_object_list.begin(); 
                iter != planning_fusion_map.dynamic_object_list.end(); ++iter) {
        std::vector<BoxModelPose> mdl_trajectory;
        if(0 != PredictVehicleTrajectory(*iter, 
                                         planning_fusion_map.lane_group_list,
                                         mdl_trajectory, 
                                         possible_trajectories)) {
            return ErrorCode::ERROR;
        }
        mdl_trajectories.push_back(mdl_trajectory);
    }
    // using low resolution to speed up
    if(0 != SetCertainRiskMaps(mdl_trajectories, 
                               planning_fusion_map.low_resolution_static_obstacle_map, 
                               certain_risk_maps)) {
        return ErrorCode::ERROR;
    }
    if(0 != SetUncertainRiskMaps(possible_trajectories, 
                                 planning_fusion_map.low_resolution_static_obstacle_map, 
                                 uncertain_risk_maps)) {
        return ErrorCode::ERROR;
    }
    return ErrorCode::SUCCESS;
}

int TrafficPropagation::PredictVehicleTrajectory(
            const av_msgs::DynamicObstacle &vechicle_object,
            const std::vector<LaneGroup> lane_group_list,
            std::vector<BoxModelPose> &mdl_trajectory, 
            std::vector<PossibleTrajectory> &possible_trajectories) {
    if(0 != MdlModel(vechicle_object, mdl_trajectory)) {
        return -1;
    }
    if(0 != HMMModel(vechicle_object, lane_group_list, possible_trajectories)) {
        return -2;
    }
    return 0;
}

int TrafficPropagation::MdlModel(const av_msgs::DynamicObstacle &dynamic_object, 
                                  std::vector<BoxModelPose> &mdl_trajectory) {
    // check parameters
    if(0 != mdl_trajectory.size()) {
        return -1;
    }
    // load the box model of dynamic object 
    double x = dynamic_object.center_x;
    double y = dynamic_object.center_y;
    double theta = dynamic_object.heading; 
    double v = dynamic_object.velocity;
    double a = dynamic_object.acceleration; 
    double w = dynamic_object.omega;

    // TODO print all vechicle info
    //std::cout << "before translate:x " << x << " y " << y << " theta " << theta << " v " << v << " a " << a << " w " << w 
    //          << " width " << dynamic_object.width << " length " << dynamic_object.length << std::endl; 

    // for 0 to 2 s, step is 100ms
    double start_time = certain_trajectory_start_time_;
    double end_time = certain_trajectory_end_time_;
    double step_time = certain_trajectory_step_;
    double delta_time = 0;
    while(start_time + delta_time <= end_time) {
        BoxModelPose cur_pose;
        cur_pose.width = dynamic_object.width;
        cur_pose.length = dynamic_object.length;
        if(0 != MdlImplementation(x, y, theta, v, a, w, delta_time, cur_pose)) {
            return -2;
        }
    
        //std::cout << "Mdl detail:x" << cur_pose.x << " y " << cur_pose.y << " theta_t " << cur_pose.theta << std::endl; 

        mdl_trajectory.push_back(cur_pose); 
        delta_time += step_time;
    }
    return 0;
}

int TrafficPropagation::MdlImplementation(double x, double y, double theta, 
                                          double v, double a, double w, 
                                          double delta_t, 
                                          BoxModelPose &pose) {
    // ms to s
    double t = delta_t / 1000;
    double theta_t = theta + w * t;
    double v_t = v + a * t;
    double x_t, y_t;
    if(0 != w) {
        x_t = x + 1.0 / (w * w) * ((v * w + a * w * t) * sin(theta_t) + a * cos(theta_t) - v * w * sin(theta) - a * cos(theta));
        y_t = y + 1.0 / (w * w) * ((-1.0 * v * w - a * w * t) * cos(theta_t) + a * sin(theta_t) + v * w * cos(theta) - a * sin(theta)); 
    }
    else {
        x_t = (0.5 * a * t * t + v * t) * cos(theta) + x;
        y_t = (0.5 * a * t * t + v * t) * sin(theta) + y;
    }
    pose.x = x_t;
    pose.y = y_t;
    pose.theta = theta_t;
    pose.propagation_time = delta_t;

    return 0;
}

int TrafficPropagation::SetCertainRiskMaps(
                       const std::vector<std::vector<BoxModelPose> > &mdl_trajectories,
                       const std::vector<std::vector<double> > static_obstacle_map, 
                       std::vector<RiskMap> &certain_risk_maps) {
    double start_time = certain_trajectory_start_time_;
    double end_time = certain_trajectory_end_time_;
    double step_time = certain_trajectory_step_; 
    double delta_time = 0;
    int shifting = 0;

    struct timeval tv1,tv2;
    struct timeval start, end;
    struct timezone tz1, tz2;
    double timeuse;
    // init certain_risk_maps 
    gettimeofday(&tv1, &tz1);

    while(start_time + delta_time <= end_time) {
        //std::vector<std::vector<double> > cur_map(static_obstacle_map);
        RiskMap cur_risk_map;
        cur_risk_map.propagation_time = start_time + delta_time; 
        certain_risk_maps.push_back(cur_risk_map);

//        certain_risk_maps.back().risk_map = static_obstacle_map;
        ++shifting;
        delta_time = shifting * step_time;     
    }
    
    gettimeofday(&tv2, &tz2);
    timeuse = tv2.tv_sec - tv1.tv_sec + (tv2.tv_usec - tv1.tv_usec)/1000000.0;
    //ROS_INFO("init certain_risk_maps use time:%f", timeuse);

    // thread
    gettimeofday(&tv1, &tz1);

    std::vector<std::thread> thread_list;
    start_time = certain_trajectory_start_time_;
    end_time = certain_trajectory_end_time_;
    step_time = certain_trajectory_step_; 
    delta_time = 0;
    shifting = 0;
    while(start_time + delta_time <= end_time) {
        thread_list.emplace_back(SetCertainRiskMapsThread,
                                 std::ref(mdl_trajectories),
                                 std::ref(certain_risk_maps[shifting].risk_map),
                                 std::ref(static_obstacle_map),
                                 shifting,
                                 this);
        ++shifting;
        delta_time = shifting * step_time;     
    }
    for(auto iter = thread_list.begin(); iter != thread_list.end(); ++iter) {
        iter->join();
    }
    
    gettimeofday(&tv2, &tz2);
    timeuse = tv2.tv_sec - tv1.tv_sec + (tv2.tv_usec - tv1.tv_usec)/1000000.0;
    //ROS_INFO("collision thread use time:%f", timeuse);

    return 0;
}

void TrafficPropagation::SetCertainRiskMapsThread(const std::vector<std::vector<BoxModelPose> > &mdl_trajectories,
                                                  std::vector<std::vector<double> > &cur_map,
                                                  const std::vector<std::vector<double> > &static_obstacle_map,
                                                  int shifting,
                                                  TrafficPropagation *tp){
    cur_map = static_obstacle_map;
    for(auto trajectory_iter = mdl_trajectories.begin(); trajectory_iter != mdl_trajectories.end(); ++ trajectory_iter) {
        std::vector<RectangleCorner> rectangle_corner_list;
        if(0 != tp->risk_helper_.BoxCorner(trajectory_iter->at(shifting), 
                                           tp->resolution_, 
                                           rectangle_corner_list)) {
            return; 
        }
        if(0 != tp->FillStaticMap(rectangle_corner_list, cur_map) ){
            return;
        }
    }
}

int TrafficPropagation::FillStaticMap(const std::vector<RectangleCorner> &rectangle_corner_list, 
                                      std::vector<std::vector<double> > &cur_map) {
    for(auto iter = rectangle_corner_list.begin(); iter != rectangle_corner_list.end(); ++iter) {
        for(int i = iter->x_min; i <= iter->x_max; ++i) {
            for(int j = iter->y_min; j <= iter->y_max; ++j) {
                cur_map[i][j] = 1;
            }
        }
    }
    return 0;
}


void TrafficPropagation::LoadConfiguration() {
    ros::param::get("~/traffic_propagation/certain_trajectory_start_time", 
                    certain_trajectory_start_time_);
    ros::param::get("~/traffic_propagation/certain_trajectory_end_time",
                    certain_trajectory_end_time_);
    ros::param::get("~/traffic_propagation/certain_trajectory_step",
                    certain_trajectory_step_);
    ros::param::get("~/traffic_propagation/resolution",
                    resolution_);
}

// TODO 
int TrafficPropagation::HMMModel(const av_msgs::DynamicObstacle &dynamic_object, 
                                 const std::vector<LaneGroup> &lane_group_list,
                                 std::vector<PossibleTrajectory> &possible_trajectories) {
    return 0;
}

int TrafficPropagation::SetUncertainRiskMaps(const std::vector<PossibleTrajectory> &possible_trajectories,
                                             const std::vector<std::vector<double> > static_obstacle_map,
                                             std::vector<RiskMap> &uncertain_risk_maps) {
    return 0;
}
