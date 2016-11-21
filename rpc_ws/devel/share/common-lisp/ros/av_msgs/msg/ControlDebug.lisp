; Auto-generated. Do not edit!


(cl:in-package av_msgs-msg)


;//! \htmlinclude ControlDebug.msg.html

(cl:defclass <ControlDebug> (roslisp-msg-protocol:ros-message)
  ((desired_velocity
    :reader desired_velocity
    :initarg :desired_velocity
    :type cl:float
    :initform 0.0)
   (current_velocity
    :reader current_velocity
    :initarg :current_velocity
    :type cl:float
    :initform 0.0)
   (e_pose
    :reader e_pose
    :initarg :e_pose
    :type cl:float
    :initform 0.0)
   (e_angle
    :reader e_angle
    :initarg :e_angle
    :type cl:float
    :initform 0.0))
)

(cl:defclass ControlDebug (<ControlDebug>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ControlDebug>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ControlDebug)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name av_msgs-msg:<ControlDebug> is deprecated: use av_msgs-msg:ControlDebug instead.")))

(cl:ensure-generic-function 'desired_velocity-val :lambda-list '(m))
(cl:defmethod desired_velocity-val ((m <ControlDebug>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:desired_velocity-val is deprecated.  Use av_msgs-msg:desired_velocity instead.")
  (desired_velocity m))

(cl:ensure-generic-function 'current_velocity-val :lambda-list '(m))
(cl:defmethod current_velocity-val ((m <ControlDebug>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:current_velocity-val is deprecated.  Use av_msgs-msg:current_velocity instead.")
  (current_velocity m))

(cl:ensure-generic-function 'e_pose-val :lambda-list '(m))
(cl:defmethod e_pose-val ((m <ControlDebug>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:e_pose-val is deprecated.  Use av_msgs-msg:e_pose instead.")
  (e_pose m))

(cl:ensure-generic-function 'e_angle-val :lambda-list '(m))
(cl:defmethod e_angle-val ((m <ControlDebug>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:e_angle-val is deprecated.  Use av_msgs-msg:e_angle instead.")
  (e_angle m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ControlDebug>) ostream)
  "Serializes a message object of type '<ControlDebug>"
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'desired_velocity))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'current_velocity))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'e_pose))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'e_angle))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ControlDebug>) istream)
  "Deserializes a message object of type '<ControlDebug>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'desired_velocity) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'current_velocity) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'e_pose) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'e_angle) (roslisp-utils:decode-double-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ControlDebug>)))
  "Returns string type for a message object of type '<ControlDebug>"
  "av_msgs/ControlDebug")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ControlDebug)))
  "Returns string type for a message object of type 'ControlDebug"
  "av_msgs/ControlDebug")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ControlDebug>)))
  "Returns md5sum for a message object of type '<ControlDebug>"
  "7d5523c0fa27208129ad6a5de3491e13")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ControlDebug)))
  "Returns md5sum for a message object of type 'ControlDebug"
  "7d5523c0fa27208129ad6a5de3491e13")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ControlDebug>)))
  "Returns full string definition for message of type '<ControlDebug>"
  (cl:format cl:nil "#longitudinal~%float64 desired_velocity~%float64 current_velocity~%~%#lateral ~%float64 e_pose~%float64 e_angle~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ControlDebug)))
  "Returns full string definition for message of type 'ControlDebug"
  (cl:format cl:nil "#longitudinal~%float64 desired_velocity~%float64 current_velocity~%~%#lateral ~%float64 e_pose~%float64 e_angle~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ControlDebug>))
  (cl:+ 0
     8
     8
     8
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ControlDebug>))
  "Converts a ROS message object to a list"
  (cl:list 'ControlDebug
    (cl:cons ':desired_velocity (desired_velocity msg))
    (cl:cons ':current_velocity (current_velocity msg))
    (cl:cons ':e_pose (e_pose msg))
    (cl:cons ':e_angle (e_angle msg))
))
