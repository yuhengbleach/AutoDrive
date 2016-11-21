/***********************************************
Copyright@ 2015 DIDI RESEARCH. All right reserved
File Name: feature_extraction.cpp
Description: 
Author: peili - lipeilp@didichuxing.com
Create Date: 2016-08-24 21:15:57
Last modified: 2016-08-24 21:15:57
GCC release: 4.4.6
**************************************************/ 

#include <av_planning/feature_extraction.h>
#include <assert.h>

namespace av_planning {

FeatureExtraction::FeatureExtraction() : 
    min_dist_(10),
    min_width_delta_(0.3),
    vehicle_a_(4.9),
    center_x_index_(499),
    center_y_index_(499) {
    ros::param::get("~feature_extracion/min_dist", min_dist_);
    ros::param::get("~feature_extraction/min_width", min_width_delta_);
    ros::param::get("~ego_a", vehicle_a_);
    ros::param::get("~ego_length", vehicle_length_);
    ros::param::get("~ego_width", vehicle_width_);
    ros::param::get("~ego_max_v", vehicle_max_v_);
    ros::param::get("~static_obstacle_map_center_x", center_x_index_);
    ros::param::get("~static_obstacle_map_center_y", center_y_index_);
    ros::param::get("~debug_flag", debug_flag_);
}

enum ErrorCode FeatureExtraction::ExtractManeuverFeature(const PlanningFusionMap &planning_fusion_map,
                                               Path &path,
                                               const av_msgs::TrafficLightDetect &traffic_light,
                                               const av_msgs::Dest &dest,
                                               const av_msgs::Localize &localize,
                                               std::vector<int> &feature_list,
                                               BasicManeuver &basic_maneuver) {
    
    CheckData(planning_fusion_map, path, traffic_light, dest, localize);
    
    //lane flag 
    int lane_flag = path.GetSectionIndex(localize.pose_x, localize.pose_y).second;
    
    if (ErrorCode::ERROR == CalCurrentLane(planning_fusion_map.lane_group_list, basic_maneuver.current_lane)) {
        return ErrorCode::ERROR;
    }

    if (debug_flag_) {
        ROS_INFO("current lane: %d", (int)basic_maneuver.current_lane);
    }
    
    // lane mark feature processing
    std::vector<int>lane_mark_feature;
    if (ErrorCode::ERROR == CalLaneMarkFeature(planning_fusion_map.lane_group_list,basic_maneuver.current_lane , lane_flag, lane_mark_feature)) {
        ROS_ERROR("Calculate lane mark feature is failed!");
        return ErrorCode::ERROR;
    }
    feature_list.insert(feature_list.end(), lane_mark_feature.begin(), lane_mark_feature.end());
    
    //debug
    if (debug_flag_) {
        for (int i = 0; i < lane_mark_feature.size(); ++i) {
            ROS_INFO("lane mark feature: %d %d", i, lane_mark_feature[i]);
        }   
    }
     
    // cal obstacle dist 
    std::vector<double>static_obstacle_dist_list;
    CalStaticObstacleDist(planning_fusion_map.static_obstacle_map, planning_fusion_map.lane_group_list, static_obstacle_dist_list);
    
    //debug
    if (debug_flag_) {
        for (int i =0; i < static_obstacle_dist_list.size(); ++i) {
            ROS_INFO("static obstacle dist: %d %f", i, static_obstacle_dist_list[i]);
        } 
    }
    
    std::vector<DynamicObstacleDist>dynamic_obstacle_dist_list;
    CalDynamicObstacleDist(planning_fusion_map.dynamic_object_list, planning_fusion_map.lane_group_list, dynamic_obstacle_dist_list);
        
    //debug
    if (debug_flag_) {
        for (int i =0; i < dynamic_obstacle_dist_list.size(); ++i) {
            ROS_INFO("dynamic obstacle dist: %d %d %f %d %f", i, dynamic_obstacle_dist_list[i].front_obstacle_id, dynamic_obstacle_dist_list[i].front_obstacle_dist, dynamic_obstacle_dist_list[i].back_obstacle_id, dynamic_obstacle_dist_list[i].back_obstacle_dist);
        }
    }
    
    double current_v = sqrt(localize.vel_x * localize.vel_x + 
                            localize.vel_y * localize.vel_y + 
                            localize.vel_z * localize.vel_z);
    
    //debug
    if (debug_flag_) {
        ROS_INFO("current v: %f", current_v);
    }
    
    if (lane_flag == 1) {
        std::vector<int>lane_obstacle_feature;
        CalLaneObsatcleFeature(static_obstacle_dist_list, dynamic_obstacle_dist_list, planning_fusion_map.lane_group_list, current_v, basic_maneuver.current_lane, lane_obstacle_feature);
        feature_list.insert(feature_list.end(), lane_obstacle_feature.begin(), lane_obstacle_feature.end()); 
    
    } else {
        std::vector<int>obstacle_feature(12, 0);
        feature_list.insert(feature_list.end(), obstacle_feature.begin(), obstacle_feature.end());
    }
    
    std::vector<int>dest_feature;
    CalDestFeature(dest, localize, path, current_v, dest_feature);
    feature_list.insert(feature_list.end(), dest_feature.begin(), dest_feature.end());
    
    //debug
    if (debug_flag_) {
        ROS_INFO("Dest Feature: %d", dest_feature[0]);
    }
    //intersection rule feature precessing
    std::vector<int>intersection_rule_feature;
    CalIntersectionRuleFeature(path, localize, traffic_light, basic_maneuver.current_lane, intersection_rule_feature);
    feature_list.insert(feature_list.end(), intersection_rule_feature.begin(), intersection_rule_feature.end());
    
    if (debug_flag_) {
        for (int i = 0; i < intersection_rule_feature.size(); ++ i) {
            ROS_INFO("intersection rule feature: %d", intersection_rule_feature[i]);
        }
    }
    
    if (lane_flag = 0) {
        std::vector<int>intersection_obstacle_feature;
        CalIntersectionObstacleFeature(static_obstacle_dist_list, dynamic_obstacle_dist_list, current_v, intersection_obstacle_feature);
        feature_list.insert(feature_list.end(), intersection_obstacle_feature.begin(), intersection_obstacle_feature.end());
        IntersectionLaneSelection(planning_fusion_map.lane_group_list, static_obstacle_dist_list, dynamic_obstacle_dist_list, current_v, basic_maneuver.current_lane, basic_maneuver.lane_group_list);         
        basic_maneuver.stopline_distance = -1;
            
    } else {
        std::vector<int>intersection_obstacle_feature(2, 0);
        feature_list.insert(feature_list.end(), intersection_obstacle_feature.begin(), intersection_obstacle_feature.end());
        LaneSelection(planning_fusion_map.lane_group_list, static_obstacle_dist_list, dynamic_obstacle_dist_list, current_v, basic_maneuver.current_lane, basic_maneuver.lane_group_list);         
        basic_maneuver.stopline_distance = path.GetDistInSection(localize.pose_x, localize.pose_y);
    }
    
    //basic maneuver processing
    CalBasicManeuver(localize, planning_fusion_map.lane_group_list, path, planning_fusion_map.dynamic_object_list, dynamic_obstacle_dist_list, static_obstacle_dist_list, dest, basic_maneuver); 
    
    return ErrorCode::SUCCESS;
}

void FeatureExtraction::CheckData(const PlanningFusionMap &planning_fusion_map,
                                  Path &path,
                                  const av_msgs::TrafficLightDetect &traffic_light,
                                  const av_msgs::Dest &dest,
                                  const av_msgs::Localize &localize) {
    
    //check fusion map 
    assert(planning_fusion_map.lane_group_list.size() != 0);
    assert(planning_fusion_map.lane_group_list[0].lanes.size() != 0);
    
    //check path
    assert(path.edges.size() != 0);
    
    //check traffic_light, dest, localize to do 
}

enum ErrorCode FeatureExtraction::CalLaneMarkFeature(const std::vector<LaneGroup>lane_group_list,
                                                    const int current_lane,
                                                    const int lane_flag,
                                                    std::vector<int> &lane_mark_feature) {
    lane_mark_feature.resize(4, 0);
     
    //intersection lane mark feature processing
    if (!lane_flag) {
        return ErrorCode::SUCCESS; 
    }

    //others' lane mark feature processing
    switch(lane_group_list[current_lane].lanes[0].left_line.paint_type) {
        case 0:
            lane_mark_feature[0] = 1;
            break;
        case 1:
            lane_mark_feature[2] = 1; 
            break;
    }
     
    switch(lane_group_list[current_lane].lanes[0].right_line.paint_type) {
        case 0:
            lane_mark_feature[1] = 1;
            break;
        case 1:
            lane_mark_feature[3] = 1; 
            break;
    }
    return ErrorCode::SUCCESS;
}

void FeatureExtraction::CalIntersectionRuleFeature(Path &path,
                                                   const av_msgs::Localize &localize,
                                                   const av_msgs::TrafficLightDetect &traffic_light,
                                                   const int current_lane,
                                                   std::vector<int> &intersection_rule_feature) {
    intersection_rule_feature.resize(7, 0);
    double dist = path.GetDistInSection(localize.pose_x, localize.pose_y);
    if(dist > 0 && dist < 10) {
        intersection_rule_feature[0] = 1;
    }
    auto section_pair = path.GetSectionIndex(localize.pose_x, localize.pose_y);
    if (section_pair.second == 0) {
        intersection_rule_feature[1] = 1;
    }
    
    if (path.edges[section_pair.first].traffic_light_flag == 1) {
        intersection_rule_feature[2] = 1;
        if(traffic_light.tl_det_list.size() != 0 && section_pair.first != path.edges.size() - 1) {  
            std::vector<int>traffic_light_status;
            CalTrafficLightStatus(traffic_light, traffic_light_status);
            int from_id = path.edges[section_pair.first].sectionEdge_id;
            int to_id = path.edges[section_pair.first + 1].sectionEdge_id;
            if (traffic_light_status[path.nodes[section_pair.first].turn_info_[from_id][to_id]->turn_type_] == 1) {
                intersection_rule_feature[3] = 1;
            }
        }
    }
    
    if (section_pair.second == 1) {
        if (section_pair.first != path.edges.size() - 1) {
            int from_id = path.edges[section_pair.first].sectionEdge_id;
            int to_id = path.edges[section_pair.first + 1].sectionEdge_id;
            int current_turn = path.nodes[section_pair.first].turn_info_[from_id][to_id]->turn_type_;
            std::vector<int>temp_lane;
            for (auto turn_pair : path.edges[section_pair.first].exits) {
                if(current_turn == turn_pair.first) {
                    for (int lane_index = 0; lane_index < path.edges[section_pair.first].lanemarkers.size(); ++lane_index) {
                        if (path.edges[section_pair.first].lanemarkers[lane_index]->waypoints.back().first == turn_pair.second.first.lat &&
                            path.edges[section_pair.first].lanemarkers[lane_index]->waypoints.back().second == turn_pair.second.first.lon
                            ) {
                            temp_lane.push_back(lane_index);
                        }
                        
                        if (path.edges[section_pair.first].lanemarkers[lane_index]->waypoints.back().first == turn_pair.second.second.lat &&
                            path.edges[section_pair.first].lanemarkers[lane_index]->waypoints.back().second == turn_pair.second.second.lon ) {
                            temp_lane.push_back(lane_index - 1);
                        }
                    }

                    for (int lane_index = temp_lane[0]; lane_index <= temp_lane[1]; ++ lane_index) {
                        if (lane_index == current_lane) {
                            intersection_rule_feature[4] = 1;
                        } 
                        if (lane_index < current_lane) {
                            intersection_rule_feature[5] = 1;
                        }
                        if (lane_index > current_lane) {
                            intersection_rule_feature[6] = 1;
                        }
                    }
                }
            }
        }
    }

}

void FeatureExtraction::CalLaneObsatcleFeature(const std::vector<double> &static_obstacle_dist_list,
                                                 const std::vector<DynamicObstacleDist> &dynamic_obstacle_dist_list,
                                                 const std::vector<LaneGroup> &lane_group_list,
                                                 const double current_v,
                                                 const int current_lane,
                                                 std::vector<int> &lane_obstacle_feature) {
    std::vector<double>lane_static_obstacle_dist_list(lane_group_list.size(), 100);
    int index = 0;
    for(int lane_index = 0; lane_index < lane_group_list.size(); ++lane_index) {
        for(int index_delta = 0; index_delta < lane_group_list[lane_index].lanes.size(); ++index_delta) {
            if (lane_static_obstacle_dist_list[lane_index] == 100 || 
               (lane_static_obstacle_dist_list[lane_index] < 100 && 
               static_obstacle_dist_list[index] > lane_static_obstacle_dist_list[lane_index])) {
                lane_static_obstacle_dist_list[lane_index] = static_obstacle_dist_list[index];
            }
            ++ index;
        }
    }
    
    std::vector<DynamicObstacleDist> lane_dynamic_obstacle_dist_list(lane_group_list.size());
    index = 0;
    for (int lane_index = 0; lane_index < lane_group_list.size(); ++lane_index) {
        lane_dynamic_obstacle_dist_list[lane_index].front_obstacle_id = -1; 
        lane_dynamic_obstacle_dist_list[lane_index].back_obstacle_id = -1;
        lane_dynamic_obstacle_dist_list[lane_index].front_obstacle_dist = 100; 
        lane_dynamic_obstacle_dist_list[lane_index].back_obstacle_dist = -50;
        for (int index_delta = 0; index_delta < lane_group_list[lane_index].lanes.size(); ++ index_delta) {
            if (dynamic_obstacle_dist_list[index].front_obstacle_dist >= 0 && dynamic_obstacle_dist_list[index].front_obstacle_dist < 100) {
                if (lane_dynamic_obstacle_dist_list[lane_index].front_obstacle_dist == 100 ||
                    dynamic_obstacle_dist_list[index].front_obstacle_dist > lane_dynamic_obstacle_dist_list[lane_index].front_obstacle_dist) {
                    lane_dynamic_obstacle_dist_list[lane_index].front_obstacle_dist = dynamic_obstacle_dist_list[index].front_obstacle_dist;
                    lane_dynamic_obstacle_dist_list[lane_index].front_obstacle_id = dynamic_obstacle_dist_list[index].front_obstacle_id;
                }
            } else if (dynamic_obstacle_dist_list[lane_index].back_obstacle_dist < 0 && dynamic_obstacle_dist_list[index].back_obstacle_dist > -50) {
                if (lane_dynamic_obstacle_dist_list[lane_index].back_obstacle_dist == -50 ||
                    dynamic_obstacle_dist_list[index].back_obstacle_dist < lane_dynamic_obstacle_dist_list[lane_index].back_obstacle_dist) {
                    lane_dynamic_obstacle_dist_list[lane_index].back_obstacle_dist = dynamic_obstacle_dist_list[index].back_obstacle_dist;
                    lane_dynamic_obstacle_dist_list[lane_index].back_obstacle_id = dynamic_obstacle_dist_list[index].back_obstacle_id;
                }
            }
            ++ index;
        }
    }
    
    std::vector<double> front_min_dist_list(lane_group_list.size(), 100);
    for (int lane_index = 0; lane_index < lane_group_list.size(); ++lane_index) {
        if(lane_static_obstacle_dist_list[lane_index] < lane_dynamic_obstacle_dist_list[lane_index].front_obstacle_dist) {
            front_min_dist_list[lane_index] = lane_static_obstacle_dist_list[lane_index];
            lane_dynamic_obstacle_dist_list[lane_index].front_obstacle_dist = 100;
        } else {
            front_min_dist_list[lane_index] = lane_dynamic_obstacle_dist_list[lane_index].front_obstacle_dist;
            lane_static_obstacle_dist_list[lane_index] = 100;
        }
    }
    
    std::vector<int> static_obstacle_feature;
    CalStaticObstacleFeature(lane_static_obstacle_dist_list, current_lane, current_v, static_obstacle_feature);
    lane_obstacle_feature.insert(lane_obstacle_feature.begin(), static_obstacle_feature.begin(), static_obstacle_feature.end());
    
    std::vector<int> dynamic_obstacle_feature;
    CalDynamicObstacleFeature(lane_dynamic_obstacle_dist_list, current_lane, current_v, dynamic_obstacle_feature);
    lane_obstacle_feature.insert(lane_obstacle_feature.begin(), dynamic_obstacle_feature.begin(), dynamic_obstacle_feature.end());
    
    for (int i = 0; i < 4; ++i) {
        lane_obstacle_feature.push_back(0);
    }

    int feature_index = 8;
    for (int i = -1; i < 2; i+= 2) {
        if (current_lane + i >= 0 && current_lane + i < front_min_dist_list.size()) {
            if (front_min_dist_list[current_lane + i] < front_min_dist_list[current_lane]) {
                lane_obstacle_feature[feature_index] = 1;
            }
        }
        feature_index ++;
    }
    
    double lane_change_min_dist = std::max(vehicle_length_, current_v);
    if (front_min_dist_list[current_lane] < lane_change_min_dist) {
        lane_obstacle_feature[feature_index] = 1;
    }
    feature_index ++;

    if (dynamic_obstacle_dist_list[current_lane].back_obstacle_dist < lane_change_min_dist) {
        lane_obstacle_feature[feature_index] = 1;
    }
}

void FeatureExtraction::CalStaticObstacleFeature(const std::vector<double> &static_obstacle_dist_list,
                                                 const int current_lane,
                                                 const double current_v,
                                                 std::vector<int> &static_obstacle_feature) {
    
    static_obstacle_feature.resize(3, 0);
    double safe_dist = (current_v * current_v) / (2 * vehicle_a_) + min_dist_;
    int feature_index = 0;
    if (static_obstacle_dist_list[current_lane] - vehicle_length_ / 2 <= safe_dist) {
        static_obstacle_feature[feature_index] = 1;
    }
    feature_index ++;
    for(int i = -1; i < 2; i += 2) {
        if (current_lane + i >= 0 && current_lane + i < static_obstacle_dist_list.size()) {
            if (static_obstacle_dist_list[current_lane + i] - vehicle_length_ / 2 <= safe_dist) {
                static_obstacle_feature[feature_index] = 1;
            }
        }
        feature_index ++;
    }
}

void FeatureExtraction::CalDynamicObstacleFeature(const std::vector<DynamicObstacleDist> &dynamic_obstacle_dist_list,
                                                  const int current_lane,
                                                  const double current_v,
                                                  std::vector<int> &dynamic_obstacle_feature) {
    
    dynamic_obstacle_feature.resize(5, 0);
    double front_safe_dist = 2 * current_v + min_dist_;
    double back_safe_dist = -20;
    int feature_index = 0;
    
    if (dynamic_obstacle_dist_list[current_lane].front_obstacle_dist <= front_safe_dist) {
        dynamic_obstacle_feature[feature_index] = 1;
    }
    feature_index ++;
    for(int i = -1; i < 2; i += 2) {
        feature_index = i == -1? feature_index : feature_index + 2; 
        if (current_lane + i >= 0 && current_lane + i < dynamic_obstacle_dist_list.size()) {
            if (dynamic_obstacle_dist_list[current_lane + i].front_obstacle_dist <= front_safe_dist) {
                dynamic_obstacle_feature[feature_index] = 1;
            }

            if (dynamic_obstacle_dist_list[current_lane + i].back_obstacle_dist >= back_safe_dist) {
                dynamic_obstacle_feature[feature_index + 1] = 1;
            }
        }
    }
}

void FeatureExtraction::CalIntersectionObstacleFeature(const std::vector<double> &static_obstacle_dist_list,
                                                       const std::vector<DynamicObstacleDist> &dynamic_obstacle_dist_list,
                                                       const double current_v,
                                                       std::vector<int> &intersection_obstacle_feature) {
    intersection_obstacle_feature.resize(2, 0);
    double static_safe_dist = (current_v * current_v) / (2 * vehicle_a_) + min_dist_;
    int lane_num = 0;
    for (int index = 0; index < static_obstacle_dist_list.size(); ++index) {
        if (static_obstacle_dist_list[index] < static_safe_dist) {
            ++ lane_num;
        }
    }
    
    if (lane_num == static_obstacle_dist_list.size()) {
        intersection_obstacle_feature[0] = 1;
    }
    
    double front_safe_dist = 2 * current_v + min_dist_;
    double back_safe_dist = -5;
    lane_num = 0;
    for (int index = 0; index < dynamic_obstacle_dist_list.size(); ++index) {
        if(dynamic_obstacle_dist_list[index].front_obstacle_dist < front_safe_dist ||
           dynamic_obstacle_dist_list[index].back_obstacle_dist > back_safe_dist) {
            ++ lane_num; 
        }    
    }

    if (lane_num == dynamic_obstacle_dist_list.size()) {
        intersection_obstacle_feature[1] = 1;        
    }
}

void FeatureExtraction::CalDestFeature(const av_msgs::Dest &dest,
                                       const av_msgs::Localize &localize,
                                       Path &path,
                                       const double current_v,
                                       std::vector<int> &dest_feature) {
    dest_feature.resize(1, 0);
    double static_obstacle_safe_dist = current_v * current_v / (2 * vehicle_a_) + min_dist_;
    LatLong start_coordinate(localize.pose_x, localize.pose_y);
    LatLong dest_coordinate(dest.x, dest.y);
    double dest_dist = path.GetDistInLastSection(start_coordinate, dest_coordinate);  
    if (dest_dist > 0 && dest_dist < static_obstacle_safe_dist) {
        dest_feature[0] = 1;
    }
}

void FeatureExtraction::CalBasicManeuver(const av_msgs::Localize &localize,
                                         const std::vector<LaneGroup> &lane_group_list,
                                         Path &path,
                                         const std::vector<av_msgs::DynamicObstacle> &dynamic_obstacle_list,
                                         const std::vector<DynamicObstacleDist> &dynamic_obstacle_dist_list,
                                         const std::vector<double> &static_obstacle_dist_list,
                                         const av_msgs::Dest &dest,
                                         BasicManeuver &basic_maneuver) {    
    
    int section_index = path.GetSectionIndex(localize.pose_x, localize.pose_y).second;
    basic_maneuver.section_v = std::min(path.edges[section_index].speedlimit, vehicle_max_v_);
    
    int index = 0;
    for (int lane_index = 0; lane_index < basic_maneuver.current_lane; ++lane_index) {
        index += lane_group_list[lane_index].lanes.size();        
    }
    int current_index = index;
    double max_dynamic_front_obstacle_dist = 0;
    for (int delta = 0; delta < lane_group_list[basic_maneuver.current_lane].lanes.size(); ++ delta) {
        if (max_dynamic_front_obstacle_dist < dynamic_obstacle_dist_list[index].front_obstacle_dist) {
            max_dynamic_front_obstacle_dist = dynamic_obstacle_dist_list[index].front_obstacle_dist;
            current_index = index;
        }
        ++ index;
    }
    if (dynamic_obstacle_dist_list[current_index].front_obstacle_id >= 0) {
        basic_maneuver.front_vehicle_v = std::min((double)dynamic_obstacle_list[dynamic_obstacle_dist_list[current_index].front_obstacle_id].velocity, basic_maneuver.section_v);
        basic_maneuver.keep_distance = max_dynamic_front_obstacle_dist;
    } else {
        basic_maneuver.front_vehicle_v = vehicle_max_v_;
        basic_maneuver.keep_distance = 100;
    }
    

    index -= lane_group_list[basic_maneuver.current_lane].lanes.size();
    double max_static_obstacle_dist = 0;
    for (int delta = 0; delta < lane_group_list[basic_maneuver.current_lane].lanes.size(); ++ delta) {
        if (max_static_obstacle_dist < static_obstacle_dist_list[index]) {
            max_static_obstacle_dist = static_obstacle_dist_list[index];
        }
        ++ index;
    }
    
    if (max_static_obstacle_dist < 5) {
        basic_maneuver.stop_distance = max_static_obstacle_dist * 0.7;
    } else if (max_static_obstacle_dist < 15) {
        basic_maneuver.stop_distance = max_static_obstacle_dist - 3;
    } else {
        basic_maneuver.stop_distance = max_static_obstacle_dist - 5;
    }

    LatLong start_coordinate(localize.pose_x, localize.pose_y);
    LatLong dest_coordinate(dest.x, dest.y);
    basic_maneuver.dest_distance = path.GetDistInLastSection(start_coordinate, dest_coordinate);
    
    if (basic_maneuver.dest_distance < 0) {
        basic_maneuver.dest_distance = 100;
    }

}


void FeatureExtraction::CalStaticObstacleDist(const std::vector<std::vector<double> > &static_obstacle_list,
                                              const std::vector<LaneGroup> &lane_group_list,
                                              std::vector<double> &static_obstacle_dist_list) {
    for (int lane_index = 0; lane_index < lane_group_list.size(); ++lane_index) {
        for (int index = 0; index < lane_group_list[lane_index].lanes.size(); ++index) {
            double left_s;
            double right_s;
            double s_delta = 0;
            double dist;
            
            spline::getClosestPointOnCurve(lane_group_list[lane_index].lanes[index].left_line.curve_x, lane_group_list[lane_index].lanes[index].left_line.curve_y, 
                0, 0, left_s, dist);
                    
            for (; s_delta < lane_group_list[lane_index].lanes[index].left_line.length - left_s; s_delta += 0.2) {
                double left_x = lane_group_list[lane_index].lanes[index].left_line.curve_x(left_s + s_delta);
                double left_y = lane_group_list[lane_index].lanes[index].left_line.curve_y(left_s + s_delta);
              
                spline::getClosestPointOnCurve(lane_group_list[lane_index].lanes[index].right_line.curve_x, lane_group_list[lane_index].lanes[index].right_line.curve_y, 
                    left_x, left_y, right_s, dist);
             
                double right_x = lane_group_list[lane_index].lanes[index].right_line.curve_x(right_s);
                double right_y = lane_group_list[lane_index].lanes[index].right_line.curve_y(right_s);
            
                int left_x_index = (int) (round(left_x * 10)) + center_x_index_;
                int left_y_index = (int) (round(left_y * 10)) * -1 + center_y_index_;
                int right_x_index = (int) (round(right_x * 10)) + center_x_index_;
                int right_y_index = (int) (round(right_y * 10)) * -1 + center_y_index_;
                
                if(left_x_index < 0 || left_x_index > 1499 ||
                   left_y_index < 0 || left_y_index > 999 || 
                   right_x_index < 0 || right_x_index > 1499 ||
                   right_y_index < 0 || right_y_index > 999) {
                
                   s_delta -= 0.2;
                   break;
                }
                
                int x_max_len = abs(left_x_index - right_x_index) + 1;
                int y_max_len = abs(left_y_index - right_y_index) + 1;
                int len = std::max(x_max_len, y_max_len);
                int sign_x_flag = left_x_index < right_x_index? 1: -1;
                int sign_y_flag = left_y_index < right_y_index? 1: -1;
                
                double max_width = 0.0;
                double lane_width = 0.0;
                
                if (x_max_len >= y_max_len) {
                    int x_index = 1;
                    for (int y_index = 1; y_index <= y_max_len; ++ y_index) {
                        int x_len = std::min((int)round(y_index * (x_max_len * 1.0) / y_max_len), x_max_len);
                        for (; x_index <= x_len; ++ x_index) {
                            if (static_obstacle_list[left_y_index + (y_index - 1) * sign_y_flag ][left_x_index + (x_index -1) * sign_x_flag] == 0) {
                                lane_width += dist / len;
                            } else if (static_obstacle_list[left_y_index + (y_index - 1) * sign_y_flag ][left_x_index + (x_index -1) * sign_x_flag] > 0) {
                                if (lane_width > max_width) {
                                    max_width = lane_width;
                                }
                                lane_width = 0;
                            }
                        }
                    }

                } else {
                    int y_index = 1;
                    for (int x_index = 1; x_index <= x_max_len; ++ x_index) {
                        int y_len = std::min((int)round(x_index * (y_max_len * 1.0) / x_max_len), y_max_len);
                        for (; y_index <= y_len; ++ y_index) {
                            if (static_obstacle_list[left_y_index + (y_index - 1) * sign_y_flag][left_x_index + (x_index -1) * sign_x_flag] == 0) {
                                lane_width += dist / len;
                            } else if (static_obstacle_list[left_y_index + (y_index - 1) * sign_y_flag][left_x_index + (x_index -1) * sign_x_flag] > 0) {
                                if (lane_width > max_width) {
                                    max_width = lane_width;
                                }
                                lane_width = 0;
                            }
                        }
                    }
                }

                if (lane_width > max_width) {
                    max_width = lane_width;
                }
                
                if (max_width < vehicle_width_ + min_width_delta_) {
                    break;
                }
            }
            s_delta -= vehicle_length_ / 2;
            static_obstacle_dist_list.push_back(s_delta);
        }
    }
}

void FeatureExtraction::CalDynamicObstacleDist(const std::vector<av_msgs::DynamicObstacle> &dynamic_obstacle_list,
                                               const std::vector<LaneGroup> &lane_group_list,
                                               std::vector<DynamicObstacleDist> &dynamic_obstacle_dist_list) {
    
    // cal vehicle's lane and dist
    std::vector<double>current_lane_mark_s_list;
    for(int lane_index = 0; lane_index < lane_group_list.size(); ++ lane_index) {        
        for(int index = 0; index < lane_group_list[lane_index].lanes.size(); ++ index) {
            double left_dist;
            double s;
            spline::getClosestPointOnCurve(lane_group_list[lane_index].lanes[index].left_line.curve_x, lane_group_list[lane_index].lanes[index].left_line.curve_y, 
                0, 0, s, left_dist);
            current_lane_mark_s_list.push_back(s);
            DynamicObstacleDist dynamic_obstacle_dist;
            dynamic_obstacle_dist.front_obstacle_id = -1;
            dynamic_obstacle_dist.back_obstacle_id = -1;
            dynamic_obstacle_dist.front_obstacle_dist = 100;
            dynamic_obstacle_dist.back_obstacle_dist = -50;
            dynamic_obstacle_dist_list.push_back(dynamic_obstacle_dist);
        }
    }
     
    for(int id = 0; id < dynamic_obstacle_list.size(); ++ id) {
        if (dynamic_obstacle_list[id].velocity < 0.01) {
            continue;
        }
        
        std::vector<int> lane_id_list;
        std::vector<double> lane_s_list;
        for(int lane_index = 0; lane_index < lane_group_list.size(); ++lane_index) {
            for(int index = 0; index < lane_group_list[lane_index].lanes.size(); ++index) {
                double left_dist;
                double right_dist;
                double s;
                spline::getClosestPointOnCurve(lane_group_list[lane_index].lanes[index].right_line.curve_x, lane_group_list[lane_index].lanes[index].right_line.curve_y, 
                    dynamic_obstacle_list[id].center_x, dynamic_obstacle_list[id].center_y, s, right_dist);
                spline::getClosestPointOnCurve(lane_group_list[lane_index].lanes[index].left_line.curve_x, lane_group_list[lane_index].lanes[index].left_line.curve_y, 
                    dynamic_obstacle_list[id].center_x, dynamic_obstacle_list[id].center_y, s, left_dist);
                if (left_dist < lane_group_list[lane_index].lanes[index].width && right_dist < lane_group_list[lane_index].lanes[index].width) {
                    lane_id_list.push_back(lane_index);
                    lane_s_list.push_back(s);
                }
            }
        }

        for (int index = 0; index < lane_id_list.size(); ++ index) { 
            int lane_id = lane_id_list[index];
            double lane_s = lane_s_list[index];
            double current_obstacle_dist = lane_s - current_lane_mark_s_list[lane_id] - dynamic_obstacle_list[id].length / 2 - vehicle_length_ / 2;
            if (current_obstacle_dist >= 0 && current_obstacle_dist < dynamic_obstacle_dist_list[lane_id].front_obstacle_dist) {
                dynamic_obstacle_dist_list[lane_id].front_obstacle_dist = current_obstacle_dist;
                dynamic_obstacle_dist_list[lane_id].front_obstacle_id =  id;
            } else if (current_obstacle_dist < 0 && current_obstacle_dist > dynamic_obstacle_dist_list[lane_id].back_obstacle_dist) {
                dynamic_obstacle_dist_list[lane_id].back_obstacle_dist = current_obstacle_dist;
                dynamic_obstacle_dist_list[lane_id].back_obstacle_id = id;
            }
        }
    }
     
}

void FeatureExtraction::CalTrafficLightStatus(const av_msgs::TrafficLightDetect &traffic_light,
                                              std::vector<int> &traffic_light_status) { 
    if (traffic_light.tl_det_list.size() == 0) {
        return;
    }
    traffic_light_status.resize(3, 0);
    for (int index = 0; index < traffic_light.tl_det_list.size(); index ++) {
        switch(traffic_light.tl_det_list[index].type) {
            case 1:
                if (traffic_light.tl_det_list[index].status == 2) {
                    traffic_light_status[0] = 1;
                    traffic_light_status[1] = 1;
                }
                traffic_light_status[2] = 1;
                break;
            
            case 2:
                if (traffic_light.tl_det_list[index].status == 2) {
                    traffic_light_status[0] = 1;
                }
                break;
            
            case 3:
                if (traffic_light.tl_det_list[index].status == 2) {
                    traffic_light_status[1] = 1;    
                }
                break;
            
            case 4:
                if (traffic_light.tl_det_list[index].status == 2) {
                    traffic_light_status[2] = 1;
                }
                break;
        }
    }
}

enum ErrorCode FeatureExtraction::CalCurrentLane(const std::vector<LaneGroup> &lane_group_list, 
                                       int &current_lane) {
    current_lane = -1;
    double min_left_dist = 1e6;
    double left_index = -1;

    for (int lane_index = 0; lane_index < lane_group_list.size(); ++ lane_index) {        
        for (int index = 0; index < lane_group_list[lane_index].lanes.size(); ++ index) {
            double left_dist;
            double right_dist;
            double s;
            spline::getClosestPointOnCurve(lane_group_list[lane_index].lanes[index].left_line.curve_x, lane_group_list[lane_index].lanes[index].left_line.curve_y, 
                0, 0, s, left_dist);
            spline::getClosestPointOnCurve(lane_group_list[lane_index].lanes[index].right_line.curve_x, lane_group_list[lane_index].lanes[index].right_line.curve_y, 
                0, 0, s, right_dist);

            if (min_left_dist < left_dist) {
                min_left_dist = left_dist;
                left_index = lane_index;
            }   
            if (left_dist <= lane_group_list[lane_index].lanes[index].width && right_dist <= lane_group_list[lane_index].lanes[index].width) {
                current_lane = lane_index;
                break;
            }
        }
    }
    
    if (current_lane == -1) {
        current_lane = left_index;
    }

    if (current_lane == -1) {
        ROS_ERROR("Calculate current lane is failed!");
        return ErrorCode::ERROR;
    }
    return ErrorCode::SUCCESS;

}

void FeatureExtraction::IntersectionLaneSelection(const std::vector<LaneGroup> &lane_group_list,
                                                  const std::vector<double> &static_obstacle_dist_list,
                                                  const std::vector<DynamicObstacleDist> &dynamic_obstacle_dist_list,
                                                  const double current_v,
                                                  const double current_lane,
                                                  std::vector<LaneGroup> &selected_lane_group_list) {
    selected_lane_group_list.resize(1);
    double static_safe_dist = (current_v * current_v) / (2 * vehicle_a_) + min_dist_;
    double front_safe_dist = 2 * current_v + min_dist_;
    double back_safe_dist = -5;
    int index = 0;
    int best_lane_group = -1;
    int best_lane_index = -1;
    int max_dist = 0;

    for (int lane_index = 0; lane_index < lane_group_list.size(); ++ lane_index) {
        for (int index_delta = 0; index_delta < lane_group_list[lane_index].lanes.size(); ++index_delta) {
            if (static_obstacle_dist_list[index] > static_safe_dist &&
                dynamic_obstacle_dist_list[index].front_obstacle_dist > front_safe_dist &&
                dynamic_obstacle_dist_list[index].back_obstacle_dist < back_safe_dist) {
                double dist = std::max(static_obstacle_dist_list[index], dynamic_obstacle_dist_list[index].front_obstacle_dist);
                if (dist > max_dist) {
                    max_dist = dist;
                    best_lane_index = index_delta;
                    best_lane_group = lane_index;
                }
            }
            ++ index;
        }
    }
     
    if (best_lane_index == -1 || best_lane_group == -1) {
        selected_lane_group_list[0] = lane_group_list[current_lane];
    } else {
        selected_lane_group_list[0].lanes.push_back(lane_group_list[best_lane_group].lanes[best_lane_index]);
    }
}

void FeatureExtraction::LaneSelection(const std::vector<LaneGroup> &lane_group_list,
                                     const std::vector<double> &static_obstacle_dist_list,
                                     const std::vector<DynamicObstacleDist> &dynamic_obstacle_dist_list,
                                     const double current_v,
                                     const double current_lane,
                                     std::vector<LaneGroup> &selected_lane_group_list) {
    
    selected_lane_group_list.resize(lane_group_list.size());
    double static_safe_dist = (current_v * current_v) / (2 * vehicle_a_) + min_dist_;
    double front_safe_dist = 2 * current_v + min_dist_;
    double back_safe_dist = -5;
    int index = 0;
     
    for (int lane_index = 0; lane_index < lane_group_list.size(); ++ lane_index) {
        int best_lane_index = -1;
        int max_dist = 0;
        
        for (int index_delta = 0; index_delta < lane_group_list[lane_index].lanes.size(); ++index_delta) {
            double dist = std::max(static_obstacle_dist_list[index], dynamic_obstacle_dist_list[index].front_obstacle_dist);
            if (dist > max_dist) {
                 max_dist = dist;
                best_lane_index = index_delta;
            }
            ++ index;
        }
        
        if (best_lane_index != -1) {
            selected_lane_group_list[lane_index].lanes.push_back(lane_group_list[lane_index].lanes[best_lane_index]); 
        }
     
    }

}


}

