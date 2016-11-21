; Auto-generated. Do not edit!


(cl:in-package av_msgs-msg)


;//! \htmlinclude RadarObjectList.msg.html

(cl:defclass <RadarObjectList> (roslisp-msg-protocol:ros-message)
  ((timestamp
    :reader timestamp
    :initarg :timestamp
    :type cl:integer
    :initform 0)
   (flag
    :reader flag
    :initarg :flag
    :type cl:string
    :initform "")
   (radar_object_list
    :reader radar_object_list
    :initarg :radar_object_list
    :type (cl:vector av_msgs-msg:RadarObject)
   :initform (cl:make-array 0 :element-type 'av_msgs-msg:RadarObject :initial-element (cl:make-instance 'av_msgs-msg:RadarObject))))
)

(cl:defclass RadarObjectList (<RadarObjectList>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <RadarObjectList>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'RadarObjectList)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name av_msgs-msg:<RadarObjectList> is deprecated: use av_msgs-msg:RadarObjectList instead.")))

(cl:ensure-generic-function 'timestamp-val :lambda-list '(m))
(cl:defmethod timestamp-val ((m <RadarObjectList>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:timestamp-val is deprecated.  Use av_msgs-msg:timestamp instead.")
  (timestamp m))

(cl:ensure-generic-function 'flag-val :lambda-list '(m))
(cl:defmethod flag-val ((m <RadarObjectList>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:flag-val is deprecated.  Use av_msgs-msg:flag instead.")
  (flag m))

(cl:ensure-generic-function 'radar_object_list-val :lambda-list '(m))
(cl:defmethod radar_object_list-val ((m <RadarObjectList>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:radar_object_list-val is deprecated.  Use av_msgs-msg:radar_object_list instead.")
  (radar_object_list m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <RadarObjectList>) ostream)
  "Serializes a message object of type '<RadarObjectList>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'timestamp)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'timestamp)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'timestamp)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'timestamp)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 32) (cl:slot-value msg 'timestamp)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 40) (cl:slot-value msg 'timestamp)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 48) (cl:slot-value msg 'timestamp)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 56) (cl:slot-value msg 'timestamp)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'flag))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'flag))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'radar_object_list))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'radar_object_list))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <RadarObjectList>) istream)
  "Deserializes a message object of type '<RadarObjectList>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'timestamp)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'timestamp)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'timestamp)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'timestamp)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 32) (cl:slot-value msg 'timestamp)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 40) (cl:slot-value msg 'timestamp)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 48) (cl:slot-value msg 'timestamp)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 56) (cl:slot-value msg 'timestamp)) (cl:read-byte istream))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'flag) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'flag) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'radar_object_list) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'radar_object_list)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'av_msgs-msg:RadarObject))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<RadarObjectList>)))
  "Returns string type for a message object of type '<RadarObjectList>"
  "av_msgs/RadarObjectList")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'RadarObjectList)))
  "Returns string type for a message object of type 'RadarObjectList"
  "av_msgs/RadarObjectList")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<RadarObjectList>)))
  "Returns md5sum for a message object of type '<RadarObjectList>"
  "c5193a6df61f3d5bda7cb7e3b05fb09f")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'RadarObjectList)))
  "Returns md5sum for a message object of type 'RadarObjectList"
  "c5193a6df61f3d5bda7cb7e3b05fb09f")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<RadarObjectList>)))
  "Returns full string definition for message of type '<RadarObjectList>"
  (cl:format cl:nil "uint64 timestamp~%string flag~%RadarObject[] radar_object_list~%~%================================================================================~%MSG: av_msgs/RadarObject~%uint64 id               # 物体ID~%~%float32 range           # 物体的距离 0 到 204.7 m~%float32 angle           # 物体的方向角 -51.2 to 51.1 deg~%float32 velocity        # 物体的速度    -81.92 to 81.91 m/s~%float32 accel           # 物体的加速度  -25.60 to 25.55 m/s/s~%string msg~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'RadarObjectList)))
  "Returns full string definition for message of type 'RadarObjectList"
  (cl:format cl:nil "uint64 timestamp~%string flag~%RadarObject[] radar_object_list~%~%================================================================================~%MSG: av_msgs/RadarObject~%uint64 id               # 物体ID~%~%float32 range           # 物体的距离 0 到 204.7 m~%float32 angle           # 物体的方向角 -51.2 to 51.1 deg~%float32 velocity        # 物体的速度    -81.92 to 81.91 m/s~%float32 accel           # 物体的加速度  -25.60 to 25.55 m/s/s~%string msg~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <RadarObjectList>))
  (cl:+ 0
     8
     4 (cl:length (cl:slot-value msg 'flag))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'radar_object_list) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <RadarObjectList>))
  "Converts a ROS message object to a list"
  (cl:list 'RadarObjectList
    (cl:cons ':timestamp (timestamp msg))
    (cl:cons ':flag (flag msg))
    (cl:cons ':radar_object_list (radar_object_list msg))
))
