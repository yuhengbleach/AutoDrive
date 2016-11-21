#ifndef MUSTANG_AV_PLANNING_CANDIDATE_TRAJECTORY_H
#define MUSTANG_AV_PLANNING_CANDIDATE_TRAJECTORY_H

#include <av_msgs/Trajectory.h>
#include <av_msgs/Pose.h>

#include <av_planning/planning_comm.h>
#include <av_planning/maneuver.h>
#include <av_planning/spline.h>
#include <chrono>
#include <vector>

namespace av_planning {

template <class Rep = uint64_t, class Period = std::milli> Rep Now() {
    using namespace std::chrono;
    return time_point_cast <duration <Rep, Period>> (
        system_clock::now()).time_since_epoch().count();
}

class GpuCalculator;
// Trajectory costs
struct Cost {
    double time_cost;
    double velocity_cost;
    double acceleration_cost;
    double jerk_cost;
    double position_cost;
    double curvature_cost;
    double similarity_cost;
};

struct Range {
    double min_value;
    double max_value;
};
// Struct to store a state
struct State {
    State(double val_in=0, double deriv1_in=0, double deriv2_in=0) : val(val_in), deriv1(deriv1_in), deriv2(deriv2_in) {
        ;
    }
    double val; // value
    double deriv1; // first order derivative
    double deriv2; // second order derivative
};
// Struct to store parameters of polynomial curve
struct Curve {
    Curve(std::vector<double> c_in, std::vector<double> c_dot_in, std::vector<double> c_ddot_in, double terminal_in) : c(c_in), c_dot(c_dot_in), c_ddot(c_ddot_in), terminal(terminal_in) {
        ;
    }
    Curve(){};
    std::vector<double> c; // polynomial curve
    std::vector<double> c_dot; // first order derivative
    std::vector<double> c_ddot; // second order derivative
    double terminal;
};

// Store history information of the last selected trajectory
struct TrajectoryHistory {
    uint64_t previous_planning_time;
    uint64_t previous_execute_time;
};

// Generate candidate trajectories
class CandidateTrajectory {
public:
    CandidateTrajectory();
    ~CandidateTrajectory();

public:
    // Generate candidate trajectories along with costs according to the maneuver
    enum ErrorCode GenerateCandidateTrajectories(const ManeuverState &maneuver_state,
					                        	 const av_msgs::Localize &localize,
                                                 const TrajectoryHistory &history,
                                                 std::vector<av_msgs::Trajectory> &trajectories,
                                                 std::vector<Cost> &costs);

private:
    // A small value to judge zero
    const double eps = 1e-6;
    // The value of PI
    const double PI = 3.1415926;
    // Several modes for trajectory optimization
    enum Mode {MOVE_MODE, STOP_MODE};
    // Struct to store a range [min_value, max_value]

    double num_d_, num_t_, num_s_; // numbers of d, t, s to generate trajectories

    double min_t_, max_t_, min_s_, max_s_; // ranges of t and s to generate trajectories

    double sample_t_, horizon_t_; // sample time and time horizon to generate trajectories
	double corridor_;
    double v_ref_min_ratio_, v_ref_max_ratio_; // the range of v with respect to reference velocity

    double acceleration_normalization_, jerk_normalization_, curvature_normalization_; // normalize the costs 

    double ego_width_;
    std::vector<double> t_list_; // time stamps in the trajectory

    std::vector<double> coefficient_s_, coefficient_d_; // the coefficients of s, d to perform optimization

    Mode pre_mode_;

    double pre_stop_time_;

    double planning_rate_;

	bool record_trajectory_;

	int thread_num_;
   
    GpuCalculator* gpu_calculator_;

    bool use_gpu_; 
private:
    // speed up
    double fast_sin(double x);
    double fast_cos(double x);

public:
    // Get reference path from lanes
    void getReferencePath(const ParameterLane& ref_line, spline& ref_theta_curve);

	void generateTrajectoryForOneLane(const ManeuverState& maneuver_state, const Lane& lane, const av_msgs::Localize& localize, double v_ref_min, double v_ref_max, Mode mode, double stop_dist, double stop_t, std::vector<av_msgs::Trajectory>& trajectories, std::vector<Cost>& costs); 

    // Compute initial conditions for s, d according to current state
    void getInitialConditions(double v0, double a0,const spline& ref_x_curve, const spline& ref_y_curve,
                              const spline& ref_theta_curve, State& s0_states, State& d0_states);

