#ifndef MUSTANG_AV_PLANNING_TRAFFIC_PROPAGATION_H
#define MUSTANG_AV_PLANNING_TRAFFIC_PROPAGATION_H

#include <av_planning/planning_comm.h>
#include <av_planning/prepare.h>
#include <av_planning/risk_helper.h> 

#include <vector>  

namespace av_planning { 

struct RiskMap {
    std::vector<std::vector<double> > risk_map;
    // resolution 100 ms
    int propagation_time;
};

struct PossibleTrajectory {
    double probability;
    std::vector<BoxModelPose> trajectory;
};

class TrafficPropagation {
public:
    TrafficPropagation();

public:
    enum ErrorCode InferRiskMap(const PlanningFusionMap &planning_fusion_map,
                                std::vector<RiskMap> &certain_risk_maps,       
                                std::vector<RiskMap> &uncertain_risk_maps);

private:
    // read configuration from mustang/src/av_planning/launch/fake_planning.launch 
    void LoadConfiguration();

    // trajectory predicting entrance 
    int PredictTrajectory(const PlanningFusionMap &planning_fusion_map);
    
    // vehicle trajectory predicting entrance: mdl model, HMM model 
    int PredictVehicleTrajectory(const av_msgs::DynamicObstacle &vechicle_object,
                                 const std::vector<LaneGroup> lane_group_list,
                                 std::vector<BoxModelPose> &mdl_trajectory,
                                 std::vector<PossibleTrajectory> &possible_trajectories);
    
    // mdl model for trajectory prediction: 
    // constant acceleration and angular velocity
    int MdlModel(const av_msgs::DynamicObstacle &dynamic_object,
                  std::vector<BoxModelPose> &mdl_trajectory);
   
    int MdlImplementation(double x, double y, double theta, double v, double a, double w, 
                          double delta_t, 
                          BoxModelPose &pose);

    // short term, 0 - 1 s, for arbitrary collison check 
    int SetCertainRiskMaps(const std::vector<std::vector<BoxModelPose> > &mdl_trajectories,
                           const std::vector<std::vector<double> > static_obstacle_map,
                           std::vector<RiskMap> &certain_risk_maps);

    static void SetCertainRiskMapsThread(const std::vector<std::vector<BoxModelPose> > &mdl_trajectories,
                                         std::vector<std::vector<double> > &cur_map,
                                         const std::vector<std::vector<double> > &static_obstacle_map,
                                         int shifting,
                                         TrafficPropagation *tp);

    int FillStaticMap(const std::vector<RectangleCorner> &rectangle_corner_list, 
                      std::vector<std::vector<double> > &cur_map);


    // long term, 0 - 5 s, for risk assessment 
    int SetUncertainRiskMaps(const std::vector<PossibleTrajectory> &possible_trajectories,
                             const std::vector<std::vector<double> > static_obstacle_map,
                             std::vector<RiskMap> &uncertain_risk_maps);

    // TODO
    // pedestrian trajectory predicting entrance
    int PredictPedestrianTrajectory();
    
    // bicycle trajectory predicting entrance
    int PredictBicycleTrajectory();
    
    // HMM model for vehicle trajectory prediction: 
    // consider vehicle intention and road structure
    int HMMModel(const av_msgs::DynamicObstacle &dynamic_object, 
                 const std::vector<LaneGroup> &lane_group_list,
                 std::vector<PossibleTrajectory> &possible_trajectories);

private:
    RiskHelper risk_helper_;
    
    // parameters for certain risk map
    double certain_trajectory_start_time_;
    double certain_trajectory_end_time_;
    double certain_trajectory_step_;

    double resolution_;
};

} // namespace av_planning   

#endif // MUSTANG_AV_PLANNING_TRAFFIC_PROPAGATION_H
