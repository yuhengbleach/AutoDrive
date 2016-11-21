// Generated by gencpp from file av_msgs/DynamicObstacle.msg
// DO NOT EDIT!


#ifndef AV_MSGS_MESSAGE_DYNAMICOBSTACLE_H
#define AV_MSGS_MESSAGE_DYNAMICOBSTACLE_H


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
struct DynamicObstacle_
{
  typedef DynamicObstacle_<ContainerAllocator> Type;

  DynamicObstacle_()
    : class_id(0)
    , id(0)
    , center_x(0.0)
    , center_y(0.0)
    , center_z(0.0)
    , width(0.0)
    , height(0.0)
    , length(0.0)
    , velocity(0.0)
    , heading(0.0)
    , omega(0.0)
    , acceleration(0.0)
    , shield_time(0)
    , velocity_measurement_covariance()  {
    }
  DynamicObstacle_(const ContainerAllocator& _alloc)
    : class_id(0)
    , id(0)
    , center_x(0.0)
    , center_y(0.0)
    , center_z(0.0)
    , width(0.0)
    , height(0.0)
    , length(0.0)
    , velocity(0.0)
    , heading(0.0)
    , omega(0.0)
    , acceleration(0.0)
    , shield_time(0)
    , velocity_measurement_covariance(_alloc)  {
  (void)_alloc;
    }



   typedef uint8_t _class_id_type;
  _class_id_type class_id;

   typedef uint64_t _id_type;
  _id_type id;

   typedef float _center_x_type;
  _center_x_type center_x;

   typedef float _center_y_type;
  _center_y_type center_y;

   typedef float _center_z_type;
  _center_z_type center_z;

   typedef float _width_type;
  _width_type width;

   typedef float _height_type;
  _height_type height;

   typedef float _length_type;
  _length_type length;

   typedef float _velocity_type;
  _velocity_type velocity;

   typedef float _heading_type;
  _heading_type heading;

   typedef float _omega_type;
  _omega_type omega;

   typedef float _acceleration_type;
  _acceleration_type acceleration;

   typedef uint32_t _shield_time_type;
  _shield_time_type shield_time;

   typedef std::vector<double, typename ContainerAllocator::template rebind<double>::other >  _velocity_measurement_covariance_type;
  _velocity_measurement_covariance_type velocity_measurement_covariance;




  typedef boost::shared_ptr< ::av_msgs::DynamicObstacle_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::av_msgs::DynamicObstacle_<ContainerAllocator> const> ConstPtr;

}; // struct DynamicObstacle_

typedef ::av_msgs::DynamicObstacle_<std::allocator<void> > DynamicObstacle;

typedef boost::shared_ptr< ::av_msgs::DynamicObstacle > DynamicObstaclePtr;
typedef boost::shared_ptr< ::av_msgs::DynamicObstacle const> DynamicObstacleConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::av_msgs::DynamicObstacle_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::av_msgs::DynamicObstacle_<ContainerAllocator> >::stream(s, "", v);
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
struct IsFixedSize< ::av_msgs::DynamicObstacle_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::av_msgs::DynamicObstacle_<ContainerAllocator> const>
  : FalseType
  { };

template <class ContainerAllocator>
struct IsMessage< ::av_msgs::DynamicObstacle_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::av_msgs::DynamicObstacle_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::av_msgs::DynamicObstacle_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::av_msgs::DynamicObstacle_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::av_msgs::DynamicObstacle_<ContainerAllocator> >
{
  static const char* value()
  {
    return "eda31db303c9b60e362d01b3c33e6bce";
  }

  static const char* value(const ::av_msgs::DynamicObstacle_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0xeda31db303c9b60eULL;
  static const uint64_t static_value2 = 0x362d01b3c33e6bceULL;
};

template<class ContainerAllocator>
struct DataType< ::av_msgs::DynamicObstacle_<ContainerAllocator> >
{
  static const char* value()
  {
    return "av_msgs/DynamicObstacle";
  }

  static const char* value(const ::av_msgs::DynamicObstacle_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::av_msgs::DynamicObstacle_<ContainerAllocator> >
{
  static const char* value()
  {
    return "uint8 class_id\n\
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
";
  }

  static const char* value(const ::av_msgs::DynamicObstacle_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::av_msgs::DynamicObstacle_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.class_id);
      stream.next(m.id);
      stream.next(m.center_x);
      stream.next(m.center_y);
      stream.next(m.center_z);
      stream.next(m.width);
      stream.next(m.height);
      stream.next(m.length);
      stream.next(m.velocity);
      stream.next(m.heading);
      stream.next(m.omega);
      stream.next(m.acceleration);
      stream.next(m.shield_time);
      stream.next(m.velocity_measurement_covariance);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct DynamicObstacle_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::av_msgs::DynamicObstacle_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::av_msgs::DynamicObstacle_<ContainerAllocator>& v)
  {
    s << indent << "class_id: ";
    Printer<uint8_t>::stream(s, indent + "  ", v.class_id);
    s << indent << "id: ";
    Printer<uint64_t>::stream(s, indent + "  ", v.id);
    s << indent << "center_x: ";
    Printer<float>::stream(s, indent + "  ", v.center_x);
    s << indent << "center_y: ";
    Printer<float>::stream(s, indent + "  ", v.center_y);
    s << indent << "center_z: ";
    Printer<float>::stream(s, indent + "  ", v.center_z);
    s << indent << "width: ";
    Printer<float>::stream(s, indent + "  ", v.width);
    s << indent << "height: ";
    Printer<float>::stream(s, indent + "  ", v.height);
    s << indent << "length: ";
    Printer<float>::stream(s, indent + "  ", v.length);
    s << indent << "velocity: ";
    Printer<float>::stream(s, indent + "  ", v.velocity);
    s << indent << "heading: ";
    Printer<float>::stream(s, indent + "  ", v.heading);
    s << indent << "omega: ";
    Printer<float>::stream(s, indent + "  ", v.omega);
    s << indent << "acceleration: ";
    Printer<float>::stream(s, indent + "  ", v.acceleration);
    s << indent << "shield_time: ";
    Printer<uint32_t>::stream(s, indent + "  ", v.shield_time);
    s << indent << "velocity_measurement_covariance[]" << std::endl;
    for (size_t i = 0; i < v.velocity_measurement_covariance.size(); ++i)
    {
      s << indent << "  velocity_measurement_covariance[" << i << "]: ";
      Printer<double>::stream(s, indent + "  ", v.velocity_measurement_covariance[i]);
    }
  }
};

} // namespace message_operations
} // namespace ros

#endif // AV_MSGS_MESSAGE_DYNAMICOBSTACLE_H