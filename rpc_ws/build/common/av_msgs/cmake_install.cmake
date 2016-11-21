# Install script for directory: /home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs

# Set the install prefix
IF(NOT DEFINED CMAKE_INSTALL_PREFIX)
  SET(CMAKE_INSTALL_PREFIX "/home/zhouji/Documents/autodrive/rpc_ws/install")
ENDIF(NOT DEFINED CMAKE_INSTALL_PREFIX)
STRING(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
IF(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  IF(BUILD_TYPE)
    STRING(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  ELSE(BUILD_TYPE)
    SET(CMAKE_INSTALL_CONFIG_NAME "")
  ENDIF(BUILD_TYPE)
  MESSAGE(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
ENDIF(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)

# Set the component getting installed.
IF(NOT CMAKE_INSTALL_COMPONENT)
  IF(COMPONENT)
    MESSAGE(STATUS "Install component: \"${COMPONENT}\"")
    SET(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  ELSE(COMPONENT)
    SET(CMAKE_INSTALL_COMPONENT)
  ENDIF(COMPONENT)
ENDIF(NOT CMAKE_INSTALL_COMPONENT)

# Install shared libraries without execute permission?
IF(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  SET(CMAKE_INSTALL_SO_NO_EXE "1")
ENDIF(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/av_msgs/msg" TYPE FILE FILES
    "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/StateMsg.msg"
    "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/IbeoObject.msg"
    "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Dest.msg"
    "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/IbeoObjectList.msg"
    "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/RSDSObject.msg"
    "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/CameraTelescopic.msg"
    "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Object3D.msg"
    "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/VelodynePoints.msg"
    "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/RSDSObjectList.msg"
    "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/LaneMarker.msg"
    "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Trajectory.msg"
    "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/IbeoPoint.msg"
    "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/GpsData.msg"
    "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/RadarObject.msg"
    "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/DynamicObstacle.msg"
    "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/ControlDebug.msg"
    "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/WayPoint.msg"
    "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/IbeoPointList.msg"
    "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/RadarObjectList.msg"
    "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/ControlSignal.msg"
    "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Localize.msg"
    "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/SectionList.msg"
    "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/TrafficLightDetect.msg"
    "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/Pose.msg"
    "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/TrafficLightLoc.msg"
    "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/FusionMap.msg"
    "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/CameraVelodyneObjectList.msg"
    "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/VehicleMsg.msg"
    "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/CameraBinocular.msg"
    "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/TrafficLight.msg"
    "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/TrafficLightMapData.msg"
    "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/msg/GridMap.msg"
    )
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/av_msgs/srv" TYPE FILE FILES "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/srv/getLocalLanemarkers.srv")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/av_msgs/cmake" TYPE FILE FILES "/home/zhouji/Documents/autodrive/rpc_ws/build/common/av_msgs/catkin_generated/installspace/av_msgs-msg-paths.cmake")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "/home/zhouji/Documents/autodrive/rpc_ws/devel/include/av_msgs")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roseus/ros" TYPE DIRECTORY FILES "/home/zhouji/Documents/autodrive/rpc_ws/devel/share/roseus/ros/av_msgs")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/common-lisp/ros" TYPE DIRECTORY FILES "/home/zhouji/Documents/autodrive/rpc_ws/devel/share/common-lisp/ros/av_msgs")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  execute_process(COMMAND "/usr/bin/python" -m compileall "/home/zhouji/Documents/autodrive/rpc_ws/devel/lib/python2.7/dist-packages/av_msgs")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python2.7/dist-packages" TYPE DIRECTORY FILES "/home/zhouji/Documents/autodrive/rpc_ws/devel/lib/python2.7/dist-packages/av_msgs")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/zhouji/Documents/autodrive/rpc_ws/build/common/av_msgs/catkin_generated/installspace/av_msgs.pc")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/av_msgs/cmake" TYPE FILE FILES "/home/zhouji/Documents/autodrive/rpc_ws/build/common/av_msgs/catkin_generated/installspace/av_msgs-msg-extras.cmake")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/av_msgs/cmake" TYPE FILE FILES
    "/home/zhouji/Documents/autodrive/rpc_ws/build/common/av_msgs/catkin_generated/installspace/av_msgsConfig.cmake"
    "/home/zhouji/Documents/autodrive/rpc_ws/build/common/av_msgs/catkin_generated/installspace/av_msgsConfig-version.cmake"
    )
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/av_msgs" TYPE FILE FILES "/home/zhouji/Documents/autodrive/rpc_ws/src/common/av_msgs/package.xml")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

