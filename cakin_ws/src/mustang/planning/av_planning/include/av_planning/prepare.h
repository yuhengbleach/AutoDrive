#ifndef MUSTANG_AV_PLANNING_PREPARE_H
#define MUSTANG_AV_PLANNING_PREPARE_H

#include <ros/ros.h>
#include <av_comm/comm.h>
#include <av_msgs/FusionMap.h>
#include <av_msgs/Trajectory.h>
#include <av_msgs/Dest.h>
#include <av_msgs/Localize.h>
#include <av_msgs/DynamicObstacle.h>
#include <av_msgs/GridMap.h>
#include <av_msgs/TrafficLightDetect.h>
#include <av_planning/planning_comm.h>
#include <av_planning/spline.h>
#include <av_planning/global_planning/Path.h>

#include <vector>

namespace av_planning {

// Spline fit of lane curves
struct ParameterLane {
    av_planning::spline curve_x, curve_y;
    double length;
    int paint_type;
};

struct Lane {
	ParameterLane left_line, right_line, ref_line;
	double length, width;
};

struct LaneGroup {
	std::vector<Lane> lanes;
	int label;
};

struct PlanningFusionMap {
    std::vector<av_msgs::DynamicObstacle> dynamic_object_list;
    std::vector<std::vector<double> > static_obstacle_map;
    std::vector<std::vector<double> > low_resolution_static_obstacle_map;
    std::vector<LaneGroup> lane_group_list;
};

const static double PI = 3.1415926;

//preprocessing data and check messages
class Prepare {
public:
    Prepare();
    ~Prepare() {};

public:
    //set message's initial timestamp
    void SetFusionMapTimestamp(const av_msgs::FusionMap &fusion_map);
    void SetTrafficLightTimestamp(const av_msgs::TrafficLightDetect &traffic_light);
    void SetDestTimestamp(av_msgs::Dest &dest);
    void SetLocalizeTimestamp(const av_msgs::Localize &localize);

    //check message
    enum ErrorCode CheckFusionMapMsgs(const av_msgs::FusionMap &fusion_map);
    enum ErrorCode CheckDestMsgs(const av_msgs::Dest &dest);
    enum ErrorCode CheckTrafficLightMsgs(av_msgs::TrafficLightDetect &traffic_light);
    enum ErrorCode CheckLocalizeMsgs(const av_msgs::Localize &localize);

    // coordinate system conversion
    void TranslateFusionMap(av_msgs::FusionMap &fusion_map);
    
    void TranslateFusionMapPrescan(av_msgs::FusionMap &fusion_map);
    
    void PreprocessFusionMap(const av_msgs::FusionMap &fusion_map, Path &path, PlanningFusionMap &planning_fusion_map);

private:
    // coordinate helper
    void TranslatePose(double &x, double &y, double &theta);
    void TranslatePose(double &x, double &y);
    void TranslateEgo(double x_ego, double y_ego, double theta_ego, double &x, double &y);

private:
    void PrepareLaneList(const std::vector<av_msgs::SectionList>& section_list, const int current_section_id, std::vector<LaneGroup>& lane_group_list);

	void PrepareLocalLaneList(std::vector<av_msgs::SectionList>::const_iterator& iter_section, const std::vector<av_msgs::SectionList>::const_iterator& iter_section_end, std::vector<Lane>& lane_list);

	void PrepareLocalLaneCombination(const Lane& lane_1, const Lane& lane_2, Lane& lane);

	void PrepareLocalLineCombination(const ParameterLane& line_1, const ParameterLane& line_2, ParameterLane& line);
	    
    void PrepareStaticObstacleMap(const av_msgs::GridMap& obstacle_map, std::vector<std::vector<double> >& static_obstacle_map);

    void PrepareLowResolutionStaticObstacleMap(std::vector<std::vector<double> >& static_obstacle_map,
                                               std::vector<std::vector<double> >& low_resolution_static_obstacle_map);

private:

    double threshold_lane_confidence_;
	double threshold_line_combination_;
	double interp_delta_length_, interp_delta_angle_;

     
    uint64_t fusion_map_timestamp_;
    uint64_t localize_timestamp_;
    uint64_t dest_timestamp_;
    uint64_t traffic_light_timestamp_;
    
    int localize_timedelta_;
    int traffic_light_timedelta_;

    double traffic_propogation_resolution_;
};

} // namespace av_planning

#endif // MUSTANG_AV_PLANNING_PREPARE_H
