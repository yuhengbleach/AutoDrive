# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "av_msgs: 32 messages, 1 services")

set(MSG_I_FLAGS "-Iav_msgs:/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg;-Istd_msgs:/opt/ros/jade/share/std_msgs/cmake/../msg;-Isensor_msgs:/opt/ros/jade/share/sensor_msgs/cmake/../msg;-Igeometry_msgs:/opt/ros/jade/share/geometry_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(av_msgs_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/VelodynePoints.msg" NAME_WE)
add_custom_target(_av_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "av_msgs" "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/VelodynePoints.msg" "sensor_msgs/PointCloud2:sensor_msgs/PointField:std_msgs/Header"
)

get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Dest.msg" NAME_WE)
add_custom_target(_av_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "av_msgs" "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Dest.msg" ""
)

get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/FusionMap.msg" NAME_WE)
add_custom_target(_av_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "av_msgs" "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/FusionMap.msg" "av_msgs/Pose:av_msgs/LaneMarker:av_msgs/WayPoint:av_msgs/DynamicObstacle:av_msgs/SectionList:av_msgs/GridMap"
)

get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Object3D.msg" NAME_WE)
add_custom_target(_av_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "av_msgs" "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Object3D.msg" ""
)

get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/CameraTelescopic.msg" NAME_WE)
add_custom_target(_av_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "av_msgs" "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/CameraTelescopic.msg" "sensor_msgs/Image:std_msgs/Header"
)

get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/IbeoObject.msg" NAME_WE)
add_custom_target(_av_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "av_msgs" "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/IbeoObject.msg" ""
)

get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Pose.msg" NAME_WE)
add_custom_target(_av_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "av_msgs" "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Pose.msg" ""
)

get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Localize.msg" NAME_WE)
add_custom_target(_av_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "av_msgs" "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Localize.msg" ""
)

get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/RSDSObjectList.msg" NAME_WE)
add_custom_target(_av_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "av_msgs" "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/RSDSObjectList.msg" "av_msgs/RSDSObject"
)

get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/SectionList.msg" NAME_WE)
add_custom_target(_av_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "av_msgs" "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/SectionList.msg" "av_msgs/LaneMarker:av_msgs/WayPoint"
)

get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/TrafficLightLoc.msg" NAME_WE)
add_custom_target(_av_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "av_msgs" "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/TrafficLightLoc.msg" ""
)

get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/IbeoPoint.msg" NAME_WE)
add_custom_target(_av_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "av_msgs" "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/IbeoPoint.msg" ""
)

get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/CameraBinocular.msg" NAME_WE)
add_custom_target(_av_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "av_msgs" "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/CameraBinocular.msg" "sensor_msgs/Image:std_msgs/Header"
)

get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/CameraVelodyneObjectList.msg" NAME_WE)
add_custom_target(_av_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "av_msgs" "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/CameraVelodyneObjectList.msg" "av_msgs/Object3D"
)

get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/WayPoint.msg" NAME_WE)
add_custom_target(_av_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "av_msgs" "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/WayPoint.msg" ""
)

get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/GpsData.msg" NAME_WE)
add_custom_target(_av_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "av_msgs" "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/GpsData.msg" ""
)

get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Trajectory.msg" NAME_WE)
add_custom_target(_av_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "av_msgs" "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Trajectory.msg" "av_msgs/Pose"
)

get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/LaneMarker.msg" NAME_WE)
add_custom_target(_av_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "av_msgs" "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/LaneMarker.msg" "av_msgs/WayPoint"
)

get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/ControlSignal.msg" NAME_WE)
add_custom_target(_av_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "av_msgs" "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/ControlSignal.msg" ""
)

get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/DynamicObstacle.msg" NAME_WE)
add_custom_target(_av_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "av_msgs" "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/DynamicObstacle.msg" ""
)

get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/RadarObjectList.msg" NAME_WE)
add_custom_target(_av_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "av_msgs" "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/RadarObjectList.msg" "av_msgs/RadarObject"
)

get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/RadarObject.msg" NAME_WE)
add_custom_target(_av_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "av_msgs" "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/RadarObject.msg" ""
)

