#include <av_planning/candidate_trajectory.h>
#include <av_planning/planning_comm.h>
//#include <av_planning/gpu_calculator.h>
#include <cmath>
#include <vector>
#include <iostream>
#include <fstream>
#include <sys/time.h>
#include <thread>
#include <iterator>

using namespace std;
using namespace av_planning;
using namespace av_msgs;

CandidateTrajectory::CandidateTrajectory() : num_d_(10), num_t_(5), num_s_(10), min_t_(1), max_t_(5), min_s_(10), max_s_(50), sample_t_(0.05), horizon_t_(5){
    ros::param::get("~/candidate_trajectory/use_gpu", use_gpu_);
    ros::param::get("~/candidate_trajectory/record_trajectory", record_trajectory_);
    ros::param::get("~/candidate_trajectory/num_d", num_d_);
    ros::param::get("~/candidate_trajectory/num_t", num_t_);
    ros::param::get("~/candidate_trajectory/num_s", num_s_);
    ros::param::get("~/candidate_trajectory/min_t", min_t_);
    ros::param::get("~/candidate_trajectory/max_t", max_t_);
    ros::param::get("~/candidate_trajectory/min_s", min_s_);
    ros::param::get("~/candidate_trajectory/max_s", max_s_);

    ros::param::get("~ego_width", ego_width_);

	ros::param::get("~/candidate_trajectory/v_ref_max_ratio", v_ref_max_ratio_);
	ros::param::get("~/candidate_trajectory/v_ref_min_ratio", v_ref_min_ratio_);

	ros::param::get("~/candidate_trajectory/acceleration_nomalization", acceleration_normalization_);
	ros::param::get("~/candidate_trajectory/jerk_nomalization", jerk_normalization_);
	ros::param::get("~/candidate_trajectory/curvature_nomalization", curvature_normalization_);
	
    ros::param::get("~t_sample", sample_t_);
    ros::param::get("~t_horizon", horizon_t_);
	ros::param::get("~path_planning_rate", planning_rate_);

	ros::param::get("~candidate_trajectory/thread_num", thread_num_);

    double tmp = 0;
    ros::param::get("~/candidate_trajectory/coefficient_d_val", tmp);
    coefficient_d_.push_back(tmp);
    ros::param::get("~/candidate_trajectory/coefficient_d_deriv1", tmp);
    coefficient_d_.push_back(tmp);
    ros::param::get("~/candidate_trajectory/coefficient_d_deriv2", tmp);
    coefficient_d_.push_back(tmp);

    ros::param::get("~/candidate_trajectory/coefficient_s_val", tmp);
    coefficient_s_.push_back(tmp);
    ros::param::get("~/candidate_trajectory/coefficient_s_deriv1", tmp);
    coefficient_s_.push_back(tmp);
    ros::param::get("~/candidate_trajectory/coefficient_s_deriv2", tmp);
    coefficient_s_.push_back(tmp);

    for(double t=0; t<=horizon_t_; t+=sample_t_) {
		t_list_.push_back(t);
	}
    //gpu_calculator_ = new GpuCalculator();
}

CandidateTrajectory::~CandidateTrajectory() {

}

enum ErrorCode CandidateTrajectory::GenerateCandidateTrajectories(const ManeuverState &maneuver_state, const av_msgs::Localize &localize, const TrajectoryHistory &history,
																  std::vector<av_msgs::Trajectory> &trajectories, std::vector<Cost> &costs) {
	// The minimum and maximum reference velocity
    double maneuver_v = maneuver_state.v;
    maneuver_v = maneuver_v > 2 ? 2 : maneuver_v;
	double v_ref_min = maneuver_v * v_ref_min_ratio_;
	double v_ref_max = maneuver_v * v_ref_max_ratio_;

	// Get mode for trajectory optimization according to the maneuver
	Mode mode = Mode::MOVE_MODE;
	double stop_dist = 0;
	double stop_t = 0;
	if(maneuver_state.v < eps || maneuver_state.next_state == ManeuverCode::STOP ||  maneuver_state.next_state == ManeuverCode::EXIT) {
		mode = Mode::STOP_MODE;
		stop_dist = maneuver_state.stop_distance;
        stop_t = horizon_t_;
		/* if(pre_mode_ == Mode::STOP_MODE) {
			stop_t = history.previous_execute_time - 1/planning_rate_;
			stop_t = stop_t<0 ? 0 : stop_t;
		} else{
			stop_t = horizon_t_;
		} */
	}
	for(std::vector<LaneGroup>::const_iterator iter_lane_group = maneuver_state.lane_group_list.begin(); iter_lane_group != maneuver_state.lane_group_list.end(); iter_lane_group++) {
		for(std::vector<Lane>::const_iterator iter_lane = iter_lane_group->lanes.begin(); iter_lane != iter_lane_group->lanes.end(); iter_lane++) {
			std::vector<av_msgs::Trajectory> trajectories_one_lane;
			std::vector<Cost> costs_one_lane;
			generateTrajectoryForOneLane(maneuver_state, *(iter_lane), localize, v_ref_min, v_ref_max, mode, stop_dist, stop_t, trajectories_one_lane, costs_one_lane);
			std::copy(trajectories_one_lane.begin(), trajectories_one_lane.end(), std::back_inserter(trajectories));
			std::copy(costs_one_lane.begin(), costs_one_lane.end(), std::back_inserter(costs));
		}
	}
	
	if(record_trajectory_) {
		recordTrajectory(trajectories);
	}
	return ErrorCode::SUCCESS;
}

