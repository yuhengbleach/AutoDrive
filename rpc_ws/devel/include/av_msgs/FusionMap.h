// Generated by gencpp from file av_msgs/FusionMap.msg
// DO NOT EDIT!


#ifndef AV_MSGS_MESSAGE_FUSIONMAP_H
#define AV_MSGS_MESSAGE_FUSIONMAP_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>

#include <av_msgs/DynamicObstacle.h>
#include <av_msgs/GridMap.h>
#include <av_msgs/SectionList.h>
#include <av_msgs/Pose.h>

namespace av_msgs
{
template <class ContainerAllocator>
struct FusionMap_
{
  typedef FusionMap_<ContainerAllocator> Type;

  FusionMap_()
    : timestamp(0)
    , dynamic_object_list()
    , obstacle_map()
    , section_list()
    , pose()  {
    }
  FusionMap_(const ContainerAllocator& _alloc)
    : timestamp(0)
    , dynamic_object_list(_alloc)
    , obstacle_map(_alloc)
    , section_list(_alloc)
    , pose(_alloc)  {
  (void)_alloc;
    }



   typedef uint64_t _timestamp_type;
  _timestamp_type timestamp;

   typedef std::vector< ::av_msgs::DynamicObstacle_<ContainerAllocator> , typename ContainerAllocator::template rebind< ::av_msgs::DynamicObstacle_<ContainerAllocator> >::other >  _dynamic_object_list_type;
  _dynamic_object_list_type dynamic_object_list;

   typedef  ::av_msgs::GridMap_<ContainerAllocator>  _obstacle_map_type;
  _obstacle_map_type obstacle_map;

   typedef std::vector< ::av_msgs::SectionList_<ContainerAllocator> , typename ContainerAllocator::template rebind< ::av_msgs::SectionList_<ContainerAllocator> >::other >  _section_list_type;
  _section_list_type section_list;

   typedef  ::av_msgs::Pose_<ContainerAllocator>  _pose_type;
  _pose_type pose;




  typedef boost::shared_ptr< ::av_msgs::FusionMap_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::av_msgs::FusionMap_<ContainerAllocator> const> ConstPtr;

}; // struct FusionMap_

typedef ::av_msgs::FusionMap_<std::allocator<void> > FusionMap;

typedef boost::shared_ptr< ::av_msgs::FusionMap > FusionMapPtr;
typedef boost::shared_ptr< ::av_msgs::FusionMap const> FusionMapConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::av_msgs::FusionMap_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::av_msgs::FusionMap_<ContainerAllocator> >::stream(s, "", v);
return s;
}

} // namespace av_msgs

namespace ros
{
namespace message_traits
{



// BOOLTRAITS {'IsFixedSize': False, 'IsMessage': True, 'HasHeader': False}
// {'sensor_msgs': ['/opt/ros/jade/share/sensor_msgs/cmake/../msg'], 'geometry_msgs': ['/opt/ros/jade/share/geometry_msgs/cmake/../msg'], 'std_msgs': ['/opt/ros/jade/share/std_msgs/cmake/../msg'], 'av_msgs': ['/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg']}

// !!!!!!!!!!! ['__class__', '__delattr__', '__dict__', '__doc__', '__eq__', '__format__', '__getattribute__', '__hash__', '__init__', '__module__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', '__weakref__', '_parsed_fields', 'constants', 'fields', 'full_name', 'has_header', 'header_present', 'names', 'package', 'parsed_fields', 'short_name', 'text', 'types']




template <class ContainerAllocator>
struct IsFixedSize< ::av_msgs::FusionMap_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::av_msgs::FusionMap_<ContainerAllocator> const>
  : FalseType
  { };

template <class ContainerAllocator>
struct IsMessage< ::av_msgs::FusionMap_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::av_msgs::FusionMap_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::av_msgs::FusionMap_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::av_msgs::FusionMap_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::av_msgs::FusionMap_<ContainerAllocator> >
{
  static const char* value()
  {
    return "aa32fc0bd4214ed3b5eceff3c45ac56b";
  }

  static const char* value(const ::av_msgs::FusionMap_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0xaa32fc0bd4214ed3ULL;
  static const uint64_t static_value2 = 0xb5eceff3c45ac56bULL;
};

template<class ContainerAllocator>
struct DataType< ::av_msgs::FusionMap_<ContainerAllocator> >
{
  static const char* value()
  {
    return "av_msgs/FusionMap";
  }

