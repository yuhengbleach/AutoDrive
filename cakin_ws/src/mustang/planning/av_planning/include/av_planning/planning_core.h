#ifndef MUSTANG_AV_PLANNING_PLANNING_CORE_H
#define MUSTANG_AV_PLANNING_PLANNING_CORE_H

#include <ros/ros.h>
#include <av_comm/comm.h>
#include <av_msgs/FusionMap.h>
#include <av_msgs/TrafficLightDetect.h>
#include <av_msgs/Trajectory.h>
#include <av_msgs/Dest.h>
#include <av_msgs/Localize.h>

// TODO for prescan simulation
#include <av_msgs/SectionList.h>
#include <av_msgs/getLocalLanemarkers.h>

#include <av_planning/planning_comm.h>
#include <av_planning/prepare.h>
#include <av_planning/traffic_propagation.h>
#include <av_planning/feature_extraction.h>
#include <av_planning/global_planning/global_planning.h>
#include <av_planning/maneuver.h>
#include <av_planning/candidate_trajectory.h>
#include <av_planning/risk_assessment.h>
#include <av_planning/trajectory_selection.h>

#include <memory>

namespace av_planning {


class PlanningCore {
public:
    PlanningCore(const ros::NodeHandle& nh);
    ~PlanningCore() {};

public:
    void Start();

private:
    void Init();
    void SubscribeFusionMapCallback(const av_msgs::FusionMap &fm);
    void SubscribeDestCallback(const av_msgs::Dest &dst);
    void SubscribeTrafficLightCallback(const av_msgs::TrafficLightDetect &traffic_light);
    void SubscribeLocalizeCallback(const av_msgs::Localize &localize);

    void LoadConfiguration();

    // for log visualization 
    void DumpStaticObstacleMap(std::string file_name, const std::vector<std::vector<double> > &map);
    void DumpTrajectory(std::string file_name, const std::vector<av_msgs::Trajectory> &trajectories);
    void DumpRiskMap(std::string file_name, const std::vector<RiskMap> &risk_maps);
    void DumpLaneGroup(std::string file_name, const std::vector<LaneGroup> &lane_group_list);
    void DumpRiskIndex(std::string file_name, const std::vector<RiskIndex> &risk_indexes);
    void DumpBestTrajectory(std::string file_name, const av_msgs::Trajectory &trajectory);
    void DumpSimpleRiskMap(std::string file_name, const std::vector<RiskMap> &risk_maps);

private:
    // TODO for prescan simulation
    ros::ServiceClient section_list_client_;
    bool CallLocalLanemarkers(const double x_prescan, const double y_prescan, std::vector<av_msgs::SectionList>& section_list);

private:
    ros::NodeHandle nh_;

    //config
    double rate_;
    int fusion_map_queue_size_;
    int dest_queue_size_;
    int traffic_light_queue_size_;
    int localize_queue_size_;

    // input data
    av_msgs::FusionMap fusion_map_;
    av_msgs::Dest dest_;
    av_msgs::TrafficLightDetect traffic_light_;
    av_msgs::Trajectory trajectory_;
    av_msgs::Localize localize_;

    // internal nodes
    std::unique_ptr<Prepare> prepare_ptr_;
    std::unique_ptr<TrafficPropagation> traffic_propagation_ptr_;
    std::unique_ptr<GlobalPlanning> global_planning_ptr_;
    std::unique_ptr<FeatureExtraction> feature_extraction_ptr_;
    std::unique_ptr<Maneuver> maneuver_ptr_;
    std::unique_ptr<CandidateTrajectory> candidate_trajectory_ptr_;
    std::unique_ptr<RiskAssessment> risk_assessment_ptr_;
    std::unique_ptr<TrajectorySelection> trajectory_selection_ptr_;

    TrajectoryHistory trajectory_history_;
	bool available_trajectory_;

}; // PlanningCore

} // namespace av_planning

#endif //MUSTANG_AV_PLANNING_PLANNING_CORE_H
