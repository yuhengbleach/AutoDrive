#ifndef MUSTANG_AV_PLANNING_SERIALIZE_H
#define MUSTANG_AV_PLANNING_SERIALIZE_H

#include <boost/serialization/vector.hpp>
#include <boost/archive/text_oarchive.hpp>
#include <boost/archive/text_iarchive.hpp>
#include <av_msgs/Trajectory.h>
#include <av_msgs/Pose.h>
#include <av_planning/planning_comm.h>
#include <av_planning/maneuver.h>
#include <av_planning/spline.h>
#include <av_planning/planning_comm.h>
#include <av_planning/candidate_trajectory.h>
#include <vector>

namespace boost {
namespace serialization {

template<class Archive>
void serialize(Archive & ar, av_msgs::Pose & g, const unsigned int version)
{
    ar & g.timestamp;
    ar & g.x;
    ar & g.y;
    ar & g.theta;
    ar & g.curvature;
    ar & g.velocity;
    ar & g.acceleration;
}

template<class Archive>
void serialize(Archive & ar, av_msgs::Trajectory & g, const unsigned int version)
{
    ar & g.initial_pose;
    ar & g.poses;
    ar & g.driving_direction;
    ar & g.driving_state;
}

template<class Archive>
void serialize(Archive & ar, av_msgs::Localize & g, const unsigned int version)
{
    ar & g.timestamp;
    ar & g.raw_data;
    ar & g.mTime;
    ar & g.latitude;
    ar & g.longitude;
    ar & g.altitude;
    ar & g.vel_x;
    ar & g.vel_y;
    ar & g.vel_z;
    ar & g.acc_x;
    ar & g.acc_y;
    ar & g.acc_z;
    ar & g.nav_mode;
    ar & g.pos_mode;
    ar & g.vel_mode;
    ar & g.att_mode;
    ar & g.angular_vel_x;
    ar & g.angular_vel_y;
    ar & g.angular_vel_z;
    ar & g.heading;
    ar & g.pitch;
    ar & g.roll;
    ar & g.pose_x;
    ar & g.pose_y;
}

template<class Archive>
void serialize(Archive & ar, av_planning::Range & g, const unsigned int version)
{
    ar & g.min_value;
    ar & g.max_value;
}

template<class Archive>
void serialize(Archive & ar, av_planning::Cost & g, const unsigned int version)
{
    ar & g.time_cost;
    ar & g.velocity_cost;
    ar & g.acceleration_cost;
    ar & g.jerk_cost;
    ar & g.position_cost;
    ar & g.curvature_cost;
    ar & g.similarity_cost;
}

template<class Archive>
void serialize(Archive & ar, av_planning::Curve & g, const unsigned int version)
{
    ar & g.c;
    ar & g.c_dot;
    ar & g.c_ddot;
    ar & g.terminal;
}

template<class Archive>
void serialize(Archive & ar, av_planning::spline & g, const unsigned int version)
{
    ar & g.m_x;
    ar & g.m_y;
    ar & g.m_a;
    ar & g.m_b;
    ar & g.m_c;
    ar & g.m_b0;
    ar & g.m_c0;
    ar & g.m_left;
    ar & g.m_right;
    ar & g.m_left_value;
    ar & g.m_right_value;
    ar & g.m_force_linear_extrapolation;
}

template<class Archive>
void serialize(Archive & ar, av_planning::ParameterLane & g, const unsigned int version)
{
    ar & g.curve_x;
    ar & g.curve_y;
    ar & g.length;
    ar & g.paint_type;
}

template<class Archive>
void serialize(Archive & ar, av_planning::Lane & g, const unsigned int version)
{
    ar & g.left_line;
    ar & g.right_line;
    ar & g.ref_line;
    ar & g.length;
    ar & g.width;
}

template<class Archive>
void serialize(Archive & ar, av_planning::LaneGroup & g, const unsigned int version)
{
    ar & g.lanes;
    ar & g.label;
}

template<class Archive>
void serialize(Archive & ar, av_planning::ManeuverState & g, const unsigned int version)
{
    ar & g.next_state;
    ar & g.v;
    ar & g.keep_distance;
    ar & g.stop_distance;
    ar & g.lane_group_list;
}

} // namespace serialization
} // namespace boost

#endif