void CandidateTrajectory::generateTrajectoryForOneLane(const ManeuverState& maneuver_state, const Lane& lane, const av_msgs::Localize& localize, double v_ref_min, double v_ref_max, Mode mode, double stop_dist, double stop_t, std::vector<av_msgs::Trajectory>& trajectories, std::vector<Cost>& costs) {
	const spline& ref_x_curve = lane.ref_line.curve_x;
	const spline& ref_y_curve = lane.ref_line.curve_y;
	double lane_width = lane.width;
	spline ref_theta_curve;
	getReferencePath(lane.ref_line, ref_theta_curve);
	// Get initial conditions of s, d with respect to the reference path
	State s0_states, d0_states;
	double v0 = sqrt(pow(localize.vel_x,2)+pow(localize.vel_y,2));
	double a0 = sqrt(pow(localize.acc_x,2)+pow(localize.acc_y,2));
	getInitialConditions(v0, a0, ref_x_curve, ref_y_curve, ref_theta_curve, s0_states, d0_states);
	
	Range d_range;
	d_range.min_value = -(lane.width - ego_width_)/2;
	d_range.max_value = (lane.width - ego_width_)/2;
	
	// Get candidate trajectories for s, d
    std::vector<Curve> s_curves, d_curves;
	getSCandidates(mode, v_ref_min, v_ref_max, s0_states, s_curves, stop_dist, stop_t);
	ROS_INFO("generated %d s candidates", int(s_curves.size()));
	getDCandidates(min_s_, max_s_, d0_states, d_range, d_curves);
	ROS_INFO("generated %d d candidates", int(d_curves.size()));
	// recordTrajectory(s_curves);
    
	// Generate trajectories by combining s, d
    if (use_gpu_){
	    combineTrajectoriesGpu(maneuver_state, s_curves, d_curves, ref_x_curve, ref_y_curve, ref_theta_curve, localize, s0_states.val, d_range, trajectories, costs);
    }else{
        combineTrajectories(maneuver_state, s_curves, d_curves, ref_x_curve, ref_y_curve, ref_theta_curve, localize, s0_states.val, d_range, trajectories, costs);
    }
}

void CandidateTrajectory::getReferencePath(const ParameterLane& ref_line, spline& ref_theta_curve){
	double lane_length = ref_line.length;
	std::vector<double> ss, thetas;
	double delta_s = 0.1;
	double x, y, x_next, y_next, delta_x, delta_y, theta;
	// Calculate the points on the reference path as the middle of the lanes
	for(double s=0; s<lane_length; s+=delta_s) {
		ss.push_back(s);
		x = ref_line.curve_x(s);
		y = ref_line.curve_y(s);
		x_next = ref_line.curve_x(s + delta_s);
		y_next = ref_line.curve_y(s + delta_s);
		delta_x = x_next-x;
		delta_y = y_next-y;
		theta = atan2(delta_y, delta_x);
		thetas.push_back(theta);
	}
	ref_theta_curve.setPoints(ss, thetas);
}

void CandidateTrajectory::getInitialConditions(double v0, double a0, const spline& ref_x_curve,
		const spline& ref_y_curve, const spline& ref_theta_curve, State& s0_states, State& d0_states) {
	double d0=0, d0_deriv1=0, d0_deriv2=0, d0_deriv1_t=0, d0_deriv2_t=0, s0=0, s0_deriv1=0, s0_deriv2=0;
	// Find the closest point of the current vehicle on the reference path
	spline::getClosestPointOnCurveWithExtension(ref_x_curve, ref_y_curve, 0, 0, s0, d0);
	double x0_ref = ref_x_curve(s0);
	double y0_ref = ref_y_curve(s0);
	double theta0_ref = ref_theta_curve(s0);
	if(y0_ref < 0) {
		d0 = -d0;
	}
	if(a0 > 2) a0 = 2;
	if(a0 < -2) a0 = -2;
    double cos_val = cos(theta0_ref);
    double sin_val = sin(theta0_ref);
    //double cos_val = fast_cos(theta0_ref);
    //double sin_val = fast_sin(theta0_ref);
	s0_deriv1 = v0*cos_val; // first order derivative of s with respect to t
	s0_deriv2 = a0*cos_val; // second order derivative of s with respect to t
	s0_deriv2 = a0*cos_val; // second order derivative of s with respect to t
	d0_deriv1_t = v0*sin_val; // first order derivative of d with respect to t
	d0_deriv2_t = a0*sin_val; // second order derivative of d with respect to t

	// get the derivatives of d with respect to s
	if(s0_deriv1 < eps) {
		d0_deriv1 = 0;
	} else{
		d0_deriv1 = d0_deriv1 / s0_deriv1;
	}
	if(s0_deriv2 < eps) {
		d0_deriv2 = 0;
	} else{
		d0_deriv2 = d0_deriv2 / s0_deriv2;
	}
	s0_states.val = s0;
	s0_states.deriv1 = s0_deriv1;
	s0_states.deriv2 = s0_deriv2;
	d0_states.val = d0;
	d0_states.deriv1 = d0_deriv1;
	d0_states.deriv2 = d0_deriv2;
}