  static const char* value(const ::av_msgs::FusionMap_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::av_msgs::FusionMap_<ContainerAllocator> >
{
  static const char* value()
  {
    return "# Fusion map.\n\
\n\
uint64 timestamp                        # 当前时间戳\n\
\n\
DynamicObstacle[] dynamic_object_list   # 动态障碍物列表\n\
\n\
GridMap obstacle_map                    # 静态障碍物矩阵，150*100m(前100，后50，左50，右50)，\n\
                                        # 粒度10cm*10cm, 可行驶区域为0，障碍物为1，不可见区域－1\n\
SectionList[] section_list           	# 车道线列表\n\
\n\
Pose pose\n\
\n\
================================================================================\n\
MSG: av_msgs/DynamicObstacle\n\
uint8 class_id\n\
uint64 id\n\
float32 center_x\n\
float32 center_y\n\
float32 center_z\n\
float32 width\n\
float32 height\n\
float32 length\n\
float32 velocity\n\
# 车头夹角\n\
float32 heading\n\
# 角速度\n\
float32 omega\n\
# 加速度\n\
float32 acceleration\n\
# 遮挡时间，单位 sec\n\
uint32 shield_time\n\
\n\
# 测速 box 模型的协方差（用一维数组模拟二维数组，需要转换，6 * 6）\n\
float64[] velocity_measurement_covariance\n\
\n\
\n\
================================================================================\n\
MSG: av_msgs/GridMap\n\
int32 width\n\
int32 length\n\
int32 center_x\n\
int32 center_y\n\
uint8[] grid_map\n\
\n\
================================================================================\n\
MSG: av_msgs/SectionList\n\
# SectionList\n\
LaneMarker[] lane_marker_list\n\
# 0:curved 1:straight\n\
int8 section_type\n\
\n\
\n\
================================================================================\n\
MSG: av_msgs/LaneMarker\n\
#车道线类型\n\
int8 paint_type\n\
#车道线点序列\n\
WayPoint[] waypoints\n\
\n\
\n\
================================================================================\n\
MSG: av_msgs/WayPoint\n\
float64 x\n\
float64 y\n\
================================================================================\n\
MSG: av_msgs/Pose\n\
# 时间戳\n\
uint64 timestamp\n\
# 轨迹x坐标\n\
float64 x\n\
# 轨迹y坐标\n\
float64 y\n\
# 轨迹朝向角坐标\n\
float64 theta\n\
# 曲率\n\
float64 curvature\n\
# 速度\n\
float64 velocity\n\
# 加速度\n\
float64 acceleration\n\
";
  }

  static const char* value(const ::av_msgs::FusionMap_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::av_msgs::FusionMap_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.timestamp);
      stream.next(m.dynamic_object_list);
      stream.next(m.obstacle_map);
      stream.next(m.section_list);
      stream.next(m.pose);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct FusionMap_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::av_msgs::FusionMap_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::av_msgs::FusionMap_<ContainerAllocator>& v)
  {
    s << indent << "timestamp: ";
    Printer<uint64_t>::stream(s, indent + "  ", v.timestamp);
    s << indent << "dynamic_object_list[]" << std::endl;
    for (size_t i = 0; i < v.dynamic_object_list.size(); ++i)
    {
      s << indent << "  dynamic_object_list[" << i << "]: ";
      s << std::endl;
      s << indent;
      Printer< ::av_msgs::DynamicObstacle_<ContainerAllocator> >::stream(s, indent + "    ", v.dynamic_object_list[i]);
    }
    s << indent << "obstacle_map: ";
    s << std::endl;
    Printer< ::av_msgs::GridMap_<ContainerAllocator> >::stream(s, indent + "  ", v.obstacle_map);
    s << indent << "section_list[]" << std::endl;
    for (size_t i = 0; i < v.section_list.size(); ++i)
    {
      s << indent << "  section_list[" << i << "]: ";
      s << std::endl;
      s << indent;
      Printer< ::av_msgs::SectionList_<ContainerAllocator> >::stream(s, indent + "    ", v.section_list[i]);
    }
    s << indent << "pose: ";
    s << std::endl;
    Printer< ::av_msgs::Pose_<ContainerAllocator> >::stream(s, indent + "  ", v.pose);
  }
};

} // namespace message_operations
} // namespace ros

#endif // AV_MSGS_MESSAGE_FUSIONMAP_H
