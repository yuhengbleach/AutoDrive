#ifndef MUSTANG_AV_PLANNING_RISK_ASSESMENT_H
#define MUSTANG_AV_PLANNING_RISK_ASSESMENT_H

#include <av_msgs/Trajectory.h>

#include <av_planning/planning_comm.h> 
#include <av_planning/candidate_trajectory.h>
#include <av_planning/traffic_propagation.h>
#include <av_planning/risk_helper.h>

#include <vector>

namespace av_planning {

/*
struct RiskIndex {
    bool is_collision;
    double collision_probability;
    double collision_x;
    double collision_y;
    double collision_theta;
    int collision_time; // ms
};
*/
class RiskAssessment {
public:
    RiskAssessment();

public:
    // use certain_risk_maps for arbitrary collision check
    // use uncertain_risk_maps to reasoning collision probability
    enum ErrorCode AssignTrajectoryRisk(const std::vector<av_msgs::Trajectory> &trajectories,
                                        const std::vector<Cost> &costs,
                                        const std::vector<RiskMap> &certain_risk_maps,
                                        const std::vector<RiskMap> &uncertain_risk_maps,
                                        std::vector<RiskIndex> &risk_indexes);

private:
    // read configuration from mustang/src/av_planning/launch/fake_planning.launch 
    void LoadConfiguration();

    // short term, 0 - 1 s
    // paper: Ziegler, Julius, and Christoph Stiller. 
    // "Fast collision checking for intelligent vehicle motion planning." 
    // Intelligent Vehicles Symposium (IV), 2010 IEEE. IEEE, 2010.
    int CollisionCheck(const std::vector<av_msgs::Trajectory> &trajectories,
                       const std::vector<RiskMap> &certain_risk_maps,
                       std::vector<RiskIndex> &risk_indexes);

    static void CollisionCheckThread(const std::vector<av_msgs::Trajectory> &trajectories,
                                     RiskAssessment *rp,
                                     int index_lhs,
                                     int index_rhs, 
                                     std::vector<RiskIndex> &risk_indexes);

    int CollisionCheckImplementation(const std::vector<av_msgs::Trajectory> &trajectories,
                                     int lhs_index,
                                     int rhs_index,
                                     const std::vector<std::vector<int> > &cur_pre_map,
                                     int trajectory_shifting, 
                                     std::vector<RiskIndex> &risk_indexes,
                                     int check_time);

    int PrecalculateMap(const std::vector<RiskMap> &certain_risk_maps);

    static void PrecalculateMapThread(std::vector<RiskMap>::const_iterator iter,
                                      std::vector<std::vector<int> > &cur_pre_map);

    // TODO
    // long term, 0 - 5 s
    int CollisionProbability(const std::vector<av_msgs::Trajectory> &trajectories,  
                             const std::vector<RiskMap> &uncertain_risk_maps,
                             std::vector<RiskIndex> &risk_indexes);

private:
    RiskHelper risk_helper_;

    std::vector<std::vector<std::vector<int> > > pre_map_;

    // parameters
    double map_resolution_;
    double certain_trajectory_start_time_;
    double certain_trajectory_end_time_;
    double certain_trajectory_step_;
    double sample_t_;
    double resolution_;
    double ego_width_;
    double ego_length_;
};

} // namespace av_planning

#endif // MUSTANG_AV_PLANNING_RISK_ASSESMENT_H