void CandidateTrajectory::combineTrajectoriesGpu(const ManeuverState &maneuver_state, const std::vector<Curve>& s_curves, const std::vector<Curve>& d_curves, const spline& ref_x_curve,
                             const spline& ref_y_curve, const spline& ref_theta_curve, const av_msgs::Localize& localize, const double& s0, Range d_range, std::vector<av_msgs::Trajectory >& trajectories, std::vector<Cost>& costs) {
	//gpu_calculator_->combineTrajectoriesGpu(t_list_, sample_t_, maneuver_state, s_curves, d_curves, ref_x_curve, ref_y_curve, ref_theta_curve, localize, s0, d_range, trajectories, costs, acceleration_normalization_, jerk_normalization_, curvature_normalization_);
}

void CandidateTrajectory::combineTrajectories(const ManeuverState &maneuver_state, const std::vector<Curve>& s_curves, const std::vector<Curve>& d_curves, const spline& ref_x_curve,
                             const spline& ref_y_curve, const spline& ref_theta_curve, const av_msgs::Localize& localize, const double& s0, Range d_range, std::vector<av_msgs::Trajectory >& trajectories, std::vector<Cost>& costs) {
	trajectories.clear();
	costs.clear();

	int s_num = s_curves.size(), d_num = d_curves.size();
	int traj_num = s_num * d_num;
	trajectories.resize(traj_num);
	costs.resize(traj_num);

    int this_thread_num = thread_num_;
	this_thread_num = this_thread_num < s_num ? this_thread_num : s_num;
	int block_num = ceil(double(s_num) / this_thread_num);

	std::vector<int> is_valid(traj_num);

	std::vector<std::thread> thread_list;
	int begin_index, end_index;

	for(int i=0; i < this_thread_num; i++) {
		begin_index = i * block_num;
		end_index = (i + 1) * block_num;
		end_index = end_index > s_num ? s_num : end_index;
		thread_list.emplace_back(combineTrajectoryThread, this, maneuver_state, std::ref(s_curves), std::ref(d_curves), 
								std::ref(ref_x_curve), std::ref(ref_y_curve), std::ref(ref_theta_curve), std::ref(localize),
								s0, d_range, begin_index, end_index, std::ref(trajectories), std::ref(costs), std::ref(is_valid));
	}

	for(std::vector<std::thread>::iterator iter = thread_list.begin(); iter != thread_list.end(); iter++) {
		iter->join();
	}
	
    std::vector<av_msgs::Trajectory>::iterator iter_traj = trajectories.begin(); 
    std::vector<Cost>::iterator iter_cost = costs.begin(); 
    int index = 0;
    while(iter_traj != trajectories.end() && iter_cost != costs.end()) {
        if(is_valid[index] < 1) {
            trajectories.erase(iter_traj);
            costs.erase(iter_cost);
        } else {
            iter_traj++;
            iter_cost++;
        }
        index++;
    }
}

void CandidateTrajectory::combineTrajectoryThread(CandidateTrajectory* ct, const ManeuverState& maneuver_state, const std::vector<Curve>& s_curves, const std::vector<Curve>& d_curves, 
				const spline& ref_x_curve, const spline& ref_y_curve, const spline & ref_theta_curve, const av_msgs::Localize& localize,  
				double s0, Range d_range, int begin_index, int end_index, std::vector<av_msgs::Trajectory>& trajectories, std::vector<Cost>& costs, std::vector<int>& is_valid) {
	ct->combineTrajectoryThreadImpl(maneuver_state, s_curves, d_curves, ref_x_curve, ref_y_curve, ref_theta_curve, localize, s0, d_range, begin_index, end_index, trajectories, costs, is_valid);
}