get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/TrafficLight.msg" NAME_WE)
add_custom_target(_av_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "av_msgs" "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/TrafficLight.msg" ""
)

get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/ControlDebug.msg" NAME_WE)
add_custom_target(_av_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "av_msgs" "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/ControlDebug.msg" ""
)

get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/IbeoPointList.msg" NAME_WE)
add_custom_target(_av_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "av_msgs" "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/IbeoPointList.msg" "av_msgs/IbeoPoint"
)

get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/TrafficLightDetect.msg" NAME_WE)
add_custom_target(_av_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "av_msgs" "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/TrafficLightDetect.msg" "av_msgs/TrafficLight"
)

get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/srv/getLocalLanemarkers.srv" NAME_WE)
add_custom_target(_av_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "av_msgs" "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/srv/getLocalLanemarkers.srv" "av_msgs/LaneMarker:av_msgs/SectionList:av_msgs/WayPoint"
)

get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/VehicleMsg.msg" NAME_WE)
add_custom_target(_av_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "av_msgs" "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/VehicleMsg.msg" ""
)

get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/GridMap.msg" NAME_WE)
add_custom_target(_av_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "av_msgs" "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/GridMap.msg" ""
)

get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/StateMsg.msg" NAME_WE)
add_custom_target(_av_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "av_msgs" "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/StateMsg.msg" ""
)

get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/RSDSObject.msg" NAME_WE)
add_custom_target(_av_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "av_msgs" "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/RSDSObject.msg" ""
)

get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/TrafficLightMapData.msg" NAME_WE)
add_custom_target(_av_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "av_msgs" "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/TrafficLightMapData.msg" "av_msgs/TrafficLightLoc"
)

get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/IbeoObjectList.msg" NAME_WE)
add_custom_target(_av_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "av_msgs" "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/IbeoObjectList.msg" "av_msgs/IbeoObject"
)

#
#  langs = gencpp;geneus;genlisp;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/VelodynePoints.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/jade/share/sensor_msgs/cmake/../msg/PointCloud2.msg;/opt/ros/jade/share/sensor_msgs/cmake/../msg/PointField.msg;/opt/ros/jade/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/av_msgs
)
_generate_msg_cpp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Dest.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/av_msgs
)
_generate_msg_cpp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/FusionMap.msg"
  "${MSG_I_FLAGS}"
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Pose.msg;/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/LaneMarker.msg;/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/WayPoint.msg;/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/DynamicObstacle.msg;/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/SectionList.msg;/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/GridMap.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/av_msgs
)
_generate_msg_cpp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Object3D.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/av_msgs
)
_generate_msg_cpp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/CameraTelescopic.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/jade/share/sensor_msgs/cmake/../msg/Image.msg;/opt/ros/jade/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/av_msgs
)
_generate_msg_cpp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/IbeoObject.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/av_msgs
)
_generate_msg_cpp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Pose.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/av_msgs
)
_generate_msg_cpp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/WayPoint.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/av_msgs
)
_generate_msg_cpp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/RSDSObjectList.msg"
  "${MSG_I_FLAGS}"
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/RSDSObject.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/av_msgs
)
_generate_msg_cpp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/SectionList.msg"
  "${MSG_I_FLAGS}"
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/LaneMarker.msg;/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/WayPoint.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/av_msgs
)
_generate_msg_cpp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/TrafficLightLoc.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/av_msgs
)
_generate_msg_cpp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/IbeoPoint.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/av_msgs
)
_generate_msg_cpp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/CameraBinocular.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/jade/share/sensor_msgs/cmake/../msg/Image.msg;/opt/ros/jade/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/av_msgs
)
_generate_msg_cpp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/CameraVelodyneObjectList.msg"
  "${MSG_I_FLAGS}"
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Object3D.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/av_msgs
)
_generate_msg_cpp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Localize.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/av_msgs
)
_generate_msg_cpp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/GpsData.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/av_msgs
)
_generate_msg_cpp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Trajectory.msg"
  "${MSG_I_FLAGS}"
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Pose.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/av_msgs
)
_generate_msg_cpp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/LaneMarker.msg"
  "${MSG_I_FLAGS}"
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/WayPoint.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/av_msgs
)
_generate_msg_cpp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/TrafficLightDetect.msg"
  "${MSG_I_FLAGS}"
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/TrafficLight.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/av_msgs
)
_generate_msg_cpp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/DynamicObstacle.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/av_msgs
)
_generate_msg_cpp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/RadarObject.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/av_msgs
)
_generate_msg_cpp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/RadarObjectList.msg"
  "${MSG_I_FLAGS}"
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/RadarObject.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/av_msgs
)
_generate_msg_cpp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/TrafficLight.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/av_msgs
)
_generate_msg_cpp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/ControlDebug.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/av_msgs
)
_generate_msg_cpp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/IbeoPointList.msg"
  "${MSG_I_FLAGS}"
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/IbeoPoint.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/av_msgs
)
_generate_msg_cpp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/ControlSignal.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/av_msgs
)
_generate_msg_cpp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/VehicleMsg.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/av_msgs
)
_generate_msg_cpp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/GridMap.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/av_msgs
)
_generate_msg_cpp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/TrafficLightMapData.msg"
  "${MSG_I_FLAGS}"
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/TrafficLightLoc.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/av_msgs
)
_generate_msg_cpp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/RSDSObject.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/av_msgs
)
_generate_msg_cpp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/StateMsg.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/av_msgs
)
_generate_msg_cpp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/IbeoObjectList.msg"
  "${MSG_I_FLAGS}"
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/IbeoObject.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/av_msgs
)

