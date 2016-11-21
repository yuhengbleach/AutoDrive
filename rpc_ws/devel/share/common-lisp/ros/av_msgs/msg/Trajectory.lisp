; Auto-generated. Do not edit!


(cl:in-package av_msgs-msg)


;//! \htmlinclude Trajectory.msg.html

(cl:defclass <Trajectory> (roslisp-msg-protocol:ros-message)
  ((initial_pose
    :reader initial_pose
    :initarg :initial_pose
    :type av_msgs-msg:Pose
    :initform (cl:make-instance 'av_msgs-msg:Pose))
   (poses
    :reader poses
    :initarg :poses
    :type (cl:vector av_msgs-msg:Pose)
   :initform (cl:make-array 0 :element-type 'av_msgs-msg:Pose :initial-element (cl:make-instance 'av_msgs-msg:Pose)))
   (driving_direction
    :reader driving_direction
    :initarg :driving_direction
    :type cl:fixnum
    :initform 0)
   (driving_state
    :reader driving_state
    :initarg :driving_state
    :type cl:fixnum
    :initform 0))
)

(cl:defclass Trajectory (<Trajectory>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Trajectory>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Trajectory)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name av_msgs-msg:<Trajectory> is deprecated: use av_msgs-msg:Trajectory instead.")))

(cl:ensure-generic-function 'initial_pose-val :lambda-list '(m))
(cl:defmethod initial_pose-val ((m <Trajectory>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:initial_pose-val is deprecated.  Use av_msgs-msg:initial_pose instead.")
  (initial_pose m))

(cl:ensure-generic-function 'poses-val :lambda-list '(m))
(cl:defmethod poses-val ((m <Trajectory>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:poses-val is deprecated.  Use av_msgs-msg:poses instead.")
  (poses m))

(cl:ensure-generic-function 'driving_direction-val :lambda-list '(m))
(cl:defmethod driving_direction-val ((m <Trajectory>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:driving_direction-val is deprecated.  Use av_msgs-msg:driving_direction instead.")
  (driving_direction m))

(cl:ensure-generic-function 'driving_state-val :lambda-list '(m))
(cl:defmethod driving_state-val ((m <Trajectory>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:driving_state-val is deprecated.  Use av_msgs-msg:driving_state instead.")
  (driving_state m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Trajectory>) ostream)
  "Serializes a message object of type '<Trajectory>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'initial_pose) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'poses))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'poses))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'driving_direction)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'driving_state)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Trajectory>) istream)
  "Deserializes a message object of type '<Trajectory>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'initial_pose) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'poses) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'poses)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'av_msgs-msg:Pose))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'driving_direction)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'driving_state)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Trajectory>)))
  "Returns string type for a message object of type '<Trajectory>"
  "av_msgs/Trajectory")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Trajectory)))
  "Returns string type for a message object of type 'Trajectory"
  "av_msgs/Trajectory")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Trajectory>)))
  "Returns md5sum for a message object of type '<Trajectory>"
  "11573a4fb030f7929e047f56621802a1")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Trajectory)))
  "Returns md5sum for a message object of type 'Trajectory"
  "11573a4fb030f7929e047f56621802a1")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Trajectory>)))
  "Returns full string definition for message of type '<Trajectory>"
  (cl:format cl:nil "Pose initial_pose~%Pose[] poses~%uint8 driving_direction~%uint8 driving_state~%~%================================================================================~%MSG: av_msgs/Pose~%# 时间戳~%uint64 timestamp~%# 轨迹x坐标~%float64 x~%# 轨迹y坐标~%float64 y~%# 轨迹朝向角坐标~%float64 theta~%# 曲率~%float64 curvature~%# 速度~%float64 velocity~%# 加速度~%float64 acceleration~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Trajectory)))
  "Returns full string definition for message of type 'Trajectory"
  (cl:format cl:nil "Pose initial_pose~%Pose[] poses~%uint8 driving_direction~%uint8 driving_state~%~%================================================================================~%MSG: av_msgs/Pose~%# 时间戳~%uint64 timestamp~%# 轨迹x坐标~%float64 x~%# 轨迹y坐标~%float64 y~%# 轨迹朝向角坐标~%float64 theta~%# 曲率~%float64 curvature~%# 速度~%float64 velocity~%# 加速度~%float64 acceleration~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Trajectory>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'initial_pose))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'poses) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     1
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Trajectory>))
  "Converts a ROS message object to a list"
  (cl:list 'Trajectory
    (cl:cons ':initial_pose (initial_pose msg))
    (cl:cons ':poses (poses msg))
    (cl:cons ':driving_direction (driving_direction msg))
    (cl:cons ':driving_state (driving_state msg))
))