void CandidateTrajectory::combineTrajectoryThreadImpl(const ManeuverState& maneuver_state, const std::vector<Curve>& s_curves, const std::vector<Curve>& d_curves, 
				const spline& ref_x_curve, const spline& ref_y_curve, const spline & ref_theta_curve, const av_msgs::Localize& localize, 
				double s0, Range d_range, int begin_index, int end_index, std::vector<av_msgs::Trajectory>& trajectories, std::vector<Cost>& costs, std::vector<int>& is_valid) {
	int d_num = d_curves.size();
	int traj_length = t_list_.size();
	for(int s_index = begin_index; s_index < end_index; s_index ++) {
		// Get values of s along the trajectory
		Curve s_curve = s_curves[s_index];
		
		vector<double> s_list, s_real_list, s_dot_list, s_ddot_list;
		polyCurveVal(t_list_, s_real_list, s_list, s_curve, -s0, true);
		polyCurveDeriv1(t_list_, s_dot_list, s_curve, false);
		polyCurveDeriv2(t_list_, s_ddot_list, s_curve);

		// Get points on the reference path for specific s
		vector<double> ref_x_list, ref_y_list, ref_theta_list, ref_x_dot_list, ref_x_ddot_list, ref_y_dot_list, ref_y_ddot_list, ref_theta_dot_list, ref_theta_ddot_list;

		splineCurveVal(s_real_list, ref_x_list, ref_x_curve);
		splineCurveVal(s_real_list, ref_y_list, ref_y_curve);
		splineCurveVal(s_real_list, ref_theta_list, ref_theta_curve);

        splineCurveDeriv1(s_real_list, ref_x_dot_list, ref_x_curve);
        splineCurveDeriv1(s_real_list, ref_y_dot_list, ref_y_curve);
        splineCurveDeriv1(s_real_list, ref_theta_dot_list, ref_theta_curve);

        splineCurveDeriv2(s_real_list, ref_x_ddot_list, ref_x_curve);
        splineCurveDeriv2(s_real_list, ref_y_ddot_list, ref_y_curve);
        splineCurveDeriv2(s_real_list, ref_theta_ddot_list, ref_theta_curve);

		for(int d_index = 0; d_index < d_num; d_index ++) {
			// Get values of d for specific s
			Curve d_curve = d_curves[d_index];
			vector<double> d_list, d_dot_list, d_ddot_list;
			polyCurveVal(s_list, d_list, d_curve, false);
            polyCurveDeriv1(s_list, d_dot_list, d_curve, false);
            polyCurveDeriv2(s_list, d_ddot_list, d_curve);

			vector<Pose> poses;
            Trajectory traj;
			
			int traj_index = s_index * d_num + d_index;
			is_valid[traj_index] = 1;
            double d0 = d_list.front();
            double d_min = (d0 < d_range.min_value ? d0 : d_range.min_value);
            double d_max = (d0 > d_range.max_value ? d0 : d_range.max_value);

			// Transform to Euclidean coordinate
			for(int i=0; i<traj_length; i++) {
				double d = d_list[i], d_dot = d_dot_list[i], d_ddot = d_ddot_list[i];
				if(d < d_min || d > d_max) {
					is_valid[traj_index] = 0;
					break;
				}
				double ref_x = ref_x_list[i];
				double ref_y = ref_y_list[i];
				double ref_theta = ref_theta_list[i];
                double sin_ref_theta = sin(ref_theta), cos_ref_theta = cos(ref_theta);
                double x = ref_x + d*sin_ref_theta;
                double y = ref_y - d*cos_ref_theta;

                double ref_y_dot = ref_y_dot_list[i], ref_x_dot = ref_x_dot_list[i], ref_theta_dot = ref_theta_dot_list[i];
                double ref_y_ddot = ref_y_ddot_list[i], ref_x_ddot = ref_x_ddot_list[i], ref_theta_ddot = ref_theta_ddot_list[i];
                double x_dot = ref_x_dot + d_dot * sin_ref_theta + d * cos_ref_theta * ref_theta_dot;
                double y_dot = ref_y_dot - d_dot * cos_ref_theta + d * sin_ref_theta * ref_theta_dot;
                double x_ddot = ref_x_ddot + d_ddot * sin_ref_theta + d_dot * cos_ref_theta * ref_theta_dot + d_dot * cos_ref_theta * ref_theta_dot - d * sin_ref_theta * ref_theta_dot * ref_theta_dot + d * cos_ref_theta * ref_theta_ddot;
                double y_ddot = ref_y_ddot - d_ddot * cos_ref_theta + d_dot * sin_ref_theta * ref_theta_dot + d_dot * sin_ref_theta * ref_theta_dot + d * cos_ref_theta * ref_theta_dot * ref_theta_dot + d * sin_ref_theta * ref_theta_ddot;
                double theta = atan2(y_dot, x_dot);
                double vel = s_dot_list[i];
                double acc = s_ddot_list[i];
                double curvature = (x_dot * y_ddot - y_dot * x_ddot) / pow(x_dot * x_dot + y_dot * y_dot, 1.5);

                Pose pose;
                pose.timestamp = i*sample_t_; // will be refreshed after trajectory selection
                pose.x = x;
                pose.y = y;
                pose.theta = theta;
                pose.velocity = vel;
                pose.acceleration = acc;
                pose.curvature = curvature;
                poses.push_back(pose);
			}
			if(is_valid[traj_index] < 1){
				continue;
			}
			// getTrajectoryInformation(poses, localize);  // Get angle and curvature information
            traj.poses = poses;
            traj.driving_direction = 0;
            traj.driving_state = 0;

			// Get cost for each trajectory
			Cost cost;
			getTrajectoryCost(poses, d_list, d_range, s_dot_list, s_ddot_list, maneuver_state, cost);
			cost.time_cost = s_curve.terminal;

			costs[traj_index] = cost;

			trajectories[traj_index] = traj;
		}
	}
}