### Generating Services
_generate_srv_cpp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/srv/getLocalLanemarkers.srv"
  "${MSG_I_FLAGS}"
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/LaneMarker.msg;/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/SectionList.msg;/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/WayPoint.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/av_msgs
)

### Generating Module File
_generate_module_cpp(av_msgs
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/av_msgs
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(av_msgs_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(av_msgs_generate_messages av_msgs_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/VelodynePoints.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_cpp _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Dest.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_cpp _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/FusionMap.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_cpp _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Object3D.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_cpp _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/CameraTelescopic.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_cpp _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/IbeoObject.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_cpp _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Pose.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_cpp _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Localize.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_cpp _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/RSDSObjectList.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_cpp _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/SectionList.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_cpp _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/TrafficLightLoc.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_cpp _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/IbeoPoint.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_cpp _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/CameraBinocular.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_cpp _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/CameraVelodyneObjectList.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_cpp _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/WayPoint.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_cpp _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/GpsData.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_cpp _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Trajectory.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_cpp _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/LaneMarker.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_cpp _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/ControlSignal.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_cpp _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/DynamicObstacle.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_cpp _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/RadarObjectList.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_cpp _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/RadarObject.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_cpp _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/TrafficLight.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_cpp _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/ControlDebug.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_cpp _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/IbeoPointList.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_cpp _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/TrafficLightDetect.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_cpp _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/srv/getLocalLanemarkers.srv" NAME_WE)
add_dependencies(av_msgs_generate_messages_cpp _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/VehicleMsg.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_cpp _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/GridMap.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_cpp _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/StateMsg.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_cpp _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/RSDSObject.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_cpp _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/TrafficLightMapData.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_cpp _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/IbeoObjectList.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_cpp _av_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(av_msgs_gencpp)
add_dependencies(av_msgs_gencpp av_msgs_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS av_msgs_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/VelodynePoints.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/jade/share/sensor_msgs/cmake/../msg/PointCloud2.msg;/opt/ros/jade/share/sensor_msgs/cmake/../msg/PointField.msg;/opt/ros/jade/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/av_msgs
)
_generate_msg_eus(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Dest.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/av_msgs
)
_generate_msg_eus(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/FusionMap.msg"
  "${MSG_I_FLAGS}"
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Pose.msg;/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/LaneMarker.msg;/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/WayPoint.msg;/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/DynamicObstacle.msg;/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/SectionList.msg;/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/GridMap.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/av_msgs
)
_generate_msg_eus(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Object3D.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/av_msgs
)
_generate_msg_eus(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/CameraTelescopic.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/jade/share/sensor_msgs/cmake/../msg/Image.msg;/opt/ros/jade/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/av_msgs
)
_generate_msg_eus(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/IbeoObject.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/av_msgs
)
_generate_msg_eus(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Pose.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/av_msgs
)
_generate_msg_eus(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/WayPoint.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/av_msgs
)
_generate_msg_eus(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/RSDSObjectList.msg"
  "${MSG_I_FLAGS}"
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/RSDSObject.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/av_msgs
)
_generate_msg_eus(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/SectionList.msg"
  "${MSG_I_FLAGS}"
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/LaneMarker.msg;/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/WayPoint.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/av_msgs
)
_generate_msg_eus(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/TrafficLightLoc.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/av_msgs
)
_generate_msg_eus(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/IbeoPoint.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/av_msgs
)
_generate_msg_eus(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/CameraBinocular.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/jade/share/sensor_msgs/cmake/../msg/Image.msg;/opt/ros/jade/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/av_msgs
)
_generate_msg_eus(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/CameraVelodyneObjectList.msg"
  "${MSG_I_FLAGS}"
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Object3D.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/av_msgs
)
_generate_msg_eus(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Localize.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/av_msgs
)
_generate_msg_eus(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/GpsData.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/av_msgs
)
_generate_msg_eus(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Trajectory.msg"
  "${MSG_I_FLAGS}"
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Pose.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/av_msgs
)
_generate_msg_eus(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/LaneMarker.msg"
  "${MSG_I_FLAGS}"
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/WayPoint.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/av_msgs
)
_generate_msg_eus(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/TrafficLightDetect.msg"
  "${MSG_I_FLAGS}"
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/TrafficLight.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/av_msgs
)
_generate_msg_eus(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/DynamicObstacle.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/av_msgs
)
_generate_msg_eus(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/RadarObject.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/av_msgs
)
_generate_msg_eus(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/RadarObjectList.msg"
  "${MSG_I_FLAGS}"
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/RadarObject.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/av_msgs
)
_generate_msg_eus(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/TrafficLight.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/av_msgs
)
_generate_msg_eus(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/ControlDebug.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/av_msgs
)
_generate_msg_eus(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/IbeoPointList.msg"
  "${MSG_I_FLAGS}"
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/IbeoPoint.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/av_msgs
)
_generate_msg_eus(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/ControlSignal.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/av_msgs
)
_generate_msg_eus(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/VehicleMsg.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/av_msgs
)
_generate_msg_eus(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/GridMap.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/av_msgs
)
_generate_msg_eus(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/TrafficLightMapData.msg"
  "${MSG_I_FLAGS}"
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/TrafficLightLoc.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/av_msgs
)
_generate_msg_eus(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/RSDSObject.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/av_msgs
)
_generate_msg_eus(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/StateMsg.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/av_msgs
)
_generate_msg_eus(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/IbeoObjectList.msg"
  "${MSG_I_FLAGS}"
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/IbeoObject.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/av_msgs
)

### Generating Services
_generate_srv_eus(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/srv/getLocalLanemarkers.srv"
  "${MSG_I_FLAGS}"
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/LaneMarker.msg;/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/SectionList.msg;/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/WayPoint.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/av_msgs
)

### Generating Module File
_generate_module_eus(av_msgs
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/av_msgs
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(av_msgs_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(av_msgs_generate_messages av_msgs_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/VelodynePoints.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_eus _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Dest.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_eus _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/FusionMap.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_eus _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Object3D.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_eus _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/CameraTelescopic.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_eus _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/IbeoObject.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_eus _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Pose.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_eus _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Localize.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_eus _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/RSDSObjectList.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_eus _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/SectionList.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_eus _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/TrafficLightLoc.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_eus _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/IbeoPoint.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_eus _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/CameraBinocular.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_eus _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/CameraVelodyneObjectList.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_eus _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/WayPoint.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_eus _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/GpsData.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_eus _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Trajectory.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_eus _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/LaneMarker.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_eus _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/ControlSignal.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_eus _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/DynamicObstacle.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_eus _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/RadarObjectList.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_eus _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/RadarObject.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_eus _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/TrafficLight.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_eus _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/ControlDebug.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_eus _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/IbeoPointList.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_eus _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/TrafficLightDetect.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_eus _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/srv/getLocalLanemarkers.srv" NAME_WE)
add_dependencies(av_msgs_generate_messages_eus _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/VehicleMsg.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_eus _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/GridMap.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_eus _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/StateMsg.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_eus _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/RSDSObject.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_eus _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/TrafficLightMapData.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_eus _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/IbeoObjectList.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_eus _av_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(av_msgs_geneus)
add_dependencies(av_msgs_geneus av_msgs_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS av_msgs_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/VelodynePoints.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/jade/share/sensor_msgs/cmake/../msg/PointCloud2.msg;/opt/ros/jade/share/sensor_msgs/cmake/../msg/PointField.msg;/opt/ros/jade/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/av_msgs
)
_generate_msg_lisp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Dest.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/av_msgs
)
_generate_msg_lisp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/FusionMap.msg"
  "${MSG_I_FLAGS}"
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Pose.msg;/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/LaneMarker.msg;/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/WayPoint.msg;/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/DynamicObstacle.msg;/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/SectionList.msg;/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/GridMap.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/av_msgs
)
_generate_msg_lisp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Object3D.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/av_msgs
)
_generate_msg_lisp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/CameraTelescopic.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/jade/share/sensor_msgs/cmake/../msg/Image.msg;/opt/ros/jade/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/av_msgs
)
_generate_msg_lisp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/IbeoObject.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/av_msgs
)
_generate_msg_lisp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Pose.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/av_msgs
)
_generate_msg_lisp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/WayPoint.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/av_msgs
)
_generate_msg_lisp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/RSDSObjectList.msg"
  "${MSG_I_FLAGS}"
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/RSDSObject.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/av_msgs
)
_generate_msg_lisp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/SectionList.msg"
  "${MSG_I_FLAGS}"
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/LaneMarker.msg;/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/WayPoint.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/av_msgs
)
_generate_msg_lisp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/TrafficLightLoc.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/av_msgs
)
_generate_msg_lisp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/IbeoPoint.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/av_msgs
)
_generate_msg_lisp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/CameraBinocular.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/jade/share/sensor_msgs/cmake/../msg/Image.msg;/opt/ros/jade/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/av_msgs
)
_generate_msg_lisp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/CameraVelodyneObjectList.msg"
  "${MSG_I_FLAGS}"
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Object3D.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/av_msgs
)
_generate_msg_lisp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Localize.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/av_msgs
)
_generate_msg_lisp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/GpsData.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/av_msgs
)
_generate_msg_lisp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Trajectory.msg"
  "${MSG_I_FLAGS}"
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Pose.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/av_msgs
)
_generate_msg_lisp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/LaneMarker.msg"
  "${MSG_I_FLAGS}"
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/WayPoint.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/av_msgs
)
_generate_msg_lisp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/TrafficLightDetect.msg"
  "${MSG_I_FLAGS}"
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/TrafficLight.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/av_msgs
)
_generate_msg_lisp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/DynamicObstacle.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/av_msgs
)
_generate_msg_lisp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/RadarObject.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/av_msgs
)
_generate_msg_lisp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/RadarObjectList.msg"
  "${MSG_I_FLAGS}"
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/RadarObject.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/av_msgs
)
_generate_msg_lisp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/TrafficLight.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/av_msgs
)
_generate_msg_lisp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/ControlDebug.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/av_msgs
)
_generate_msg_lisp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/IbeoPointList.msg"
  "${MSG_I_FLAGS}"
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/IbeoPoint.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/av_msgs
)
_generate_msg_lisp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/ControlSignal.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/av_msgs
)
_generate_msg_lisp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/VehicleMsg.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/av_msgs
)
_generate_msg_lisp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/GridMap.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/av_msgs
)
_generate_msg_lisp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/TrafficLightMapData.msg"
  "${MSG_I_FLAGS}"
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/TrafficLightLoc.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/av_msgs
)
_generate_msg_lisp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/RSDSObject.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/av_msgs
)
_generate_msg_lisp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/StateMsg.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/av_msgs
)
_generate_msg_lisp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/IbeoObjectList.msg"
  "${MSG_I_FLAGS}"
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/IbeoObject.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/av_msgs
)

