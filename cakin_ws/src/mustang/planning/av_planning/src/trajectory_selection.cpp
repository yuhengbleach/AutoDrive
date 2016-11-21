#include <av_planning/trajectory_selection.h>
#include <av_comm/comm.h>

#include <fstream>
#include <vector>

using namespace av_planning;

TrajectorySelection::TrajectorySelection() : is_first_planning_(true) {
    ros::param::get("~/t_sample", sample_t_);
    ros::param::get("~/t_horizon", horizon_t_);
    ros::param::get("~/trajectory_selection/velocity_ratio", velocity_ratio_);
    ros::param::get("~/trajectory_selection/acceleration_ratio", acceleration_ratio_);
    ros::param::get("~/trajectory_selection/jerk_ratio", jerk_ratio_);
    ros::param::get("~/trajectory_selection/position_ratio", position_ratio_);
    ros::param::get("~/trajectory_selection/curvature_ratio", curvature_ratio_);
    ros::param::get("~/trajectory_selection/similarity_ratio", similarity_ratio_);
    ros::param::get("~/trajectory_selection/risk_barrier", risk_barrier_);
}

// TODO: write data to a file
void TrajectorySelection::recordTrajectory(const std::vector<av_msgs::Trajectory> &trajectories) {
    std::vector<av_msgs::Trajectory>::const_iterator iter, iter_end=trajectories.end();
    for(iter=trajectories.begin(); iter!=iter_end; iter++) {
        std::vector<av_msgs::Pose> poses = iter->poses;
        std::vector<av_msgs::Pose>::const_iterator iter_pose, iter_pose_end=poses.end();
        std::vector<double> xs, ys, thetas, curvatures, vels;
        for(iter_pose=poses.begin(); iter_pose!=iter_pose_end; iter++) {
            xs.push_back(iter_pose->x);
            ys.push_back(iter_pose->y);
            thetas.push_back(iter_pose->theta);
            curvatures.push_back(iter_pose->curvature);
            vels.push_back(iter_pose->velocity);
        }
    }
}

enum ErrorCode TrajectorySelection::SelectTrajectory(const std::vector<av_msgs::Trajectory> &trajectories,
                                                    const av_msgs::Localize& localize,
                                                    std::vector<Cost> &costs,
                                                    const std::vector<RiskIndex> &risk_indexes,
                                                    const ManeuverState &maneuver_state,
                                                    av_msgs::Trajectory &trajectory,
                                                    TrajectoryHistory &history,
                                                    bool &available_trajectory) {
    int num = trajectories.size();
    double best_eval = infinity;
    int best_index = -1;
    getSimilarityCosts(trajectories, localize, costs);
    bool exist_non_collision = false;
    for(int i=0; i<num; i++) {
        RiskIndex risk = risk_indexes[i];
        if(risk.is_collision) {
            continue;
        }
        exist_non_collision = true;
        Cost cost = costs[i];
        double eval = getEval(cost, risk);
        if(eval < best_eval) {
            best_eval = eval;
            best_index = i;
        }
    }
    if(!exist_non_collision) {
        ROS_ERROR("All trajectories collide");
    }
    bool is_stop = false;
    if(maneuver_state.v < 0.001 || maneuver_state.next_state == ManeuverCode::STOP ||  maneuver_state.next_state == ManeuverCode::EXIT) {
        is_stop = true;
        ROS_INFO("stop mode!");
    }
    if(best_index > -1) {
        available_trajectory = true;
        trajectory = trajectories[best_index];
        if(is_stop) {
            trajectory.driving_state = 1;
        } else {
            trajectory.driving_state = 0;
        }
		refreshTrajectoryInitialPose(trajectory, localize);
        uint64_t t = refreshTrajectoryTime(trajectory);
        history.previous_planning_time = t;
        history.previous_execute_time = costs[best_index].time_cost;
		last_trajectory_ = trajectory;
		last_localize_ = localize;
		is_first_planning_ = false;
		
        return ErrorCode::SUCCESS;
    } else{
        available_trajectory = false;
        return ErrorCode::ERROR;
    }
}

void TrajectorySelection::refreshTrajectoryInitialPose(av_msgs::Trajectory& trajectory, const av_msgs::Localize& localize) {
	av_msgs::Pose initial_pose;
	initial_pose.x = localize.pose_x;
	initial_pose.y = localize.pose_y;
	initial_pose.theta = localize.heading;
	trajectory.initial_pose = initial_pose;
}


