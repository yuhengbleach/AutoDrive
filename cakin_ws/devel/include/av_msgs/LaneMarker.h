// Generated by gencpp from file av_msgs/LaneMarker.msg
// DO NOT EDIT!


#ifndef AV_MSGS_MESSAGE_LANEMARKER_H
#define AV_MSGS_MESSAGE_LANEMARKER_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>

#include <av_msgs/WayPoint.h>

namespace av_msgs
{
template <class ContainerAllocator>
struct LaneMarker_
{
  typedef LaneMarker_<ContainerAllocator> Type;

  LaneMarker_()
    : paint_type(0)
    , waypoints()  {
    }
  LaneMarker_(const ContainerAllocator& _alloc)
    : paint_type(0)
    , waypoints(_alloc)  {
  (void)_alloc;
    }



   typedef int8_t _paint_type_type;
  _paint_type_type paint_type;

   typedef std::vector< ::av_msgs::WayPoint_<ContainerAllocator> , typename ContainerAllocator::template rebind< ::av_msgs::WayPoint_<ContainerAllocator> >::other >  _waypoints_type;
  _waypoints_type waypoints;




  typedef boost::shared_ptr< ::av_msgs::LaneMarker_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::av_msgs::LaneMarker_<ContainerAllocator> const> ConstPtr;

}; // struct LaneMarker_

typedef ::av_msgs::LaneMarker_<std::allocator<void> > LaneMarker;

typedef boost::shared_ptr< ::av_msgs::LaneMarker > LaneMarkerPtr;
typedef boost::shared_ptr< ::av_msgs::LaneMarker const> LaneMarkerConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::av_msgs::LaneMarker_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::av_msgs::LaneMarker_<ContainerAllocator> >::stream(s, "", v);
return s;
}

} // namespace av_msgs

namespace ros
{
namespace message_traits
{



// BOOLTRAITS {'IsFixedSize': False, 'IsMessage': True, 'HasHeader': False}
// {'sensor_msgs': ['/opt/ros/jade/share/sensor_msgs/cmake/../msg'], 'geometry_msgs': ['/opt/ros/jade/share/geometry_msgs/cmake/../msg'], 'std_msgs': ['/opt/ros/jade/share/std_msgs/cmake/../msg'], 'av_msgs': ['/home/zhouji/Documents/autodrive/cakin_ws/src/mustang/common/av_msgs/msg']}

// !!!!!!!!!!! ['__class__', '__delattr__', '__dict__', '__doc__', '__eq__', '__format__', '__getattribute__', '__hash__', '__init__', '__module__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', '__weakref__', '_parsed_fields', 'constants', 'fields', 'full_name', 'has_header', 'header_present', 'names', 'package', 'parsed_fields', 'short_name', 'text', 'types']




template <class ContainerAllocator>
struct IsFixedSize< ::av_msgs::LaneMarker_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::av_msgs::LaneMarker_<ContainerAllocator> const>
  : FalseType
  { };

template <class ContainerAllocator>
struct IsMessage< ::av_msgs::LaneMarker_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::av_msgs::LaneMarker_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::av_msgs::LaneMarker_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::av_msgs::LaneMarker_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::av_msgs::LaneMarker_<ContainerAllocator> >
{
  static const char* value()
  {
    return "ffcd1cee711ed2faf1d975c0f17d3c4a";
  }

  static const char* value(const ::av_msgs::LaneMarker_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0xffcd1cee711ed2faULL;
  static const uint64_t static_value2 = 0xf1d975c0f17d3c4aULL;
};

template<class ContainerAllocator>
struct DataType< ::av_msgs::LaneMarker_<ContainerAllocator> >
{
  static const char* value()
  {
    return "av_msgs/LaneMarker";
  }

  static const char* value(const ::av_msgs::LaneMarker_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::av_msgs::LaneMarker_<ContainerAllocator> >
{
  static const char* value()
  {
    return "#车道线类型\n\
int8 paint_type\n\
#车道线点序列\n\
WayPoint[] waypoints\n\
\n\
\n\
================================================================================\n\
MSG: av_msgs/WayPoint\n\
float64 x\n\
float64 y\n\
";
  }

  static const char* value(const ::av_msgs::LaneMarker_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::av_msgs::LaneMarker_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.paint_type);
      stream.next(m.waypoints);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct LaneMarker_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::av_msgs::LaneMarker_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::av_msgs::LaneMarker_<ContainerAllocator>& v)
  {
    s << indent << "paint_type: ";
    Printer<int8_t>::stream(s, indent + "  ", v.paint_type);
    s << indent << "waypoints[]" << std::endl;
    for (size_t i = 0; i < v.waypoints.size(); ++i)
    {
      s << indent << "  waypoints[" << i << "]: ";
      s << std::endl;
      s << indent;
      Printer< ::av_msgs::WayPoint_<ContainerAllocator> >::stream(s, indent + "    ", v.waypoints[i]);
    }
  }
};

} // namespace message_operations
} // namespace ros

#endif // AV_MSGS_MESSAGE_LANEMARKER_H
