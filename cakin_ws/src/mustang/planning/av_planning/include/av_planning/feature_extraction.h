#ifndef MUSTANG_AV_PLANNING_FEATURE_EXTRACTION_H
#define MUSTANG_AV_PLANNING_FEATURE_EXTRACTION_H

#include <av_msgs/TrafficLight.h>
#include <av_msgs/Dest.h>
#include <av_msgs/Localize.h>

#include <av_planning/planning_comm.h>
#include <av_planning/global_planning/global_planning.h>
#include <av_planning/prepare.h>
#include <av_planning/spline.h>

#include <math.h>
#include <assert.h>
#include <vector>
#include <algorithm>

namespace av_planning {

struct BasicManeuver {
    int current_lane;
    double section_v;
    double front_vehicle_v;
    double keep_distance;
    double stop_distance;
    double stopline_distance;
    double dest_distance;
    std::vector<LaneGroup> lane_group_list;
};

struct DynamicObstacleDist {
    int front_obstacle_id;
    int back_obstacle_id;
    double front_obstacle_dist;
    double back_obstacle_dist;
};

class FeatureExtraction {
public:
    FeatureExtraction();
    ~FeatureExtraction() {};

public:
    enum ErrorCode ExtractManeuverFeature(const PlanningFusionMap &planning_fusion_map,
                                Path &path,
                                const av_msgs::TrafficLightDetect &traffic_light,
                                const av_msgs::Dest &dest,
                                const av_msgs::Localize &localize,
                                std::vector<int> &feature_list,
                                BasicManeuver &basic_maneuver);

private:
    void CheckData(const PlanningFusionMap &planning_fusion_map,
                   Path &path,
                   const av_msgs::TrafficLightDetect &traffic_light,
                   const av_msgs::Dest &dest,
                   const av_msgs::Localize &localize);

    enum ErrorCode CalLaneMarkFeature(const std::vector<LaneGroup>lane_group_list,
                                      const int current_lane, 
                                      const int lane_flag,
                                      std::vector<int> &lane_mark_feature);
    
    void CalIntersectionRuleFeature(Path &path,
                                 const av_msgs::Localize &localize,
                                 const av_msgs::TrafficLightDetect &traffic_light,
                                 const int current_lane,
                                 std::vector<int> &intersection_rule_feature);
    
    void CalLaneObsatcleFeature(const std::vector<double> &static_obsatcle_dist_list,
                                const std::vector<DynamicObstacleDist> &dynamic_obstacle_dist_list,
                                const std::vector<LaneGroup> &lane_group_list,
                                const double current_v,
                                const int current_lane,
                                std::vector<int> &lane_obstacle_feature);

    void CalStaticObstacleFeature(const std::vector<double> &static_obstacle_dist_list,
                                  const int current_lane,
                                  const double current_v,
                                  std::vector<int> &static_obstacle_feature);
   
    void CalDynamicObstacleFeature(const std::vector<DynamicObstacleDist> &dynamic_obstacle_dist_list,
                                   const int current_lane,
                                   const double current_v,
                                   std::vector<int> &dynamic_obstacle_feature);
    
    void CalIntersectionObstacleFeature(const std::vector<double> &static_obstacle_dist_list,
                                        const std::vector<DynamicObstacleDist> &dynamic_obstacle_dist_list,
                                        const double current_v,
                                        std::vector<int> &intersection_obstacle_feature);

    void CalDestFeature(const av_msgs::Dest &dest, 
                        const av_msgs::Localize &localize,
                        Path &path,
                        const double current_v,
                        std::vector<int> &dest_feature);
    
    void CalBasicManeuver(const av_msgs::Localize &localize,
                          const std::vector<LaneGroup> &lane_group_list,
                          Path &path,
                          const std::vector<av_msgs::DynamicObstacle> &dynamic_obstacle_list,
                          const std::vector<DynamicObstacleDist> &dynamic_obstacle_dist_list,
                          const std::vector<double> &static_obstacle_dist_list,
                          const av_msgs::Dest &dest,
                          BasicManeuver &basic_maneuver);

    void CalStaticObstacleDist(const std::vector<std::vector<double> > &static_obstacle_map,
                               const std::vector<LaneGroup> &lane_group_list,
                               std::vector<double> &static_obstacle_dist_list);
    
    void CalDynamicObstacleDist(const std::vector<av_msgs::DynamicObstacle> &dynamic_obstacle_list,
                                const std::vector<LaneGroup> &lane_group_list,
                                std::vector<DynamicObstacleDist> &dynamic_obstacle_dist_list);
    
    enum ErrorCode CalCurrentLane(const std::vector<LaneGroup> &lane_group_list,
                        int &current_lane);
    
    void IntersectionLaneSelection(const std::vector<LaneGroup> &lane_group_list,
                                   const std::vector<double> &static_obsatcle_dist_list,
                                   const std::vector<DynamicObstacleDist> &dynamic_obsatcle_dist_list,
                                   const double current_v,
                                   const double current_lane,
                                   std::vector<LaneGroup> &selected_lane_group_list);

    void LaneSelection(const std::vector<LaneGroup> &lane_group_list,
                       const std::vector<double> &static_obsatcle_dist_list,
                       const std::vector<DynamicObstacleDist> &dynamic_obsatcle_dist_list,
                       const double current_v,
                       const double current_lane,
                       std::vector<LaneGroup> &selected_lane_group_list);
    
    void CalTrafficLightStatus(const av_msgs::TrafficLightDetect &traffic_light,
                               std::vector<int> &traffic_light_status);

private:
    int debug_flag_;

    double min_dist_; 
    double min_width_delta_;

    double vehicle_a_;
    double vehicle_max_v_;
    double vehicle_length_;
    double vehicle_width_;
    
    double center_x_index_;
    double center_y_index_;
};


} // namespace av_planning

#endif // MUSTANG_AV_PLNNING_FEATURE_EXTRACTION_H
