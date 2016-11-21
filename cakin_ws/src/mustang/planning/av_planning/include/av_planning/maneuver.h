#ifndef MUSTANG_AV_PLANNING_MANEUVER_H
#define MUSTANG_AV_PLANNING_MANEUVER_H

#include <av_planning/planning_comm.h>  
#include <av_planning/prepare.h>
#include <av_planning/feature_extraction.h>
#include <av_planning/risk_helper.h>

#include <vector>
#include <algorithm>

namespace av_planning {


struct ManeuverState {
    int next_state;   
    float  v;
    float  keep_distance; 
    float  stop_distance; 
    std::vector<LaneGroup> lane_group_list;
};

class Maneuver {
public:
    Maneuver();
    ~Maneuver() {};

public:
    enum ErrorCode ReasoningManeuver(const std::vector<int> &feature_list,
                           const BasicManeuver &basic_maneuver,
                           const int feedback_flag,
                           ManeuverState &maneuver_state);
    
    void CalFeedbackStopDistance(const double start_x,
                                 const double start_y,
                                 const std::vector<RiskIndex> &risk_indexes,
                                 const int feedback_flag,
                                 ManeuverState &maneuver_state);
private:
    void LoadTransitionMatrix();
    
    // 1: lane driving 2: intersection handling
    void ReasoningGlobalState(const std::vector<int> &feature_list,
                              int &global_state);
    
    void StateOrderTransition(const int global_state, 
                             int &state);
    
    void CalTransitionFeature(const std::vector<int> &feature_list,
                              const int stat_index, 
                              int &flag);
    
    void GenerateLaneManeuver(const int state_index,
                              const int flag,
                              const BasicManeuver &basic_maneuver,
                              ManeuverState &maneuver_state);
            
    void GenerateIntersectionManeuver(const int state_index,
                                      const int flag,
                                      const BasicManeuver &basic_maneuver,
                                      ManeuverState &maneuver_state);
    
    void CalParameterLane(const int lane_index,
                          const std::vector<LaneGroup> &parameter_lane_list,
                          std::vector<LaneGroup> &select_lane_list);
    
private:
    std::vector<std::vector<int> > lane_transition_matrix_;
    std::vector<std::vector<int> > intersection_transition_matrix_;
    std::vector<int> lane_order_list_;
    std::vector<int> intersection_order_list_;
    std::vector<int> feature_R_;
    std::vector<int> feature_E_;


    int current_state_;
    int current_global_state_;
    int current_flag_;

    int last_state_;

    int lane_state_num_;
    int intersection_state_num_;
};

} // namespace av_planning

#endif // MUSTANG_AV_PLANNING_MANEUVER_H