void CandidateTrajectory::getTrajectoryInformation(vector<Pose>& poses, const av_msgs::Localize& localize) {
	vector<Pose>::iterator iter = poses.begin();
	vector<Pose>::iterator iter_end = poses.end();
	double theta0 = localize.heading;
	double curvature0 = 0;
	for(iter=poses.begin()+1; iter<iter_end-1; iter++) {
		Pose& pose = *(iter);
		Pose& pose_next = *(iter+1);
		Pose& pose_pre = *(iter-1);
		double delta_x = pose_next.x-pose.x;
		double delta_y = pose_next.y-pose.y;
		double delta_x_pre = pose.x-pose_pre.x;
		double delta_y_pre = pose.y-pose_pre.y;

		double delta_dist = sqrt(pow(delta_x,2)+pow(delta_y,2));
		double delta_dist_pre = sqrt(pow(delta_x_pre,2)+pow(delta_y_pre,2));

		double curvature = curvature0;
		double theta = theta0;
		// Calculate theta and curvature avoiding singularity
		if(delta_dist > eps) {
			theta = atan2(delta_y, delta_x);
			// Calculate curvature using first & second order derivatives
			if(delta_dist_pre > eps) {
				double x_dot = delta_x / delta_dist, y_dot = delta_y / delta_dist;
				double x_dot_pre = delta_x_pre / delta_dist_pre, y_dot_pre = delta_y_pre / delta_dist_pre;
				double x_ddot = (x_dot-x_dot_pre)/delta_dist_pre, y_ddot = (y_dot-y_dot_pre)/delta_dist_pre;
				curvature = abs(x_dot*y_ddot-x_ddot*y_dot)/(pow(sqrt(x_dot*x_dot+y_dot*y_dot), 3));
			}
		}
		theta0 = theta;
		curvature0 = curvature;
		pose.theta = theta;
		pose.velocity = delta_dist / sample_t_;
		pose.acceleration = (delta_dist - delta_dist_pre) / pow(sample_t_, 2);
        pose.curvature = curvature;
	}
	// The first and final points are set as the same with their neighbouring points 
	(poses.begin())->theta = (poses.begin()+1)->theta;
	(poses.begin())->velocity = (poses.begin()+1)->velocity;
	(poses.begin())->acceleration = (poses.begin()+1)->acceleration;
	(poses.begin())->curvature = (poses.begin()+1)->curvature;

	(poses.end())->theta = (poses.end()-1)->theta;
	(poses.end())->velocity = (poses.end()-1)->velocity;
	(poses.end())->acceleration = (poses.end()-1)->acceleration;
	(poses.end())->curvature = (poses.end()-1)->curvature; 
}

void CandidateTrajectory::getTrajectoryCost(const std::vector<av_msgs::Pose>& poses, const std::vector<double>& d_list, const Range& d_range, const std::vector<double>& accelerations, 
											const std::vector<double>& jerks, const ManeuverState& maneuver_state, Cost& cost) {
	double velocity_cost_sum=0, acceleration_cost_sum=0, jerk_cost_sum=0, curvature_cost_sum=0, position_cost_sum=0;
	int size = poses.size();
	for(int i=0; i<size; i++) {
		Pose pose = poses[i];
		velocity_cost_sum += abs(pose.velocity-maneuver_state.v);
		acceleration_cost_sum += abs(accelerations[i]);
		jerk_cost_sum += abs(jerks[i]);
		curvature_cost_sum += abs(pose.curvature);
		position_cost_sum += abs(d_list[i]);
	}
	double velocity_cost = velocity_cost_sum/size;
	double acceleration_cost = acceleration_cost_sum/size;
	double jerk_cost = jerk_cost_sum/size;
	double curvature_cost = curvature_cost_sum/size;
	double position_cost = position_cost_sum/size;
	double similarity_cost = 0; // the similarity cost will be computed in trajectory selection

	// Normalize the costs
	if(maneuver_state.v > eps) {
		velocity_cost = velocity_cost / abs(maneuver_state.v);
	} else{
		; // occurs in stop mode
	}
	cost.velocity_cost = velocity_cost;
	cost.acceleration_cost = acceleration_cost / acceleration_normalization_;
	cost.jerk_cost = jerk_cost / jerk_normalization_;
	cost.curvature_cost = curvature_cost / curvature_normalization_;
	cost.position_cost = position_cost / fabs(d_range.max_value - d_range.min_value);
	cost.similarity_cost = similarity_cost;
}

