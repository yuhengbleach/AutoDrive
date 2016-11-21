#include <av_planning/candidate_trajectory.h>
#include <av_planning/serialize.h>
#include <av_msgs/Pose.h>
#include <sstream>
#include <iostream>

using namespace std;
using namespace av_planning;
using namespace av_msgs;

int main(int argc, char** argv)
{
    ros::init(argc, argv, "hello_gpu");
    ros::NodeHandle nh;
    CandidateTrajectory candidate;
    stringstream ss;
    string save_root = "/home/tangwenjian/Projects/PlanningGpu/DumpData/";
    ManeuverState new_maneuver_state;
    std::vector<Curve> new_s_curves;
    std::vector<Curve> new_d_curves;
    spline new_ref_x_curve;
    spline new_ref_y_curve;
    spline new_ref_theta_curve;
    av_msgs::Localize new_localize;
    double new_s0;
    Range new_d_range;
    std::vector<av_msgs::Trajectory> trajectories;
    std::vector<Cost> costs;
    std::vector<av_msgs::Trajectory> res_trajectories;
    std::vector<Cost> res_costs;
    for (int counter = 0; counter < 20; counter ++)
    {
        // create and open an archive for input
        ss.str("");
        ss << save_root << "in_" << counter;
        std::ifstream ifs(ss.str());
        boost::archive::text_iarchive ia(ifs);
        // read class state from archive
        ia >> new_maneuver_state >> new_s_curves >> new_d_curves >> new_ref_x_curve >> new_ref_y_curve >> new_ref_theta_curve >> new_localize >> new_s0 >> new_d_range;
        uint64_t start = Now<uint64_t, std::milli>();
        candidate.combineTrajectoriesGpu(new_maneuver_state, new_s_curves, new_d_curves, new_ref_x_curve, new_ref_y_curve, new_ref_theta_curve, new_localize, new_s0, new_d_range, trajectories, costs);
        uint64_t end = Now<uint64_t, std::milli>();
        candidate.combineTrajectories(new_maneuver_state, new_s_curves, new_d_curves, new_ref_x_curve, new_ref_y_curve, new_ref_theta_curve, new_localize, new_s0, new_d_range, res_trajectories, res_costs);
        cout << "time: " << end - start << endl;
        ROS_INFO("Hello_gpu.");

        //ss.str("");
        //ss << save_root << "out_" << counter;
        //std::ifstream res_ifs(ss.str());
        //boost::archive::text_iarchive res_ia(res_ifs);

        float eps = 0.00001; 
        //for(int i = 0; i < trajectories.size(); i ++){
            //assert(res_trajectories[i].poses.size() == trajectories[i].poses.size());
            //for(int j = 0; j < res_trajectories[i].poses.size(); j++){
                //Pose& res_pose = res_trajectories[i].poses[j];
                //Pose& pose = trajectories[i].poses[j];
                //if (res_pose.timestamp != pose.timestamp || fabs(res_pose.x-pose.x)>eps || fabs(res_pose.y-pose.y)>eps || fabs(res_pose.theta-pose.theta)>eps
                    //|| fabs(res_pose.curvature-pose.curvature)>eps || fabs(res_pose.velocity-pose.velocity)>eps || fabs(res_pose.acceleration-pose.acceleration)>eps){
                    //cout << "error **************** " << i << " " << j << endl;
                //}
            //}
        //}
        cout << res_trajectories.size() << " " << trajectories.size() << endl << res_trajectories[4].poses[270] << endl << trajectories[4].poses[270] << endl;
        cout << res_trajectories.size() << " " << trajectories.size() << endl << res_trajectories[4].poses[271] << endl << trajectories[4].poses[271] << endl;
        //cout << res_trajectories.size() << " " << res_trajectories[0].poses[0] << endl;
    }
    return 0;
}
