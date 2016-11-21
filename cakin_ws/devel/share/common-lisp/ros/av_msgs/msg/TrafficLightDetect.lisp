; Auto-generated. Do not edit!


(cl:in-package av_msgs-msg)


;//! \htmlinclude TrafficLightDetect.msg.html

(cl:defclass <TrafficLightDetect> (roslisp-msg-protocol:ros-message)
  ((timestamp
    :reader timestamp
    :initarg :timestamp
    :type cl:integer
    :initform 0)
   (tl_det_list
    :reader tl_det_list
    :initarg :tl_det_list
    :type (cl:vector av_msgs-msg:TrafficLight)
   :initform (cl:make-array 0 :element-type 'av_msgs-msg:TrafficLight :initial-element (cl:make-instance 'av_msgs-msg:TrafficLight))))
)

(cl:defclass TrafficLightDetect (<TrafficLightDetect>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <TrafficLightDetect>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'TrafficLightDetect)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name av_msgs-msg:<TrafficLightDetect> is deprecated: use av_msgs-msg:TrafficLightDetect instead.")))

(cl:ensure-generic-function 'timestamp-val :lambda-list '(m))
(cl:defmethod timestamp-val ((m <TrafficLightDetect>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:timestamp-val is deprecated.  Use av_msgs-msg:timestamp instead.")
  (timestamp m))

(cl:ensure-generic-function 'tl_det_list-val :lambda-list '(m))
(cl:defmethod tl_det_list-val ((m <TrafficLightDetect>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:tl_det_list-val is deprecated.  Use av_msgs-msg:tl_det_list instead.")
  (tl_det_list m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <TrafficLightDetect>) ostream)
  "Serializes a message object of type '<TrafficLightDetect>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'timestamp)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'timestamp)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'timestamp)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'timestamp)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 32) (cl:slot-value msg 'timestamp)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 40) (cl:slot-value msg 'timestamp)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 48) (cl:slot-value msg 'timestamp)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 56) (cl:slot-value msg 'timestamp)) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'tl_det_list))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'tl_det_list))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <TrafficLightDetect>) istream)
  "Deserializes a message object of type '<TrafficLightDetect>"
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
  (cl:setf (cl:slot-value msg 'tl_det_list) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'tl_det_list)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'av_msgs-msg:TrafficLight))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<TrafficLightDetect>)))
  "Returns string type for a message object of type '<TrafficLightDetect>"
  "av_msgs/TrafficLightDetect")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'TrafficLightDetect)))
  "Returns string type for a message object of type 'TrafficLightDetect"
  "av_msgs/TrafficLightDetect")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<TrafficLightDetect>)))
  "Returns md5sum for a message object of type '<TrafficLightDetect>"
  "33316cd0fd07b9b668bdae386f00ea87")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'TrafficLightDetect)))
  "Returns md5sum for a message object of type 'TrafficLightDetect"
  "33316cd0fd07b9b668bdae386f00ea87")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<TrafficLightDetect>)))
  "Returns full string definition for message of type '<TrafficLightDetect>"
  (cl:format cl:nil "uint64 timestamp~%TrafficLight[]  tl_det_list~%~%================================================================================~%MSG: av_msgs/TrafficLight~%uint8 id~%#交通灯ID~%uint8 type~%#圆形1 左转2 直行3 右转4 左转掉头5 掉头6~%uint8 status~%#红1 绿2 黄3~%uint8 time~%#当前状态倒数数字~%float32 confidence~%#置信度~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'TrafficLightDetect)))
  "Returns full string definition for message of type 'TrafficLightDetect"
  (cl:format cl:nil "uint64 timestamp~%TrafficLight[]  tl_det_list~%~%================================================================================~%MSG: av_msgs/TrafficLight~%uint8 id~%#交通灯ID~%uint8 type~%#圆形1 左转2 直行3 右转4 左转掉头5 掉头6~%uint8 status~%#红1 绿2 黄3~%uint8 time~%#当前状态倒数数字~%float32 confidence~%#置信度~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <TrafficLightDetect>))
  (cl:+ 0
     8
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'tl_det_list) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <TrafficLightDetect>))
  "Converts a ROS message object to a list"
  (cl:list 'TrafficLightDetect
    (cl:cons ':timestamp (timestamp msg))
    (cl:cons ':tl_det_list (tl_det_list msg))
))
