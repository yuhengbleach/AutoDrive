// Generated by gencpp from file av_msgs/getLocalLanemarkersRequest.msg
// DO NOT EDIT!


#ifndef AV_MSGS_MESSAGE_GETLOCALLANEMARKERSREQUEST_H
#define AV_MSGS_MESSAGE_GETLOCALLANEMARKERSREQUEST_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace av_msgs
{
template <class ContainerAllocator>
struct getLocalLanemarkersRequest_
{
  typedef getLocalLanemarkersRequest_<ContainerAllocator> Type;

  getLocalLanemarkersRequest_()
    : x(0.0)
    , y(0.0)  {
    }
  getLocalLanemarkersRequest_(const ContainerAllocator& _alloc)
    : x(0.0)
    , y(0.0)  {
  (void)_alloc;
    }



   typedef float _x_type;
  _x_type x;

   typedef float _y_type;
  _y_type y;




  typedef boost::shared_ptr< ::av_msgs::getLocalLanemarkersRequest_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::av_msgs::getLocalLanemarkersRequest_<ContainerAllocator> const> ConstPtr;

}; // struct getLocalLanemarkersRequest_

typedef ::av_msgs::getLocalLanemarkersRequest_<std::allocator<void> > getLocalLanemarkersRequest;

typedef boost::shared_ptr< ::av_msgs::getLocalLanemarkersRequest > getLocalLanemarkersRequestPtr;
typedef boost::shared_ptr< ::av_msgs::getLocalLanemarkersRequest const> getLocalLanemarkersRequestConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::av_msgs::getLocalLanemarkersRequest_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::av_msgs::getLocalLanemarkersRequest_<ContainerAllocator> >::stream(s, "", v);
return s;
}

} // namespace av_msgs

namespace ros
{
namespace message_traits
{



// BOOLTRAITS {'IsFixedSize': True, 'IsMessage': True, 'HasHeader': False}
// {'sensor_msgs': ['/opt/ros/jade/share/sensor_msgs/cmake/../msg'], 'geometry_msgs': ['/opt/ros/jade/share/geometry_msgs/cmake/../msg'], 'std_msgs': ['/opt/ros/jade/share/std_msgs/cmake/../msg'], 'av_msgs': ['/home/zhouji/Documents/autodrive/cakin_ws/src/mustang/common/av_msgs/msg']}

// !!!!!!!!!!! ['__class__', '__delattr__', '__dict__', '__doc__', '__eq__', '__format__', '__getattribute__', '__hash__', '__init__', '__module__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', '__weakref__', '_parsed_fields', 'constants', 'fields', 'full_name', 'has_header', 'header_present', 'names', 'package', 'parsed_fields', 'short_name', 'text', 'types']




template <class ContainerAllocator>
struct IsFixedSize< ::av_msgs::getLocalLanemarkersRequest_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::av_msgs::getLocalLanemarkersRequest_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::av_msgs::getLocalLanemarkersRequest_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::av_msgs::getLocalLanemarkersRequest_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::av_msgs::getLocalLanemarkersRequest_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::av_msgs::getLocalLanemarkersRequest_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::av_msgs::getLocalLanemarkersRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "ff8d7d66dd3e4b731ef14a45d38888b6";
  }

  static const char* value(const ::av_msgs::getLocalLanemarkersRequest_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0xff8d7d66dd3e4b73ULL;
  static const uint64_t static_value2 = 0x1ef14a45d38888b6ULL;
};

template<class ContainerAllocator>
struct DataType< ::av_msgs::getLocalLanemarkersRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "av_msgs/getLocalLanemarkersRequest";
  }

  static const char* value(const ::av_msgs::getLocalLanemarkersRequest_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::av_msgs::getLocalLanemarkersRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "float32 x\n\
float32 y\n\
";
  }

  static const char* value(const ::av_msgs::getLocalLanemarkersRequest_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::av_msgs::getLocalLanemarkersRequest_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.x);
      stream.next(m.y);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct getLocalLanemarkersRequest_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::av_msgs::getLocalLanemarkersRequest_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::av_msgs::getLocalLanemarkersRequest_<ContainerAllocator>& v)
  {
    s << indent << "x: ";
    Printer<float>::stream(s, indent + "  ", v.x);
    s << indent << "y: ";
    Printer<float>::stream(s, indent + "  ", v.y);
  }
};

} // namespace message_operations
} // namespace ros

#endif // AV_MSGS_MESSAGE_GETLOCALLANEMARKERSREQUEST_H