    // Combine the trajectories of s, d to get trajectories in workspace
    void combineTrajectories(const ManeuverState &maneuver_state, const std::vector<Curve>& s_curves, const std::vector<Curve>& d_curves, const spline& ref_x_curve,
                             const spline& ref_y_curve, const spline& ref_theta_curve, const av_msgs::Localize& localize, const double& s0, Range d_range, std::vector<av_msgs::Trajectory >& trajectories, std::vector<Cost> &costs);

    void combineTrajectoriesGpu(const ManeuverState &maneuver_state, const std::vector<Curve>& s_curves, const std::vector<Curve>& d_curves, const spline& ref_x_curve,
                             const spline& ref_y_curve, const spline& ref_theta_curve, const av_msgs::Localize& localize, const double& s0, Range d_range, std::vector<av_msgs::Trajectory >& trajectories, std::vector<Cost> &costs);

	static void combineTrajectoryThread(CandidateTrajectory* ct, const ManeuverState& maneuver_state, const std::vector<Curve>& s_curves, const std::vector<Curve>& d_curves, 
				const spline& ref_x_curve, const spline& ref_y_curve, const spline & ref_theta_curve, const av_msgs::Localize& localize, 
				double s0, Range d_range, int begin_index, int end_index, std::vector<av_msgs::Trajectory>& trajectories, std::vector<Cost>& costs, std::vector<int>& is_valid);

	void combineTrajectoryThreadImpl(const ManeuverState& maneuver_state, const std::vector<Curve>& s_curves, const std::vector<Curve>& d_curves, const spline& ref_x_curve, const spline& ref_y_curve, const spline & ref_theta_curve, const av_msgs::Localize& localize, double s0, Range d_range, int begin_index, int end_index, std::vector<av_msgs::Trajectory>& trajectories, std::vector<Cost>& costs, std::vector<int>& is_valid);

    // Compute information of the trajectory: theta, velocity, curvature
    void getTrajectoryInformation(std::vector<av_msgs::Pose>& poses, const av_msgs::Localize& localize);

    // Compute costs for each trajectory
    void getTrajectoryCost(const std::vector<av_msgs::Pose>& poses, const std::vector<double>& d_list, const Range& d_range, const std::vector<double>& accelerations, 
											const std::vector<double>& jerks, const ManeuverState& maneuver_state, Cost& cost);

    // Generate trajectories of s
    void getSCandidates(Mode mode, double v_ref_min, double v_ref_max, State s0, std::vector<Curve>& s_curves, double stop_dist, double stop_t);

    // Generate trajectories of d
    void getDCandidates(double s_min, double s_max, State d0, Range d_range, std::vector<Curve>& d_curves);

    // Optimization for moving conditions
    void optimizeMove(double t, State state_0, State state_r, std::vector<double> coefficient, std::vector<double>& c, std::vector<double>& c_dot, std::vector<double>& c_ddot);

    // Optimization of stopping conditions
    void optimizeStop(double t, double stop_distance, State state_0, std::vector<double>& c, std::vector<double>& c_dot, std::vector<double>& c_ddot);

    // Compute values for polynominal curves
    void polyCurveVal(const std::vector<double>& xs, std::vector<double>& ys, const Curve& curve, bool isExtend=false);
    void polyCurveVal(const std::vector<double>& xs, std::vector<double>& ys, std::vector<double>& ys_offset, const Curve& curve, const double& offset, bool isExtend=false);

    // Compute first order derivative for polynominal curves
    void polyCurveDeriv1(const std::vector<double>& xs, std::vector<double>& y_dots, const Curve& curve, bool isExtend=false);

    // Compute second order derivative for polynominal curves
    void polyCurveDeriv2(const std::vector<double>& xs, std::vector<double>& y_ddots, const Curve& curve);

    // Compute value for polynominal curves
    double polyVal(double x, std::vector<double> coefficients);

    // Compute values for spline curves
    void splineCurveVal(const std::vector<double>& xs, std::vector<double>& ys, const spline& curve);

    void splineCurveDeriv1(const std::vector<double>& xs, std::vector<double>& y_dots, const spline& curve);

    void splineCurveDeriv2(const std::vector<double>& xs, std::vector<double>& y_ddots, const spline& curve);

    // Solve the linear equation: c = inv(A)*b
    void solveOptimization(const std::vector<std::vector<double> >& A, const std::vector<double>& b, std::vector<double>& c);

	void recordTrajectory(const std::vector<av_msgs::Trajectory> &trajectories);
	void recordTrajectory(const std::vector<Curve> &curves);
};

} // namespace av_planning

#endif // MUSTANG_AV_PLANNING_CANDIDATE_TRAJECTORY_H