void CandidateTrajectory::getDCandidates(double s_min, double s_max, State d0,
		Range d_range, vector<Curve>& d_curves) {
	d_curves.clear();

	double s_delta = (s_max-s_min)/num_s_;
	for(double s=s_min; s<=s_max; s+=s_delta) {
		double d_min = d_range.min_value;
		double d_max = d_range.max_value;
		double d_delta = (d_max-d_min)/num_d_;
		double d_mid = (d_min+d_max)/2;
		for(double d=d_mid; d<=d_max; d+=d_delta) {
			State dr(d, 0, 0);
			vector<double> d_curve, d_dot_curve, d_ddot_curve;
			optimizeMove(s, d0,	dr, coefficient_d_, d_curve, d_dot_curve, d_ddot_curve);
			Curve curve(d_curve, d_dot_curve, d_ddot_curve, s);
			d_curves.push_back(curve);
		}
		for(double d=d_mid-d_delta; d>=d_min; d-=d_delta) {
			State dr(d, 0, 0);
			vector<double> d_curve, d_dot_curve, d_ddot_curve;
			optimizeMove(s, d0,	dr, coefficient_d_, d_curve, d_dot_curve, d_ddot_curve);
			Curve curve(d_curve, d_dot_curve, d_ddot_curve, s);
			d_curves.push_back(curve);
		}
	}
}

void CandidateTrajectory::getSCandidates(Mode mode, double v_ref_min, double v_ref_max,
		State s0, vector<Curve>& s_curves,	double stop_dist=0, double stop_t=0) {
	s_curves.clear();
	double delta_t=(max_t_-min_t_)/num_t_;
	if(mode == MOVE_MODE) {
		double s_dot_delta = (v_ref_max-v_ref_min)/num_s_;
		for(double s_dot=v_ref_min; s_dot<=v_ref_max; s_dot+=s_dot_delta) {
			// for(double t=min_t_; t<=max_t_; t+=delta_t) {
				double t = max_t_;
				State sr((s_dot+s0.deriv1)/2*t+s0.val, s_dot, 0);
				vector<double> s_curve, s_dot_curve, s_ddot_curve;
				optimizeMove(t, s0, sr, coefficient_s_, s_curve, s_dot_curve, s_ddot_curve);
				Curve curve(s_curve, s_dot_curve, s_ddot_curve, t);
				s_curves.push_back(curve);
			// }
		}
	} else if (mode == STOP_MODE) {
		if (stop_t>0) {
			vector<double> s_curve, s_dot_curve, s_ddot_curve;
			optimizeStop(stop_t, stop_dist+s0.val, s0, s_curve, s_dot_curve, s_ddot_curve);
			Curve curve(s_curve, s_dot_curve, s_ddot_curve, stop_t);
			s_curves.push_back(curve);
		} else {
			for (double t=min_t_; t<=max_t_; t+=delta_t) {
				vector<double> s_curve, s_dot_curve, s_ddot_curve;
				optimizeStop(stop_t, stop_dist+s0.val, s0, s_curve, s_dot_curve, s_ddot_curve);
				Curve curve(s_curve, s_dot_curve, s_ddot_curve, t);
				s_curves.push_back(curve);
			}
		}
	}
}

void CandidateTrajectory::optimizeMove(double t, State state_0,
		State state_r, vector<double> coefficient,
		vector<double>& c, vector<double>& c_dot, vector<double>& c_ddot){
	double t_5 = pow(t, 5);
	double t_4 = pow(t, 4);
	double t_3 = pow(t, 3);
	double t_2 = pow(t, 2);

    vector<vector<double> > a_cost = {
        {(coefficient[0]*t_5/120+1) , (-coefficient[0]*t_4/24) , (coefficient[0]*t_3/6)},
        {(coefficient[1]*t_4/24-t) , (1-coefficient[1]*t_3/6) , (coefficient[1]*t_2/2)},
        {(coefficient[2]*t_3/6+t_2/2) , (coefficient[2]*t_2/2-t) , (coefficient[2]*t+1)}
    };
    vector<double> b_cost = {
        (coefficient[0]*(state_0.val+state_0.deriv1*t+0.5*state_0.deriv2*t_2-state_r.val)),
		(coefficient[1]*(state_0.deriv2*t+state_0.deriv1-state_r.deriv1)),
		(coefficient[2]*(state_0.deriv2-state_r.deriv2))
    };

	vector<double> c0;

    solveOptimization(a_cost, b_cost, c0);

	c.clear();
	c.push_back(-c0[0]/120);
	c.push_back(c0[1]/24);
	c.push_back(-c0[2]/6);
	c.push_back(state_0.deriv2/2);
	c.push_back(state_0.deriv1);
	c.push_back(state_0.val);

	c_dot.clear();
	c_dot.push_back(-c0[0]/24);
	c_dot.push_back(c0[1]/6);
	c_dot.push_back(-c0[2]/2);
	c_dot.push_back(state_0.deriv2);
	c_dot.push_back(state_0.deriv1);

	c_ddot.clear();
	c_ddot.push_back(-c0[0]/6);
	c_ddot.push_back(c0[1]/2);
	c_ddot.push_back(-c0[2]);
	c_ddot.push_back(state_0.deriv2);
}

