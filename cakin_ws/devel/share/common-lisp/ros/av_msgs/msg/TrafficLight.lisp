; Auto-generated. Do not edit!


(cl:in-package av_msgs-msg)


;//! \htmlinclude TrafficLight.msg.html

(cl:defclass <TrafficLight> (roslisp-msg-protocol:ros-message)
  ((id
    :reader id
    :initarg :id
    :type cl:fixnum
    :initform 0)
   (type
    :reader type
    :initarg :type
    :type cl:fixnum
    :initform 0)
   (status
    :reader status
    :initarg :status
    :type cl:fixnum
    :initform 0)
   (time
    :reader time
    :initarg :time
    :type cl:fixnum
    :initform 0)
   (confidence
    :reader confidence
    :initarg :confidence
    :type cl:float
    :initform 0.0))
)

(cl:defclass TrafficLight (<TrafficLight>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <TrafficLight>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'TrafficLight)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name av_msgs-msg:<TrafficLight> is deprecated: use av_msgs-msg:TrafficLight instead.")))

(cl:ensure-generic-function 'id-val :lambda-list '(m))
(cl:defmethod id-val ((m <TrafficLight>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:id-val is deprecated.  Use av_msgs-msg:id instead.")
  (id m))

(cl:ensure-generic-function 'type-val :lambda-list '(m))
(cl:defmethod type-val ((m <TrafficLight>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:type-val is deprecated.  Use av_msgs-msg:type instead.")
  (type m))

(cl:ensure-generic-function 'status-val :lambda-list '(m))
(cl:defmethod status-val ((m <TrafficLight>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:status-val is deprecated.  Use av_msgs-msg:status instead.")
  (status m))

(cl:ensure-generic-function 'time-val :lambda-list '(m))
(cl:defmethod time-val ((m <TrafficLight>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:time-val is deprecated.  Use av_msgs-msg:time instead.")
  (time m))

(cl:ensure-generic-function 'confidence-val :lambda-list '(m))
(cl:defmethod confidence-val ((m <TrafficLight>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:confidence-val is deprecated.  Use av_msgs-msg:confidence instead.")
  (confidence m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <TrafficLight>) ostream)
  "Serializes a message object of type '<TrafficLight>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'type)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'status)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'time)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'confidence))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <TrafficLight>) istream)
  "Deserializes a message object of type '<TrafficLight>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'type)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'status)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'time)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'confidence) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<TrafficLight>)))
  "Returns string type for a message object of type '<TrafficLight>"
  "av_msgs/TrafficLight")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'TrafficLight)))
  "Returns string type for a message object of type 'TrafficLight"
  "av_msgs/TrafficLight")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<TrafficLight>)))
  "Returns md5sum for a message object of type '<TrafficLight>"
  "12e6ff6aa826247c71e4c2bc2f9e6414")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'TrafficLight)))
  "Returns md5sum for a message object of type 'TrafficLight"
  "12e6ff6aa826247c71e4c2bc2f9e6414")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<TrafficLight>)))
  "Returns full string definition for message of type '<TrafficLight>"
  (cl:format cl:nil "uint8 id~%#交通灯ID~%uint8 type~%#圆形1 左转2 直行3 右转4 左转掉头5 掉头6~%uint8 status~%#红1 绿2 黄3~%uint8 time~%#当前状态倒数数字~%float32 confidence~%#置信度~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'TrafficLight)))
  "Returns full string definition for message of type 'TrafficLight"
  (cl:format cl:nil "uint8 id~%#交通灯ID~%uint8 type~%#圆形1 左转2 直行3 右转4 左转掉头5 掉头6~%uint8 status~%#红1 绿2 黄3~%uint8 time~%#当前状态倒数数字~%float32 confidence~%#置信度~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <TrafficLight>))
  (cl:+ 0
     1
     1
     1
     1
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <TrafficLight>))
  "Converts a ROS message object to a list"
  (cl:list 'TrafficLight
    (cl:cons ':id (id msg))
    (cl:cons ':type (type msg))
    (cl:cons ':status (status msg))
    (cl:cons ':time (time msg))
    (cl:cons ':confidence (confidence msg))
))
