/***********************************************
Copyright@ 2015 DIDI RESEARCH. All right reserved
File Name: maneuver.cpp
Description: 
Author: peili - lipeilp@didichuxing.com
Create Date: 2016-08-24 21:55:49
Last modified: 2016-08-24 21:55:49
GCC release: 4.4.6
**************************************************/ 
 
#include <av_planning/maneuver.h>

namespace av_planning {

Maneuver::Maneuver(): 
    current_state_(0),
    last_state_(0) {
    LoadTransitionMatrix();
}

enum ErrorCode Maneuver::ReasoningManeuver(const std::vector<int> &feature_list,
                                 const BasicManeuver &basic_maneuver,
                                 const int feedback_flag,
                                 ManeuverState &maneuver_state) {   
    int flag = 0; 
      
    int global_state = -1;
    ReasoningGlobalState(feature_list, global_state);        
    
    int state = feedback_flag == 1? last_state_: current_state_;
    StateOrderTransition(global_state, state);
    
    if (global_state == 2 && state == 5) {
        ROS_ERROR("maneuver exit state error!");
        return ErrorCode::ERROR;
    }

    int index = global_state == 1? lane_state_num_ - 1: intersection_state_num_ - 1;
    
    for (; index >= 0; --index) { 
        flag = 0;
        int w_index = global_state == 1? lane_transition_matrix_[state][index] : intersection_transition_matrix_[state][index];
        CalTransitionFeature(feature_list, w_index, flag); 
        if (flag > 0) {
            // 当前反馈的时候只是再次决策的时候不能和之前的相同，可能会面临问题。
            if (feedback_flag == 1 && index == current_state_) {
                continue;
            }
            break;
        }
    }
    
    if (index < 0) {
        if (feedback_flag == 1) {
            index = 3; // stop state : lane dirving , intersection handling
        } else {
            index = state;
            flag = current_flag_;
        }
    }
    
    global_state == 1? GenerateLaneManeuver(index, flag, basic_maneuver, maneuver_state) : GenerateIntersectionManeuver(index, flag, basic_maneuver, maneuver_state);
    if (feedback_flag != 1) { 
        last_state_ = current_state_;
    }

    current_state_ = index;
    current_global_state_ = global_state;
    current_flag_ = flag;
    return ErrorCode::SUCCESS;
}

void Maneuver::LoadTransitionMatrix() {
    std::vector<int>lane_transition_list;
    std::vector<int>intersection_transition_list;
    ros::param::get("~maneuver/lane_state_num", lane_state_num_);
    ros::param::get("~maneuver/intersection_state_num", intersection_state_num_);
    ros::param::get("~maneuver/lane_transition_matrix", lane_transition_list);
    ros::param::get("~maneuver/intersection_transition_matrix", intersection_transition_list);
    ros::param::get("~maneuver/lane_state_order", lane_order_list_);
    ros::param::get("~maneuver/intersection_state_order", intersection_order_list_);
    ros::param::get("~maneuver/feature_order_R", feature_R_);
    ros::param::get("~maneuver/feature_order_E", feature_E_);

    for (int i = 0; i < lane_state_num_; ++i) {
        std::vector<int> lane_transition_vector(lane_state_num_, 0);
        lane_transition_matrix_.push_back(lane_transition_vector);
        for (int j = 0; j < lane_state_num_; ++j) {
            lane_transition_matrix_[i][j] = lane_transition_list[i * lane_state_num_ + j];
        } 
    }

    for (int i = 0; i < intersection_state_num_; ++ i) {
        std::vector<int> intersection_transition_vector(intersection_state_num_, 0);
        intersection_transition_matrix_.push_back(intersection_transition_vector);
        for (int j = 0; j < intersection_state_num_; ++ j) {
            intersection_transition_matrix_[i][j] = intersection_transition_list[i * intersection_state_num_ + j];    
        }
    }
    
}

void Maneuver::ReasoningGlobalState(const std::vector<int> &feature_list,
                                    int &global_state) {
     
    if (feature_list[feature_E_[11]] || (!feature_list[feature_R_[5]] && !feature_list[feature_R_[6]])) {
        global_state = 1;
    } else if (feature_list[feature_R_[5]] || feature_list[feature_R_[6]]) {
        global_state = 2;
    }
}

void Maneuver::StateOrderTransition(const int global_state,
                                    int & state) {
    if (global_state == current_global_state_) {
        return;
    } 
    
    std::vector<int> from_state_order_list(global_state == 1? lane_order_list_: intersection_order_list_);
    std::vector<int> to_state_order_list(current_global_state_ ==2?  intersection_order_list_: lane_order_list_);
    
    for (int state_index = 0; state_index < to_state_order_list.size(); ++ state_index) {
        if (from_state_order_list[state] == to_state_order_list[state_index]) {
            state = state_index;
            break;
        }
    }

}


void Maneuver::CalTransitionFeature(const std::vector<int> &feature_list,
                                    const int stat_index, 
                                    int &flag) {
    int sub_flag;
    switch(stat_index) {   
        case 1:
            if ((feature_list[feature_E_[1]]&&!feature_list[feature_E_[18]]&&!feature_list[feature_E_[19]]&&!feature_list[feature_E_[3]]&&
                !feature_list[feature_E_[5]]&&!feature_list[feature_E_[7]]&&!feature_list[feature_E_[9]]&&feature_list[feature_R_[1]]) || 
                
                (feature_list[feature_E_[2]]&&!feature_list[feature_E_[18]]&&!feature_list[feature_E_[19]]&&!feature_list[feature_E_[3]]&&
                 !feature_list[feature_E_[5]]&&!feature_list[feature_E_[7]]&&!feature_list[feature_E_[9]]&&feature_list[feature_R_[1]])) {
                
                flag = 1;
                break;
            }

            if ((feature_list[feature_E_[1]]&&!feature_list[feature_E_[18]]&&!feature_list[feature_E_[19]]&&!feature_list[feature_E_[4]]&&
                !feature_list[feature_E_[6]]&&!feature_list[feature_E_[8]]&&!feature_list[feature_E_[10]]&&feature_list[feature_R_[2]]) || 
                
                (feature_list[feature_E_[2]]&&!feature_list[feature_E_[18]]&&!feature_list[feature_E_[19]]&&!feature_list[feature_E_[4]]&&
                !feature_list[feature_E_[6]]&&!feature_list[feature_E_[8]]&&!feature_list[feature_E_[10]]&&feature_list[feature_R_[2]])) {
                flag = 2;
            }
            break;
        
        case 2:
            if ((feature_list[feature_E_[1]]&&feature_list[feature_R_[1]]&&feature_list[feature_R_[4]]&&(feature_list[feature_E_[3]]||
                feature_list[feature_E_[5]]||feature_list[feature_E_[7]]||feature_list[feature_E_[9]]||feature_list[feature_E_[18]]||feature_list[feature_E_[19]])) ||
                 
                (feature_list[feature_E_[1]]&&feature_list[feature_R_[2]]&&feature_list[feature_R_[3]]&&(feature_list[feature_E_[4]]||
                feature_list[feature_E_[6]]||feature_list[feature_E_[8]]||feature_list[feature_E_[10]]||feature_list[feature_E_[18]]||feature_list[feature_E_[19]])) ||
                
                (feature_list[feature_E_[1]]&&feature_list[feature_R_[1]]&&feature_list[feature_R_[2]]&&(feature_list[feature_E_[3]]||feature_list[feature_E_[5]]||
                feature_list[feature_E_[7]]||feature_list[feature_E_[9]]||feature_list[feature_E_[18]]||feature_list[feature_E_[19]])&&(feature_list[feature_E_[4]]||
                feature_list[feature_E_[6]]||feature_list[feature_E_[8]]||feature_list[feature_E_[10]]||feature_list[feature_E_[18]]||feature_list[feature_E_[19]])) ||
                
                (feature_list[feature_E_[1]]&&feature_list[feature_E_[3]]&&feature_list[feature_E_[4]])) {
                flag = 1;
            }
            break;

        case 3:
            if ((feature_list[feature_E_[2]]&&feature_list[feature_R_[1]]&&feature_list[feature_R_[4]]&&(feature_list[feature_E_[3]]||feature_list[feature_E_[5]]||
                feature_list[feature_E_[7]]||feature_list[feature_E_[9]]||feature_list[feature_E_[18]]||feature_list[feature_E_[19]])) ||
                
                (feature_list[feature_E_[2]]&&feature_list[feature_R_[2]]&&feature_list[feature_R_[3]]&&(feature_list[feature_E_[4]]||feature_list[feature_E_[6]]||
                feature_list[feature_E_[8]]||feature_list[feature_E_[10]]||feature_list[feature_E_[18]]||feature_list[feature_E_[19]])) ||
                
                (feature_list[feature_E_[2]]&&feature_list[feature_R_[1]]&&feature_list[feature_R_[2]]&&(feature_list[feature_E_[3]]||feature_list[feature_E_[5]]||
                feature_list[feature_E_[7]]||feature_list[feature_E_[9]]||feature_list[feature_E_[18]]||feature_list[feature_E_[19]])&&(feature_list[feature_E_[4]]||
                feature_list[feature_E_[6]]||feature_list[feature_E_[8]]||feature_list[feature_E_[10]]||feature_list[feature_E_[18]]||feature_list[feature_E_[19]])) ||
                
                (feature_list[feature_E_[2]]&&feature_list[feature_R_[3]]&&feature_list[feature_R_[4]])) {
                flag = 1;
            }
            break;

        case 4:
            if (!feature_list[feature_E_[2]]) {
                flag = 1;
            }
            break;

        case 5:
            if (feature_list[feature_E_[11]]) {
                flag = 1;
            }
            break;
       
        case 6:
            if (feature_list[feature_R_[5]]&&!feature_list[feature_E_[12]]&&feature_list[feature_E_[13]]&&!feature_list[feature_E_[18]]&&!feature_list[feature_E_[19]]&&
                !feature_list[feature_E_[3]]&&!feature_list[feature_E_[5]]&&!feature_list[feature_E_[7]]) {
                flag = 1;
                break;
            }
            
            if (feature_list[feature_R_[5]]&&!feature_list[feature_E_[12]]&&feature_list[feature_E_[14]]&&!feature_list[feature_E_[18]]&&!feature_list[feature_E_[19]]&&
                !feature_list[feature_E_[4]]&&!feature_list[feature_E_[6]]&&!feature_list[feature_E_[8]]) {
                flag = 2;
            }
            break;
        
        case 7:
            sub_flag = 0;
            CalTransitionFeature(feature_list, 2, sub_flag);
            if (sub_flag || 
                (feature_list[feature_R_[5]]&&feature_list[feature_E_[12]]&&feature_list[feature_E_[1]]) || 
                (feature_list[feature_R_[6]]&&feature_list[feature_E_[17]])) {
                flag = 1;
            }
            break;

        case 8:
            sub_flag = 0;
            CalTransitionFeature(feature_list, 3, sub_flag);
            if (sub_flag || 
                (feature_list[feature_R_[5]]&&feature_list[feature_E_[12]]&&feature_list[feature_E_[2]]) || 
                (feature_list[feature_R_[6]]&&feature_list[feature_E_[16]])) {
                flag = 1;
                break;
            }

            if (feature_list[feature_R_[5]]&&feature_list[feature_E_[12]]&&!feature_list[feature_E_[15]]&&feature_list[feature_R_[7]]
                &&!feature_list[feature_E_[1]]&&!feature_list[feature_E_[2]]) {
                flag = 2;
            } 
            break; 
            
        case 9:
            if((feature_list[feature_R_[5]]&&feature_list[feature_E_[12]]&&!feature_list[feature_E_[1]]&&!feature_list[feature_E_[2]]&&
                feature_list[feature_E_[15]]&&feature_list[feature_R_[7]]) || 
                
                (feature_list[feature_R_[5]]&&feature_list[feature_E_[12]]&&!feature_list[feature_E_[1]]&&!feature_list[feature_E_[2]]&&!feature_list[feature_R_[7]]) || 
                
                (feature_list[feature_R_[6]]&&!feature_list[feature_E_[16]]&&!feature_list[feature_E_[17]]) ) {
                
                flag = 1;
            }
            break;
    }  
}

void Maneuver::GenerateLaneManeuver(const int state_index,
                                    const int flag,
                                    const BasicManeuver &basic_maneuver,
                                    ManeuverState &maneuver_state) {
     
    maneuver_state.next_state = state_index;
    switch(state_index) {
        case 0:
            maneuver_state.v = basic_maneuver.section_v;
            CalParameterLane(basic_maneuver.current_lane, basic_maneuver.lane_group_list, maneuver_state.lane_group_list);
            ROS_INFO("Lane Maneuver state: keep lane");
            break;

        case 1:
            maneuver_state.v = basic_maneuver.section_v;
            if (flag == 1) {
                CalParameterLane(basic_maneuver.current_lane - 1, basic_maneuver.lane_group_list, maneuver_state.lane_group_list);
                ROS_INFO("Lane Maneuver state: lane change left");
            } else {
                CalParameterLane(basic_maneuver.current_lane + 1, basic_maneuver.lane_group_list, maneuver_state.lane_group_list);
                ROS_INFO("Lane Maneuver state: lane change right");
            }
            break;

        case 2:
            maneuver_state.v = basic_maneuver.front_vehicle_v;
            maneuver_state.keep_distance = basic_maneuver.keep_distance;
            CalParameterLane(basic_maneuver.current_lane, basic_maneuver.lane_group_list, maneuver_state.lane_group_list);
            ROS_INFO("Lane Maneuver state: follow");
            break;
        
        case 3:
            maneuver_state.v = 0;
            maneuver_state.stop_distance = basic_maneuver.stop_distance;
            CalParameterLane(basic_maneuver.current_lane, basic_maneuver.lane_group_list, maneuver_state.lane_group_list);
            ROS_INFO("Lane Maneuver state: stop");
            break;

        case 4:
            maneuver_state.v = 0;
            maneuver_state.stop_distance = std::min(basic_maneuver.dest_distance, basic_maneuver.stop_distance);
            CalParameterLane(basic_maneuver.current_lane, basic_maneuver.lane_group_list, maneuver_state.lane_group_list);
            ROS_INFO("Lane Maneuver state: exit");
            break;
    }
}


void Maneuver::GenerateIntersectionManeuver(const int state_index,
                                            const int flag,
                                            const BasicManeuver &basic_maneuver,
                                            ManeuverState &maneuver_state) {
     
    maneuver_state.next_state = state_index;
    switch(state_index) {
        case 0:
            maneuver_state.v = std::min(basic_maneuver.section_v, 5.0);
            CalParameterLane(basic_maneuver.current_lane, basic_maneuver.lane_group_list, maneuver_state.lane_group_list);
            ROS_INFO("Intersection Maneuver state: keep lane");
            break;

        case 1:
            maneuver_state.v = basic_maneuver.front_vehicle_v;
            maneuver_state.keep_distance = basic_maneuver.keep_distance;
            CalParameterLane(basic_maneuver.current_lane, basic_maneuver.lane_group_list, maneuver_state.lane_group_list);
            ROS_INFO("Intersection Maneuver state: follow");
            break;
        
        case 2:
            maneuver_state.v = std::min(basic_maneuver.section_v, 5.0);
            if (flag == 1) {
                CalParameterLane(basic_maneuver.current_lane - 1, basic_maneuver.lane_group_list, maneuver_state.lane_group_list);
                ROS_INFO("Intersection Maneuver state: lane change left");
            } else {
                CalParameterLane(basic_maneuver.current_lane + 1, basic_maneuver.lane_group_list, maneuver_state.lane_group_list);
                ROS_INFO("Intersection Maneuver state: lane change right");
            }
            break;
        
        case 3:
            maneuver_state.v = 0;
            if (flag == 1) {
                maneuver_state.stop_distance = basic_maneuver.stop_distance;
            } else {
                maneuver_state.stop_distance = basic_maneuver.stopline_distance;
            }
            CalParameterLane(basic_maneuver.current_lane, basic_maneuver.lane_group_list, maneuver_state.lane_group_list);
            ROS_INFO("Intersection Maneuver state: stop");
            break;
    }
}

void Maneuver::CalParameterLane(const int lane_index,
                                const std::vector<LaneGroup> &lane_group_list,
                                std::vector<LaneGroup> &select_lane_list) {
    select_lane_list.push_back(lane_group_list[lane_index]);
}

void Maneuver::CalFeedbackStopDistance(const double start_x,
                                       const double start_y,
                                       const std::vector<RiskIndex> &risk_indexes,
                                       const int feedback_flag,
                                       ManeuverState &maneuver_state) {
    if (maneuver_state.next_state != 3 || feedback_flag != 1) {
        return;
    }
     
    double start_s;
    double dist;
    spline::getClosestPointOnCurve(maneuver_state.lane_group_list[0].lanes[0].left_line.curve_x, maneuver_state.lane_group_list[0].lanes[0].left_line.curve_y, 
                                    start_x, start_y, start_s, dist);
    std::vector<double>risk_dist_list(risk_indexes.size());
    std::vector<double>risk_dist_grid(100/0.5, 0);

    for (int index = 0; index < risk_indexes.size(); ++ index) {
        double collision_s;
        spline::getClosestPointOnCurve(maneuver_state.lane_group_list[0].lanes[0].left_line.curve_x, maneuver_state.lane_group_list[0].lanes[0].left_line.curve_y, 
                                        risk_indexes[index].collision_x, risk_indexes[index].collision_y, collision_s, dist);
        risk_dist_list[index] = collision_s - start_s;
    }
    
    std::sort(risk_dist_list.begin(), risk_dist_list.end());
    double bound = 0.5;
    int grid_index = 0;
    for (int index = 0; index < risk_dist_list.size(); ++ index) {
        if (risk_dist_list[index] < bound) {
            risk_dist_grid[grid_index] ++;
        } else {
            bound += 0.5;
            grid_index ++;
        }
    }
    
    double max_value = 0;
    int max_index = -1;
    for (int index = 0; index < risk_dist_grid.size(); ++ index) {
        if (max_value < risk_dist_grid[index]) {
            max_value = risk_dist_grid[index];   
            max_index = index;
        } 
    }

    double collision_distance = (max_index + 1) * 0.5;
    if (collision_distance < 5) {
        maneuver_state.stop_distance = collision_distance * 0.7;
    } else if (collision_distance < 15) {
        maneuver_state.stop_distance = collision_distance - 2;
    } else {
        maneuver_state.stop_distance = collision_distance - 5;
    }
}

}