void CandidateTrajectory::optimizeStop(double t, double stop_distance, State state_0,
			vector<double>& c, vector<double>& c_dot, vector<double>& c_ddot) {
    c.clear();
    c_dot.clear();
    c_ddot.clear();
    if(t < eps) {
        c.push_back(state_0.val);
    } else {
        c.push_back((stop_distance-state_0.val) / t);
        c.push_back(state_0.val);
    }
    c_dot.push_back(0);
    c_ddot.push_back(0);
}

void CandidateTrajectory::polyCurveVal(const vector<double>& xs, vector<double>& ys, const Curve& curve, bool isExtend){
	ys.clear();
	vector<double> c = curve.c, c_dot=curve.c_dot;
	double end_x=curve.terminal;
	vector<double>::const_iterator iter, iter_end = xs.end();
	double y = 0, last_x = 0, last_y = 0;
	for(iter=xs.begin(); iter<iter_end; iter++){
		double x = *(iter);
		if(x<=end_x){
			y = polyVal(x, c);
		} else{
            if(isExtend) {
			    double y_dot = polyVal(end_x, c_dot);
			    y = last_y + y_dot*(x-last_x);
            } else {
                y = last_y;
            }
		}
		last_x = x;
		last_y = y;
		ys.push_back(y);
	}
}

void CandidateTrajectory::polyCurveVal(const vector<double>& xs, vector<double>& ys, vector<double>& ys_offset, const Curve& curve, const double& offset, bool isExtend){
	ys.clear();
	ys_offset.clear();
	vector<double> c = curve.c, c_dot=curve.c_dot;
	double end_x=curve.terminal;
	vector<double>::const_iterator iter, iter_end = xs.end();
	double y = 0, last_x = 0, last_y = 0;
	for(iter=xs.begin(); iter<iter_end; iter++){
		double x = *(iter);
		if(x<=end_x){
			y = polyVal(x, c);
		} else{
            if(isExtend) {
			    double y_dot = polyVal(end_x, c_dot);
			    y = last_y + y_dot*(x-last_x);
            } else {
                y = last_y;
            }
		}
		last_x = x;
		last_y = y;
		ys.push_back(y);
		ys_offset.push_back(y+offset);
	}
}

void CandidateTrajectory::polyCurveDeriv1(const std::vector<double>& xs, std::vector<double>& y_dots, const Curve& curve, bool isExtend) {
	y_dots.clear();
	vector<double> c_dot=curve.c_dot, c_ddot=curve.c_ddot;
	double end_x=curve.terminal;
	vector<double>::const_iterator iter, iter_end = xs.end();
	double y_dot = 0, last_x = 0, last_y_dot = 0;
	for(iter=xs.begin(); iter<iter_end; iter++){
		double x = *(iter);
		if(x<=end_x){
			y_dot = polyVal(x, c_dot);
		} else{
            if(isExtend) {
	    		double y_ddot = polyVal(end_x, c_ddot);
    			y_dot = last_y_dot + y_dot*(x-last_x);
            } else {
                y_dot = last_y_dot;
            }
		}
		last_x = x;
		last_y_dot = y_dot;
		y_dots.push_back(y_dot);
	}
}

void CandidateTrajectory::polyCurveDeriv2(const std::vector<double>& xs, std::vector<double>& y_ddots, const Curve& curve) {
	y_ddots.clear();
	vector<double> c_ddot=curve.c_ddot;
	double end_x=curve.terminal;
	vector<double>::const_iterator iter, iter_end = xs.end();
	double y_ddot = 0, last_x = 0, last_y_ddot = 0;
	for(iter=xs.begin(); iter<iter_end; iter++){
		double x = *(iter);
		if(x<=end_x){
			y_ddot = polyVal(x, c_ddot);
		} else{
			y_ddot = last_y_ddot;
		}
		last_x = x;
		last_y_ddot = y_ddot;
		y_ddots.push_back(y_ddot);
	}
}

void CandidateTrajectory::splineCurveVal(const vector<double>& xs, vector<double>& ys, const spline& curve) {
	ys.clear();
	vector<double>::const_iterator iter, iter_end = xs.end();
	for(iter=xs.begin(); iter<iter_end; iter++){
		double x = *(iter);
		double y = curve(x);
		ys.push_back(y);
	}
}

