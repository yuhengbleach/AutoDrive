#include <ros/ros.h>

#include <av_planning/risk_assessment.h>

#include <vector>
#include <cmath>
#include <thread>
#include <iostream>
#include <sys/time.h>

using namespace av_planning;

RiskAssessment::RiskAssessment() {
    LoadConfiguration();
    // init pre map for speed up
    int dim_x = 500, dim_y = 750, num = 21;
    pre_map_ = std::vector<std::vector<std::vector<int> > >(num, std::vector<std::vector<int> >(dim_x, std::vector<int>(dim_y, 0)) );
    //ROS_INFO("init pre_map, size is :%d", int(pre_map_.size()));
}

void RiskAssessment::LoadConfiguration() {
    ros::param::get("~/traffic_propagation/certain_trajectory_start_time",
                    certain_trajectory_start_time_);
    ros::param::get("~/traffic_propagation/certain_trajectory_end_time",
                    certain_trajectory_end_time_);
    ros::param::get("~/traffic_propagation/certain_trajectory_step",
                    certain_trajectory_step_);
    ros::param::get("~/traffic_propagation/resolution", 
                    resolution_);
    ros::param::get("~ego_width", ego_width_);
    ros::param::get("~ego_length", ego_length_);
    ros::param::get("~t_sample", sample_t_);
    // translate ms to s
    sample_t_ = sample_t_ * 1000;
}

enum ErrorCode RiskAssessment::AssignTrajectoryRisk(
                                const std::vector<av_msgs::Trajectory> &trajectories,
                                const std::vector<Cost> &costs,
                                const std::vector<RiskMap> &certain_risk_maps,
                                const std::vector<RiskMap> &uncertain_risk_maps,
                                std::vector<RiskIndex> &risk_indexes) {
    //ROS_INFO("trajectory num is: %d", int(trajectories.size()));
    // check parameter validation
    if(0 != int(certain_trajectory_step_) % int(sample_t_) || 0 == trajectories.size()) {
        ROS_INFO("parameter error");
        return ErrorCode::ERROR;
    }
    
    struct timeval tv1,tv2;
    struct timeval start, end;
    struct timezone tz1, tz2;
    double timeuse;
    
    gettimeofday(&tv1, &tz1);

    for(auto iter = trajectories.begin(); iter != trajectories.end(); ++iter) {
        RiskIndex tmp_index;
        tmp_index.is_collision = false;
        tmp_index.collision_probability = 0;
        risk_indexes.push_back(tmp_index);
    }
    if(0 != CollisionCheck(trajectories, certain_risk_maps, risk_indexes)) {
        return ErrorCode::ERROR;
    }
    
    gettimeofday(&tv2, &tz2);
    timeuse = tv2.tv_sec - tv1.tv_sec + (tv2.tv_usec - tv1.tv_usec)/1000000.0;
    //ROS_INFO("risk assessment internal use time:%f", timeuse);
    
    if(0 != CollisionProbability(trajectories, uncertain_risk_maps, risk_indexes)) {
        return ErrorCode::ERROR;
    }

    return ErrorCode::SUCCESS;
}

