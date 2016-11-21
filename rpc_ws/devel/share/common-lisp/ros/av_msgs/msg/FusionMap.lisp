; Auto-generated. Do not edit!


(cl:in-package av_msgs-msg)


;//! \htmlinclude FusionMap.msg.html

(cl:defclass <FusionMap> (roslisp-msg-protocol:ros-message)
  ((timestamp
    :reader timestamp
    :initarg :timestamp
    :type cl:integer
    :initform 0)
   (dynamic_object_list
    :reader dynamic_object_list
    :initarg :dynamic_object_list
    :type (cl:vector av_msgs-msg:DynamicObstacle)
   :initform (cl:make-array 0 :element-type 'av_msgs-msg:DynamicObstacle :initial-element (cl:make-instance 'av_msgs-msg:DynamicObstacle)))
   (obstacle_map
    :reader obstacle_map
    :initarg :obstacle_map
    :type av_msgs-msg:GridMap
    :initform (cl:make-instance 'av_msgs-msg:GridMap))
   (section_list
    :reader section_list
    :initarg :section_list
    :type (cl:vector av_msgs-msg:SectionList)
   :initform (cl:make-array 0 :element-type 'av_msgs-msg:SectionList :initial-element (cl:make-instance 'av_msgs-msg:SectionList)))
   (pose
    :reader pose
    :initarg :pose
    :type av_msgs-msg:Pose
    :initform (cl:make-instance 'av_msgs-msg:Pose)))
)

(cl:defclass FusionMap (<FusionMap>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <FusionMap>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'FusionMap)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name av_msgs-msg:<FusionMap> is deprecated: use av_msgs-msg:FusionMap instead.")))

(cl:ensure-generic-function 'timestamp-val :lambda-list '(m))
(cl:defmethod timestamp-val ((m <FusionMap>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:timestamp-val is deprecated.  Use av_msgs-msg:timestamp instead.")
  (timestamp m))

(cl:ensure-generic-function 'dynamic_object_list-val :lambda-list '(m))
(cl:defmethod dynamic_object_list-val ((m <FusionMap>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:dynamic_object_list-val is deprecated.  Use av_msgs-msg:dynamic_object_list instead.")
  (dynamic_object_list m))

(cl:ensure-generic-function 'obstacle_map-val :lambda-list '(m))
(cl:defmethod obstacle_map-val ((m <FusionMap>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:obstacle_map-val is deprecated.  Use av_msgs-msg:obstacle_map instead.")
  (obstacle_map m))

(cl:ensure-generic-function 'section_list-val :lambda-list '(m))
(cl:defmethod section_list-val ((m <FusionMap>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:section_list-val is deprecated.  Use av_msgs-msg:section_list instead.")
  (section_list m))

(cl:ensure-generic-function 'pose-val :lambda-list '(m))
(cl:defmethod pose-val ((m <FusionMap>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:pose-val is deprecated.  Use av_msgs-msg:pose instead.")
  (pose m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <FusionMap>) ostream)
  "Serializes a message object of type '<FusionMap>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'timestamp)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'timestamp)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'timestamp)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'timestamp)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 32) (cl:slot-value msg 'timestamp)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 40) (cl:slot-value msg 'timestamp)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 48) (cl:slot-value msg 'timestamp)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 56) (cl:slot-value msg 'timestamp)) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'dynamic_object_list))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'dynamic_object_list))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'obstacle_map) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'section_list))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'section_list))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'pose) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <FusionMap>) istream)
  "Deserializes a message object of type '<FusionMap>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'timestamp)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'timestamp)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'timestamp)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'timestamp)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 32) (cl:slot-value msg 'timestamp)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 40) (cl:slot-value msg 'timestamp)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 48) (cl:slot-value msg 'timestamp)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 56) (cl:slot-value msg 'timestamp)) (cl:read-byte istream))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'dynamic_object_list) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'dynamic_object_list)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'av_msgs-msg:DynamicObstacle))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'obstacle_map) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'section_list) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'section_list)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'av_msgs-msg:SectionList))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'pose) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<FusionMap>)))
  "Returns string type for a message object of type '<FusionMap>"
  "av_msgs/FusionMap")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'FusionMap)))
  "Returns string type for a message object of type 'FusionMap"
  "av_msgs/FusionMap")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<FusionMap>)))
  "Returns md5sum for a message object of type '<FusionMap>"
  "aa32fc0bd4214ed3b5eceff3c45ac56b")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'FusionMap)))
  "Returns md5sum for a message object of type 'FusionMap"
  "aa32fc0bd4214ed3b5eceff3c45ac56b")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<FusionMap>)))
  "Returns full string definition for message of type '<FusionMap>"
  (cl:format cl:nil "# Fusion map.~%~%uint64 timestamp                        # 当前时间戳~%~%DynamicObstacle[] dynamic_object_list   # 动态障碍物列表~%~%GridMap obstacle_map                    # 静态障碍物矩阵，150*100m(前100，后50，左50，右50)，~%                                        # 粒度10cm*10cm, 可行驶区域为0，障碍物为1，不可见区域－1~%SectionList[] section_list           	# 车道线列表~%~%Pose pose~%~%================================================================================~%MSG: av_msgs/DynamicObstacle~%uint8 class_id~%uint64 id~%float32 center_x~%float32 center_y~%float32 center_z~%float32 width~%float32 height~%float32 length~%float32 velocity~%# 车头夹角~%float32 heading~%# 角速度~%float32 omega~%# 加速度~%float32 acceleration~%# 遮挡时间，单位 sec~%uint32 shield_time~%~%# 测速 box 模型的协方差（用一维数组模拟二维数组，需要转换，6 * 6）~%float64[] velocity_measurement_covariance~%~%~%================================================================================~%MSG: av_msgs/GridMap~%int32 width~%int32 length~%int32 center_x~%int32 center_y~%uint8[] grid_map~%~%================================================================================~%MSG: av_msgs/SectionList~%# SectionList~%LaneMarker[] lane_marker_list~%# 0:curved 1:straight~%int8 section_type~%~%~%================================================================================~%MSG: av_msgs/LaneMarker~%#车道线类型~%int8 paint_type~%#车道线点序列~%WayPoint[] waypoints~%~%~%================================================================================~%MSG: av_msgs/WayPoint~%float64 x~%float64 y~%================================================================================~%MSG: av_msgs/Pose~%# 时间戳~%uint64 timestamp~%# 轨迹x坐标~%float64 x~%# 轨迹y坐标~%float64 y~%# 轨迹朝向角坐标~%float64 theta~%# 曲率~%float64 curvature~%# 速度~%float64 velocity~%# 加速度~%float64 acceleration~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'FusionMap)))
  "Returns full string definition for message of type 'FusionMap"
  (cl:format cl:nil "# Fusion map.~%~%uint64 timestamp                        # 当前时间戳~%~%DynamicObstacle[] dynamic_object_list   # 动态障碍物列表~%~%GridMap obstacle_map                    # 静态障碍物矩阵，150*100m(前100，后50，左50，右50)，~%                                        # 粒度10cm*10cm, 可行驶区域为0，障碍物为1，不可见区域－1~%SectionList[] section_list           	# 车道线列表~%~%Pose pose~%~%================================================================================~%MSG: av_msgs/DynamicObstacle~%uint8 class_id~%uint64 id~%float32 center_x~%float32 center_y~%float32 center_z~%float32 width~%float32 height~%float32 length~%float32 velocity~%# 车头夹角~%float32 heading~%# 角速度~%float32 omega~%# 加速度~%float32 acceleration~%# 遮挡时间，单位 sec~%uint32 shield_time~%~%# 测速 box 模型的协方差（用一维数组模拟二维数组，需要转换，6 * 6）~%float64[] velocity_measurement_covariance~%~%~%================================================================================~%MSG: av_msgs/GridMap~%int32 width~%int32 length~%int32 center_x~%int32 center_y~%uint8[] grid_map~%~%================================================================================~%MSG: av_msgs/SectionList~%# SectionList~%LaneMarker[] lane_marker_list~%# 0:curved 1:straight~%int8 section_type~%~%~%================================================================================~%MSG: av_msgs/LaneMarker~%#车道线类型~%int8 paint_type~%#车道线点序列~%WayPoint[] waypoints~%~%~%================================================================================~%MSG: av_msgs/WayPoint~%float64 x~%float64 y~%================================================================================~%MSG: av_msgs/Pose~%# 时间戳~%uint64 timestamp~%# 轨迹x坐标~%float64 x~%# 轨迹y坐标~%float64 y~%# 轨迹朝向角坐标~%float64 theta~%# 曲率~%float64 curvature~%# 速度~%float64 velocity~%# 加速度~%float64 acceleration~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <FusionMap>))
  (cl:+ 0
     8
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'dynamic_object_list) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'obstacle_map))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'section_list) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'pose))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <FusionMap>))
  "Converts a ROS message object to a list"
  (cl:list 'FusionMap
    (cl:cons ':timestamp (timestamp msg))
    (cl:cons ':dynamic_object_list (dynamic_object_list msg))
    (cl:cons ':obstacle_map (obstacle_map msg))
    (cl:cons ':section_list (section_list msg))
    (cl:cons ':pose (pose msg))
))