void CandidateTrajectory::splineCurveDeriv1(const vector<double>& xs, vector<double>& y_dots, const spline& curve) {
    y_dots.clear();
    vector<double>::const_iterator iter, iter_end = xs.end();
    for(iter=xs.begin(); iter<iter_end; iter++){
        double x = *(iter);
        double y_dot = curve.deriv1(x);
        y_dots.push_back(y_dot);
    }
}

void CandidateTrajectory::splineCurveDeriv2(const vector<double>& xs, vector<double>& y_ddots, const spline& curve) {
    y_ddots.clear();
    vector<double>::const_iterator iter, iter_end = xs.end();
    for(iter=xs.begin(); iter<iter_end; iter++){
        double x = *(iter);
        double y_ddot = curve.deriv2(x);
        y_ddots.push_back(y_ddot);
    }
}

double CandidateTrajectory::polyVal(double x, vector<double> coefficients) {
	double y = 0;
	int order = coefficients.size();
	for(int i=0; i<order; i++) {
		y += (coefficients[i]*pow(x,(order-i-1)));
	}
	return y;
}

// TODO: deal with singular A
void CandidateTrajectory::solveOptimization(const vector<vector<double> >& A, const vector<double>& B, vector<double>& C) {
    double a11 = A[0][0], a12 = A[0][1], a13 = A[0][2];
    double a21 = A[1][0], a22 = A[1][1], a23 = A[1][2];
    double a31 = A[2][0], a32 = A[2][1], a33 = A[2][2];
    double b1 = B[0];
    double b2 = B[1];
    double b3 = B[2];

    double det_a = a11*a22*a33 + a12*a23*a31 + a13*a21*a32 - a13*a22*a31 - a11*a23*a32 - a12*a21*a33;
    double adj_a11 = a22*a33 - a23*a32, adj_a12 = -(a12*a33-a13*a32), adj_a13 = a12*a23-a13*a22;
    double adj_a21 = -(a21*a33-a23*a31), adj_a22 = a11*a33-a13*a31, adj_a23 = -(a11*a23-a13*a21);
    double adj_a31 = a21*a32-a22*a31, adj_a32 = -(a11*a32-a12*a31), adj_a33 = a11*a22-a12*a21;
    
    double c1 = adj_a11*b1 + adj_a12*b2 + adj_a13*b3;
    double c2 = adj_a21*b1 + adj_a22*b2 + adj_a23*b3;
    double c3 = adj_a31*b1 + adj_a32*b2 + adj_a33*b3;

    C.clear();
    C.push_back(c1/det_a);
    C.push_back(c2/det_a);
    C.push_back(c3/det_a);
    
}

void CandidateTrajectory::recordTrajectory(const std::vector<av_msgs::Trajectory> &trajectories) {
    std::vector<av_msgs::Trajectory>::const_iterator iter, iter_end=trajectories.end();
	char* file_name = new char[50];
	sprintf(file_name, "trajs/traj-%ld.log", av_comm::Now());
	ofstream file;
	file.open(file_name);
	ROS_INFO("recording generated trajectories...");
    for(iter=trajectories.begin(); iter!=iter_end; iter++) {
        std::vector<av_msgs::Pose> poses = iter->poses;
        std::vector<av_msgs::Pose>::const_iterator iter_pose, iter_pose_end=poses.end();
        for(iter_pose=poses.begin(); iter_pose!=iter_pose_end; iter_pose++) {
			file << iter_pose->x << " " << iter_pose->y << " " << iter_pose->theta << " " << iter_pose->curvature << " " << iter_pose->velocity << "\n";
        }
		file << std::endl;
    }
	file.close();
}

void CandidateTrajectory::recordTrajectory(const std::vector<Curve> &curves) {
    std::vector<Curve>::const_iterator iter, iter_end=curves.end();
	char* file_name = new char[50];
	sprintf(file_name, "curves/curve-%ld.log", av_comm::Now());
	ofstream file;
	file.open(file_name);
	ROS_INFO("recording generated trajectories...");
    for(iter=curves.begin(); iter!=iter_end; iter++) {
        std::vector<double> curve_c = iter->c;
		for(auto iter_c=curve_c.begin(); iter_c!=curve_c.end(); iter_c++)
			file << *(iter_c) << " ";
		file << std::endl;
    }
	file.close();
}

inline double CandidateTrajectory::fast_sin(double x) {
    x = fmod(x + M_PI, M_PI * 2) - M_PI;
    double x2 = x * x;
    return (((((-2.05342856289746600727e-08*x2 + 2.70405218307799040084e-06)*x2
               - 1.98125763417806681909e-04)*x2 + 8.33255814755188010464e-03)*x2
               - 1.66665772196961623983e-01)*x2 + 9.99999707044156546685e-01)*x;
}

inline double CandidateTrajectory::fast_cos(double x) {
    return fast_sin(x + M_PI / 2);
}
