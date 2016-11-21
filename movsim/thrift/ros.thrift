namespace java Ros
namespace cpp Ros

struct GridMap {
    1: i32 width,
    2: i32 length,
    3: i32 center_x,
    4: i32 center_y,
    5: list<i16> grid_map
}

struct WayPoint {
    1: double x,
    2: double y
}

struct LaneMarker {
    #车道线类型
    1: i16 paint_type,
    #车道线点序列
    2: list<WayPoint> waypoints
}

struct SectionList {
    # SectionList
    1: list<LaneMarker> lane_marker_list,
    # 0:curved 1:straight
    2: i16 section_type
}

struct DynamicObstacle {
    1: i16 class_id,
    2: i64 id,
    3: double center_x,
    4: double center_y,
    5: double center_z,
    6: double width,
    7: double height,
    8: double length,
    9: double velocity,
    # 车头夹角
    10: double heading,
    # 角速度
    11: double omega,
    # 加速度
    12: double acceleration,
    # 遮挡时间，单位 sec
    13: double shield_time,

    # 测速 box 模型的协方差（用一维数组模拟二维数组，需要转换，6 * 6）
    14: list<double> velocity_measurement_covariance
}

struct TrafficLight {
    1: i16 id,
    #交通灯ID
    2: i16 type,
    #直行，左转，右转，掉头
    3: i16 status,
    #红 黄 绿
    4: i16 time,
    #当前状态倒数数字
    5: double confidence
    #置信度
}

struct TrafficLightDetect {
    1: i64 timestamp,
    2: list<TrafficLight> tl_det_list
}

struct Localize {
    1: i64 timestamp,
    2: string raw_data,
    3: double mTime,
    4: double latitude,
    5: double longitude,
    6: double altitude,
    7: double vel_x,
    8: double vel_y,
    9: double vel_z,
    10: double acc_x,
    11: double acc_y,
    12: double acc_z,
    13: i16 nav_mode,
    14: i16 pos_mode,
    15: i16 vel_mode,
    16: i16 att_mode,
    17: double angular_vel_x,
    18: double angular_vel_y,
    19: double angular_vel_z,
    20: double heading,
    21: double pitch,
    22: double roll,
    23: double pose_x,
    24: double pose_y
}

struct Dest {
    1: i64 timestamp,
    2: double x,
    3: double y,
    4: double z
}

struct Pose {
    # 时间戳
    1: i64 timestamp,
    # 轨迹x坐标
    2: double x,
    # 轨迹y坐标
    3: double y,
    # 轨迹朝向角坐标
    4: double theta,
    # 曲率
    5: double curvature,
    # 速度list
    6: double velocity,
    # 加速度
    7: double acceleration
}

struct Trajectory {
    1: Pose initial_pose,
    2: list<Pose> poses,
    3: i16 driving_direction,
    4: i16 driving_state
}

struct Fusionmap {
    1: i64 timestamp,
    2: list<DynamicObstacle> dynamic_object_list,
    3: GridMap obstacle_map,
    4: list<SectionList> section_list,
    5: Pose pose
}

service RosService {
    Trajectory getTrajectory();
    oneway void publishFusionMap(1: Fusionmap fusion_map);
    oneway void publishTrafficLightDetect(1: TrafficLightDetect traffic_light_detect);
    oneway void publishLocalize(1: Localize localize);
    oneway void publishDest(1: Dest dest);
}