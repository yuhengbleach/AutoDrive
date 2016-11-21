; Auto-generated. Do not edit!


(cl:in-package av_msgs-msg)


;//! \htmlinclude ControlSignal.msg.html

(cl:defclass <ControlSignal> (roslisp-msg-protocol:ros-message)
  ((acc_pedal_pos
    :reader acc_pedal_pos
    :initarg :acc_pedal_pos
    :type cl:float
    :initform 0.0)
   (brake_pedal_pos
    :reader brake_pedal_pos
    :initarg :brake_pedal_pos
    :type cl:float
    :initform 0.0)
   (steering_angle
    :reader steering_angle
    :initarg :steering_angle
    :type cl:float
    :initform 0.0))
)

(cl:defclass ControlSignal (<ControlSignal>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ControlSignal>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ControlSignal)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name av_msgs-msg:<ControlSignal> is deprecated: use av_msgs-msg:ControlSignal instead.")))

(cl:ensure-generic-function 'acc_pedal_pos-val :lambda-list '(m))
(cl:defmethod acc_pedal_pos-val ((m <ControlSignal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:acc_pedal_pos-val is deprecated.  Use av_msgs-msg:acc_pedal_pos instead.")
  (acc_pedal_pos m))

(cl:ensure-generic-function 'brake_pedal_pos-val :lambda-list '(m))
(cl:defmethod brake_pedal_pos-val ((m <ControlSignal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:brake_pedal_pos-val is deprecated.  Use av_msgs-msg:brake_pedal_pos instead.")
  (brake_pedal_pos m))

(cl:ensure-generic-function 'steering_angle-val :lambda-list '(m))
(cl:defmethod steering_angle-val ((m <ControlSignal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:steering_angle-val is deprecated.  Use av_msgs-msg:steering_angle instead.")
  (steering_angle m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ControlSignal>) ostream)
  "Serializes a message object of type '<ControlSignal>"
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'acc_pedal_pos))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'brake_pedal_pos))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'steering_angle))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ControlSignal>) istream)
  "Deserializes a message object of type '<ControlSignal>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'acc_pedal_pos) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'brake_pedal_pos) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'steering_angle) (roslisp-utils:decode-double-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ControlSignal>)))
  "Returns string type for a message object of type '<ControlSignal>"
  "av_msgs/ControlSignal")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ControlSignal)))
  "Returns string type for a message object of type 'ControlSignal"
  "av_msgs/ControlSignal")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ControlSignal>)))
  "Returns md5sum for a message object of type '<ControlSignal>"
  "380757b3e6e5a38260032bb0b5a75882")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ControlSignal)))
  "Returns md5sum for a message object of type 'ControlSignal"
  "380757b3e6e5a38260032bb0b5a75882")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ControlSignal>)))
  "Returns full string definition for message of type '<ControlSignal>"
  (cl:format cl:nil "float64 acc_pedal_pos~%float64 brake_pedal_pos~%float64 steering_angle~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ControlSignal)))
  "Returns full string definition for message of type 'ControlSignal"
  (cl:format cl:nil "float64 acc_pedal_pos~%float64 brake_pedal_pos~%float64 steering_angle~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ControlSignal>))
  (cl:+ 0
     8
     8
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ControlSignal>))
  "Converts a ROS message object to a list"
  (cl:list 'ControlSignal
    (cl:cons ':acc_pedal_pos (acc_pedal_pos msg))
    (cl:cons ':brake_pedal_pos (brake_pedal_pos msg))
    (cl:cons ':steering_angle (steering_angle msg))
))