### Generating Services
_generate_srv_lisp(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/srv/getLocalLanemarkers.srv"
  "${MSG_I_FLAGS}"
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/LaneMarker.msg;/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/SectionList.msg;/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/WayPoint.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/av_msgs
)

### Generating Module File
_generate_module_lisp(av_msgs
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/av_msgs
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(av_msgs_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(av_msgs_generate_messages av_msgs_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/VelodynePoints.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_lisp _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Dest.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_lisp _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/FusionMap.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_lisp _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Object3D.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_lisp _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/CameraTelescopic.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_lisp _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/IbeoObject.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_lisp _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Pose.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_lisp _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Localize.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_lisp _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/RSDSObjectList.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_lisp _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/SectionList.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_lisp _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/TrafficLightLoc.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_lisp _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/IbeoPoint.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_lisp _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/CameraBinocular.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_lisp _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/CameraVelodyneObjectList.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_lisp _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/WayPoint.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_lisp _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/GpsData.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_lisp _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Trajectory.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_lisp _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/LaneMarker.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_lisp _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/ControlSignal.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_lisp _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/DynamicObstacle.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_lisp _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/RadarObjectList.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_lisp _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/RadarObject.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_lisp _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/TrafficLight.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_lisp _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/ControlDebug.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_lisp _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/IbeoPointList.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_lisp _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/TrafficLightDetect.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_lisp _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/srv/getLocalLanemarkers.srv" NAME_WE)
add_dependencies(av_msgs_generate_messages_lisp _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/VehicleMsg.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_lisp _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/GridMap.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_lisp _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/StateMsg.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_lisp _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/RSDSObject.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_lisp _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/TrafficLightMapData.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_lisp _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/IbeoObjectList.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_lisp _av_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(av_msgs_genlisp)
add_dependencies(av_msgs_genlisp av_msgs_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS av_msgs_generate_messages_lisp)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/VelodynePoints.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/jade/share/sensor_msgs/cmake/../msg/PointCloud2.msg;/opt/ros/jade/share/sensor_msgs/cmake/../msg/PointField.msg;/opt/ros/jade/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/av_msgs
)
_generate_msg_py(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Dest.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/av_msgs
)
_generate_msg_py(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/FusionMap.msg"
  "${MSG_I_FLAGS}"
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Pose.msg;/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/LaneMarker.msg;/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/WayPoint.msg;/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/DynamicObstacle.msg;/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/SectionList.msg;/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/GridMap.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/av_msgs
)
_generate_msg_py(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Object3D.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/av_msgs
)
_generate_msg_py(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/CameraTelescopic.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/jade/share/sensor_msgs/cmake/../msg/Image.msg;/opt/ros/jade/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/av_msgs
)
_generate_msg_py(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/IbeoObject.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/av_msgs
)
_generate_msg_py(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Pose.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/av_msgs
)
_generate_msg_py(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/WayPoint.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/av_msgs
)
_generate_msg_py(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/RSDSObjectList.msg"
  "${MSG_I_FLAGS}"
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/RSDSObject.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/av_msgs
)
_generate_msg_py(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/SectionList.msg"
  "${MSG_I_FLAGS}"
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/LaneMarker.msg;/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/WayPoint.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/av_msgs
)
_generate_msg_py(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/TrafficLightLoc.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/av_msgs
)
_generate_msg_py(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/IbeoPoint.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/av_msgs
)
_generate_msg_py(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/CameraBinocular.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/jade/share/sensor_msgs/cmake/../msg/Image.msg;/opt/ros/jade/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/av_msgs
)
_generate_msg_py(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/CameraVelodyneObjectList.msg"
  "${MSG_I_FLAGS}"
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Object3D.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/av_msgs
)
_generate_msg_py(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Localize.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/av_msgs
)
_generate_msg_py(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/GpsData.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/av_msgs
)
_generate_msg_py(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Trajectory.msg"
  "${MSG_I_FLAGS}"
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Pose.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/av_msgs
)
_generate_msg_py(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/LaneMarker.msg"
  "${MSG_I_FLAGS}"
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/WayPoint.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/av_msgs
)
_generate_msg_py(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/TrafficLightDetect.msg"
  "${MSG_I_FLAGS}"
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/TrafficLight.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/av_msgs
)
_generate_msg_py(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/DynamicObstacle.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/av_msgs
)
_generate_msg_py(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/RadarObject.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/av_msgs
)
_generate_msg_py(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/RadarObjectList.msg"
  "${MSG_I_FLAGS}"
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/RadarObject.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/av_msgs
)
_generate_msg_py(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/TrafficLight.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/av_msgs
)
_generate_msg_py(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/ControlDebug.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/av_msgs
)
_generate_msg_py(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/IbeoPointList.msg"
  "${MSG_I_FLAGS}"
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/IbeoPoint.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/av_msgs
)
_generate_msg_py(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/ControlSignal.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/av_msgs
)
_generate_msg_py(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/VehicleMsg.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/av_msgs
)
_generate_msg_py(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/GridMap.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/av_msgs
)
_generate_msg_py(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/TrafficLightMapData.msg"
  "${MSG_I_FLAGS}"
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/TrafficLightLoc.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/av_msgs
)
_generate_msg_py(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/RSDSObject.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/av_msgs
)
_generate_msg_py(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/StateMsg.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/av_msgs
)
_generate_msg_py(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/IbeoObjectList.msg"
  "${MSG_I_FLAGS}"
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/IbeoObject.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/av_msgs
)

### Generating Services
_generate_srv_py(av_msgs
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/srv/getLocalLanemarkers.srv"
  "${MSG_I_FLAGS}"
  "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/LaneMarker.msg;/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/SectionList.msg;/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/WayPoint.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/av_msgs
)

### Generating Module File
_generate_module_py(av_msgs
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/av_msgs
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(av_msgs_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(av_msgs_generate_messages av_msgs_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/VelodynePoints.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_py _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Dest.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_py _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/FusionMap.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_py _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Object3D.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_py _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/CameraTelescopic.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_py _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/IbeoObject.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_py _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Pose.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_py _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Localize.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_py _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/RSDSObjectList.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_py _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/SectionList.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_py _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/TrafficLightLoc.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_py _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/IbeoPoint.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_py _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/CameraBinocular.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_py _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/CameraVelodyneObjectList.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_py _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/WayPoint.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_py _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/GpsData.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_py _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Trajectory.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_py _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/LaneMarker.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_py _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/ControlSignal.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_py _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/DynamicObstacle.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_py _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/RadarObjectList.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_py _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/RadarObject.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_py _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/TrafficLight.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_py _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/ControlDebug.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_py _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/IbeoPointList.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_py _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/TrafficLightDetect.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_py _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/srv/getLocalLanemarkers.srv" NAME_WE)
add_dependencies(av_msgs_generate_messages_py _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/VehicleMsg.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_py _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/GridMap.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_py _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/StateMsg.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_py _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/RSDSObject.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_py _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/TrafficLightMapData.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_py _av_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/IbeoObjectList.msg" NAME_WE)
add_dependencies(av_msgs_generate_messages_py _av_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(av_msgs_genpy)
add_dependencies(av_msgs_genpy av_msgs_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS av_msgs_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/av_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/av_msgs
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
add_dependencies(av_msgs_generate_messages_cpp std_msgs_generate_messages_cpp)
add_dependencies(av_msgs_generate_messages_cpp sensor_msgs_generate_messages_cpp)

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/av_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/av_msgs
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
add_dependencies(av_msgs_generate_messages_eus std_msgs_generate_messages_eus)
add_dependencies(av_msgs_generate_messages_eus sensor_msgs_generate_messages_eus)

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/av_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/av_msgs
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
add_dependencies(av_msgs_generate_messages_lisp std_msgs_generate_messages_lisp)
add_dependencies(av_msgs_generate_messages_lisp sensor_msgs_generate_messages_lisp)

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/av_msgs)
  install(CODE "execute_process(COMMAND \"/usr/bin/python\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/av_msgs\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/av_msgs
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
add_dependencies(av_msgs_generate_messages_py std_msgs_generate_messages_py)
add_dependencies(av_msgs_generate_messages_py sensor_msgs_generate_messages_py)