int RiskAssessment::CollisionCheck(const std::vector<av_msgs::Trajectory> &trajectories,
                                   const std::vector<RiskMap> &certain_risk_maps,
                                   std::vector<RiskIndex> &risk_indexes) {
    int shift_step = int(certain_trajectory_step_) / int(sample_t_);
    double start_time = certain_trajectory_start_time_;
    double end_time = certain_trajectory_end_time_;
    double step_time = certain_trajectory_step_;
    double delta_time = 0;
    
    struct timeval tv1,tv2;
    struct timeval start, end;
    struct timezone tz1, tz2;
    double timeuse;

    // dp
    gettimeofday(&tv1, &tz1);

    //ROS_INFO("pre_map size: %d", int(pre_map_.size()));
    //std::vector<std::vector<std::vector<int> > > pre_map;
    if(0 != PrecalculateMap(certain_risk_maps)) {
        return -1;
    }
    
    gettimeofday(&tv2, &tz2);
    timeuse = tv2.tv_sec - tv1.tv_sec + (tv2.tv_usec - tv1.tv_usec)/1000000.0;
    //ROS_INFO("precalculate map use time:%f", timeuse);

    // lookup table
    gettimeofday(&tv1, &tz1);
    
    std::vector<std::thread> thread_list;
    int block_num = 100;
    int thread_num = ceil(double(trajectories.size()) / block_num);
    int index_lhs, index_rhs;

    //ROS_INFO("risk_indexes init size: %d, trajectories size: %d", int(risk_indexes.size()), int(trajectories.size()));

    for(int i = 0; i < thread_num; ++i) {
        index_lhs = i * block_num;
        if(i != thread_num - 1) {
            index_rhs = (i + 1) * block_num;
        }
        else {
            index_rhs = trajectories.size();    
        }
        //ROS_INFO("thread for %d to %d", index_lhs, index_rhs);
        thread_list.emplace_back(CollisionCheckThread,
                                 std::ref(trajectories),
                                 this,
                                 index_lhs,
                                 index_rhs,
                                 std::ref(risk_indexes));
        
    }
    for(auto iter = thread_list.begin(); iter != thread_list.end(); ++iter) {
        iter->join();
    }
    
    gettimeofday(&tv2, &tz2);
    timeuse = tv2.tv_sec - tv1.tv_sec + (tv2.tv_usec - tv1.tv_usec)/1000000.0;
    //ROS_INFO("lookup table use time:%f", timeuse);

    return 0;
}

void RiskAssessment::CollisionCheckThread(const std::vector<av_msgs::Trajectory> &trajectories,
                                          RiskAssessment *rp,
                                          int index_lhs,
                                          int index_rhs,
                                          std::vector<RiskIndex> &risk_indexes) {
    int shift_step = int(rp->certain_trajectory_step_) / int(rp->sample_t_);
    double start_time = rp->certain_trajectory_start_time_;
    double end_time = rp->certain_trajectory_end_time_;
    double step_time = rp->certain_trajectory_step_;
    double delta_time = 0;
    int map_shifting = 0;
    int trajectory_shifting = 0;
    while(start_time + delta_time <= end_time) {
        int check_time = start_time + map_shifting * step_time;
        rp->CollisionCheckImplementation(trajectories,
                                     index_lhs,
                                     index_rhs,
                                     rp->pre_map_.at(map_shifting), 
                                     trajectory_shifting, 
                                     risk_indexes,
                                     check_time);
        trajectory_shifting += shift_step;
        ++map_shifting;
        delta_time = map_shifting * step_time;
    }
}


void RiskAssessment::PrecalculateMapThread(std::vector<RiskMap>::const_iterator iter,
                           std::vector<std::vector<int> > &cur_pre_map) {
    struct timeval tv1,tv2;
    struct timeval start, end;
    struct timezone tz1, tz2;
    double timeuse;

    gettimeofday(&tv1, &tz1);

    int dim_x = iter->risk_map.size();
    int dim_y = iter->risk_map[0].size();
    for(int i = 0; i < dim_x; ++i) {
        for(int j = 0; j < dim_y; ++j) {
            cur_pre_map[i][j] = 0;
            int f1, f2, f3;
            if(i - 1 < 0) {
                f1 = 0;
            }
            else {
                f1 = cur_pre_map[i - 1][j];
            }
            if(j - 1 < 0) {
                f2 = 0;
            }
            else {
                f2 = cur_pre_map[i][j - 1];
            }
            if(i - 1 >= 0 && j - 1 >= 0) {
                f3 = cur_pre_map[i - 1][j - 1];
            }
            else {
                f3 = 0;
            }
            cur_pre_map[i][j] = f1 + f2 - f3 + int(((iter->risk_map).at(i)).at(j));
       }
    }

    gettimeofday(&tv2, &tz2);
    timeuse = tv2.tv_sec - tv1.tv_sec + (tv2.tv_usec - tv1.tv_usec)/1000000.0;
    //ROS_INFO("precalculate thread  use time:%f", timeuse);

}

