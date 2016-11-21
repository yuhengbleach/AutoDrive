#ifndef MUSTANG_AV_PLANNING_TRAJECTORY_SELECTION_H
#define MUSTANG_AV_PLANNING_TRAJECTORY_SELECTION_H

#include <av_msgs/Trajectory.h> 

#include <av_planning/planning_comm.h>
#include <av_planning/maneuver.h>
#include <av_planning/candidate_trajectory.h>
#include <av_planning/risk_assessment.h>
#include <av_comm/comm.h>

#include <vector>

namespace av_planning { 

// Trajectory selection from candidate trajectories
class TrajectorySelection {
public:
    TrajectorySelection();

public:
    // Selection trajectory from candidate trajectories
    enum ErrorCode SelectTrajectory(const std::vector<av_msgs::Trajectory> &trajectories,
                                    const av_msgs::Localize& localize,
                                    std::vector<Cost> &costs,
                                    const std::vector<RiskIndex> &risk_indexes,
                                    const ManeuverState &maneuver_state,
                                    av_msgs::Trajectory &trajectory,
                                    TrajectoryHistory &history,
                                    bool &available_trajectory);

private:
    // Record trajectories
    void recordTrajectory(const std::vector<av_msgs::Trajectory> &trajectories);

    // Compute evaluation for each trajectory
    double getEval(const Cost cost, const RiskIndex risk);

    void getSimilarityCosts(const std::vector<av_msgs::Trajectory>& trajectories, const av_msgs::Localize& localize, std::vector<Cost>& costs);

    double getCosineSimilarity(const std::vector<double>& list1, const std::vector<double>& list2);

    bool transformPreviousTrajectory(const av_msgs::Localize& localize, std::vector<double>& last_xs, std::vector<double>& last_ys);

    uint64_t refreshTrajectoryTime(av_msgs::Trajectory& trajectory);

	void refreshTrajectoryInitialPose(av_msgs::Trajectory& trajectory, const av_msgs::Localize& localize);

private:
	bool is_first_planning_;
    // The trajectory of previous planning
    av_msgs::Trajectory last_trajectory_;
    // The location of previous planning
    av_msgs::Localize last_localize_;
    // Ratios for cost evaluation
    double velocity_ratio_, acceleration_ratio_, jerk_ratio_, position_ratio_, curvature_ratio_, similarity_ratio_;
    // The barrier value for risk
    double risk_barrier_;
    // A large value for risk barrier function
    const double infinity = 1e6;
    // sample time and time horizon to generate trajectories
    double sample_t_, horizon_t_; 
};

} // namespace av_planning

#endif // MUSTANG_AV_PLANNING_TRAJECTORY_SELECTION_H