double TrajectorySelection::getEval(const Cost cost, const RiskIndex risk) {
    double cost_val = velocity_ratio_*cost.velocity_cost + acceleration_ratio_*cost.acceleration_cost + jerk_ratio_*cost.jerk_cost 
                      + position_ratio_*cost.position_cost + curvature_ratio_*cost.curvature_cost + similarity_ratio_*cost.similarity_cost;
    double risk_val = risk.collision_probability<risk_barrier_ ? -log(risk_barrier_-risk.collision_probability) : infinity;
	//std::cout << "cost_val:" << cost.velocity_cost << ", " << cost.acceleration_cost << ", " << cost.jerk_cost << ", " << cost.position_cost << ", " << cost.curvature_cost << ", " << cost.similarity_cost << std::endl;
    return cost_val + risk_val;
}

void TrajectorySelection::getSimilarityCosts(const std::vector<av_msgs::Trajectory>& trajectories, const av_msgs::Localize& localize, std::vector<Cost>& costs) {
	if(is_first_planning_){
		return;
	}
    std::vector<double> last_xs, last_ys;
    bool isValid = transformPreviousTrajectory(localize, last_xs, last_ys);
    if(~isValid) {
        return;
    }
    int size = trajectories.size();
    for(int i=0; i<size; i++) {
        std::vector<av_msgs::Pose> poses = trajectories[i].poses;
        std::vector<double> xs, ys;
        int pose_size = poses.size();
        for(int j=0; j<pose_size; j++) {
            xs.push_back(poses[j].x);
            ys.push_back(poses[j].y);
        }
        double sim_x = getCosineSimilarity(last_xs, xs);
        double sim_y = getCosineSimilarity(last_ys, ys);
        costs[i].similarity_cost = (sim_x+sim_y)/2;
    }
}

double TrajectorySelection::getCosineSimilarity(const std::vector<double>& list1, const std::vector<double>& list2) {
    int size1 = list1.size(), size2 = list2.size();
    int size = size1<size2 ? size1 : size2;
    double sum_1=0, sum_2=0, sum_12=0;
    for(int i=0; i<size; i++) {
        sum_1 += pow(list1[i],2);
        sum_2 += pow(list2[i],2);
        sum_12 += (list1[i]*list2[i]);
    }
    double cosine = 1-abs(sum_12)/sqrt(sum_1*sum_2);
    return cosine;
}

bool TrajectorySelection::transformPreviousTrajectory(const av_msgs::Localize& localize, std::vector<double>& last_xs, std::vector<double>& last_ys) {
    std::vector<av_msgs::Pose> poses = last_trajectory_.poses;
    int size = poses.size();
    uint64_t t = av_comm::Now();
    int delta_t = static_cast<int>(sample_t_*1000);
    uint64_t last_t = poses[0].timestamp;
    int index = (t-last_t)/delta_t;
    if(index<0 || index>=size) {
        return false;
    }
    av_msgs::Pose pose_t = poses[index];
    if(pose_t.timestamp<t) {
        while(poses[index].timestamp<t && index<size) {
            index++;
        }
    } else if(pose_t.timestamp>t) {
        while(poses[index].timestamp>t && index > 0) {
            index--;
        }
    }

    double last_x = last_localize_.pose_x, last_y = last_localize_.pose_y, last_theta = last_localize_.heading;
    double x = localize.pose_x, y = localize.pose_y, theta = localize.heading;

    double trans_x = cos(last_theta)*(x-last_x) - sin(last_theta)*(y-last_y);
    double trans_y = sin(last_theta)*(x-last_x) + cos(last_theta)*(y-last_y);
    double rot_theta = theta-last_theta;

    for(int index_t=index; index_t<size; index_t++) {
        av_msgs::Pose pose = poses[index_t];
        double x = cos(rot_theta)*(pose.x-trans_x) - sin(rot_theta)*(pose.y-trans_y);
        double y = sin(rot_theta)*(pose.x-trans_x) + cos(rot_theta)*(pose.y-trans_y);
        last_xs.push_back(x);
        last_ys.push_back(y);
    }
    return true;
}

uint64_t TrajectorySelection::refreshTrajectoryTime(av_msgs::Trajectory& trajectory) {
    int size = trajectory.poses.size();
    uint64_t t0 = av_comm::Now();
    int delta_t = static_cast<int>(sample_t_*1000);
	uint64_t t = t0;
    for(int i=0; i<size; i++) {
        trajectory.poses[i].timestamp = t;
        t += delta_t;
    }
    return t0;
}