int RiskAssessment::PrecalculateMap(const std::vector<RiskMap> &certain_risk_maps){ 
    struct timeval tv1,tv2;
    struct timeval start, end;
    struct timezone tz1, tz2;
    double timeuse;
    
    gettimeofday(&tv1, &tz1);

    // init pre_map
    /*
    auto iter = certain_risk_maps.begin();
    int dim_x = iter->risk_map.size();
    int dim_y = iter->risk_map[0].size();
    int num = certain_risk_maps.size();
    ROS_INFO("Pre_map Info -> dim_x: %d, dim_y: %d, num: %d", dim_x, dim_y, num);
    pre_map = std::vector<std::vector<std::vector<int> > >(num, std::vector<std::vector<int> >(dim_x, std::vector<int>(dim_y, 0)) );
    */
    gettimeofday(&tv2, &tz2);
    timeuse = tv2.tv_sec - tv1.tv_sec + (tv2.tv_usec - tv1.tv_usec)/1000000.0;
    //ROS_INFO("init precalculate use time:%f", timeuse);

    /*
    for(auto iter = certain_risk_maps.begin(); iter != certain_risk_maps.end(); ++iter) {
        int dim_x = iter->risk_map.size();
        int dim_y = iter->risk_map[0].size();
        //std::vector<std::vector<int> > cur_pre_map(dim_x, std::vector<int>(dim_y, 0));
        //pre_map.push_back(cur_pre_map);
        pre_map.emplace_back(dim_x, std::vector<int>(dim_y, 0));
    }
    */
    //ROS_INFO("pre_map size before set: %d", int(pre_map_.size()));
    // thread implementation
    std::vector<std::thread> thread_list;
    for(std::vector<RiskMap>::const_iterator iter = certain_risk_maps.begin(); iter != certain_risk_maps.end(); ++iter) {
        thread_list.emplace_back(PrecalculateMapThread, iter, std::ref(this->pre_map_[iter - certain_risk_maps.begin()]));
    }
    for(auto iter = thread_list.begin(); iter != thread_list.end(); ++iter) {
        iter->join();
    }

    return 0;
}

int RiskAssessment::CollisionCheckImplementation(const std::vector<av_msgs::Trajectory> &trajectories,
                                                 int index_lhs,
                                                 int index_rhs,
                                                 const std::vector<std::vector<int> > &cur_pre_map,
                                                 int trajectory_shifting,
                                                 std::vector<RiskIndex> &risk_indexes,
                                                 int check_time) {
    //for(unsigned int i = 0; i < trajectories.size(); ++i) {
    for(int i = index_lhs; i < index_rhs; ++i) {
        if(risk_indexes[i].is_collision) {
            continue;
        }
        BoxModelPose pose;
        pose.x = trajectories.at(i).poses.at(trajectory_shifting).x;
        pose.y = trajectories.at(i).poses.at(trajectory_shifting).y;
        pose.theta = trajectories.at(i).poses.at(trajectory_shifting).theta;
        pose.propagation_time = 0; 
        pose.width = ego_width_; 
        pose.length = ego_length_;
        double resolution = resolution_;
        std::vector<RectangleCorner> rectangle_corner_list;
        if(0 != risk_helper_.BoxCorner(pose, resolution, rectangle_corner_list)) {
            return -1;
        }

        // check each box
        for(auto iter = rectangle_corner_list.begin(); iter != rectangle_corner_list.end(); ++iter) {
            int rhs_x = int(iter->x_max);
            int lhs_x = int(iter->x_min);
            int rhs_y = int(iter->y_max);
            int lhs_y = int(iter->y_min);
            
            int collision_result = cur_pre_map.at(rhs_x).at(rhs_y) + cur_pre_map.at(lhs_x).at(lhs_y) - cur_pre_map.at(rhs_x).at(lhs_y) - cur_pre_map.at(lhs_x).at(rhs_y);
            if(0 != collision_result) {
                risk_indexes[i].is_collision = true;
                // record collision info
                risk_indexes[i].collision_x = pose.x;
                risk_indexes[i].collision_y = pose.y;
                risk_indexes[i].collision_theta = pose.theta;
                risk_indexes[i].collision_time = check_time;
                break;
            }
        }
    }

    return 0;
}



// TODO
int RiskAssessment::CollisionProbability(const std::vector<av_msgs::Trajectory> &trajectories,
                                         const std::vector<RiskMap> &uncertain_risk_maps, 
                                         std::vector<RiskIndex> &risk_indexes) {
    return 0;
}

