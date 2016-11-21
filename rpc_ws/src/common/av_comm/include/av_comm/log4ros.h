#ifndef MUSTANG_AV_COMM_LOG4ROS_H
#define MUSTANG_AV_COMM_LOG4ROS_H

#include <iter/util.hpp>
#include <ros/ros.h>

namespace av_comm {

#define MSG(arg) std::make_pair("msg", arg)

#define AV_DEBUG_KV(args...) ROS_DEBUG("%s", iter::KvStr(args).c_str())
#define AV_INFO_KV(args...) ROS_INFO("%s", iter::KvStr(args).c_str())
#define AV_WARN_KV(args...) ROS_WARN("%s", iter::KvStr(args).c_str())
#define AV_ERROR_KV(args...) ROS_ERROR("%s", iter::KvStr(args).c_str())
#define AV_FATAL_KV(args...) ROS_FATAL("%s", iter::KvStr(args).c_str())

#define AV_DEBUG(args...) ROS_DEBUG("%s", iter::FmtStr(args).c_str())
#define AV_INFO(args...) ROS_INFO("%s", iter::FmtStr(args).c_str())
#define AV_WARN(args...) ROS_WARN("%s", iter::FmtStr(args).c_str())
#define AV_ERROR(args...) ROS_ERROR("%s", iter::FmtStr(args).c_str())
#define AV_FATAL(args...) ROS_FATAL("%s", iter::FmtStr(args).c_str())


} // namespace av_comm

#endif // MUSTANG_AV_COMM_LOG4ROS_H


