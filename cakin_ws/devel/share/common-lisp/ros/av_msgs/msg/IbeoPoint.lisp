; Auto-generated. Do not edit!


(cl:in-package av_msgs-msg)


;//! \htmlinclude IbeoPoint.msg.html

(cl:defclass <IbeoPoint> (roslisp-msg-protocol:ros-message)
  ((device_id
    :reader device_id
    :initarg :device_id
    :type cl:fixnum
    :initform 0)
   (echo
    :reader echo
    :initarg :echo
    :type cl:fixnum
    :initform 0)
   (flags
    :reader flags
    :initarg :flags
    :type cl:fixnum
    :initform 0)
   (layer
    :reader layer
    :initarg :layer
    :type cl:fixnum
    :initform 0)
   (position_x
    :reader position_x
    :initarg :position_x
    :type cl:float
    :initform 0.0)
   (position_y
    :reader position_y
    :initarg :position_y
    :type cl:float
    :initform 0.0)
   (position_z
    :reader position_z
    :initarg :position_z
    :type cl:float
    :initform 0.0))
)

(cl:defclass IbeoPoint (<IbeoPoint>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <IbeoPoint>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'IbeoPoint)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name av_msgs-msg:<IbeoPoint> is deprecated: use av_msgs-msg:IbeoPoint instead.")))

(cl:ensure-generic-function 'device_id-val :lambda-list '(m))
(cl:defmethod device_id-val ((m <IbeoPoint>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:device_id-val is deprecated.  Use av_msgs-msg:device_id instead.")
  (device_id m))

(cl:ensure-generic-function 'echo-val :lambda-list '(m))
(cl:defmethod echo-val ((m <IbeoPoint>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:echo-val is deprecated.  Use av_msgs-msg:echo instead.")
  (echo m))

(cl:ensure-generic-function 'flags-val :lambda-list '(m))
(cl:defmethod flags-val ((m <IbeoPoint>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:flags-val is deprecated.  Use av_msgs-msg:flags instead.")
  (flags m))

(cl:ensure-generic-function 'layer-val :lambda-list '(m))
(cl:defmethod layer-val ((m <IbeoPoint>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:layer-val is deprecated.  Use av_msgs-msg:layer instead.")
  (layer m))

(cl:ensure-generic-function 'position_x-val :lambda-list '(m))
(cl:defmethod position_x-val ((m <IbeoPoint>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:position_x-val is deprecated.  Use av_msgs-msg:position_x instead.")
  (position_x m))

(cl:ensure-generic-function 'position_y-val :lambda-list '(m))
(cl:defmethod position_y-val ((m <IbeoPoint>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:position_y-val is deprecated.  Use av_msgs-msg:position_y instead.")
  (position_y m))

(cl:ensure-generic-function 'position_z-val :lambda-list '(m))
(cl:defmethod position_z-val ((m <IbeoPoint>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:position_z-val is deprecated.  Use av_msgs-msg:position_z instead.")
  (position_z m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <IbeoPoint>) ostream)
  "Serializes a message object of type '<IbeoPoint>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'device_id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'echo)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'flags)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'flags)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'layer)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'position_x))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'position_y))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'position_z))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <IbeoPoint>) istream)
  "Deserializes a message object of type '<IbeoPoint>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'device_id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'echo)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'flags)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'flags)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'layer)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'position_x) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'position_y) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'position_z) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<IbeoPoint>)))
  "Returns string type for a message object of type '<IbeoPoint>"
  "av_msgs/IbeoPoint")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'IbeoPoint)))
  "Returns string type for a message object of type 'IbeoPoint"
  "av_msgs/IbeoPoint")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<IbeoPoint>)))
  "Returns md5sum for a message object of type '<IbeoPoint>"
  "9be76836bccda774e0c4ed9114e101d6")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'IbeoPoint)))
  "Returns md5sum for a message object of type 'IbeoPoint"
  "9be76836bccda774e0c4ed9114e101d6")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<IbeoPoint>)))
  "Returns full string definition for message of type '<IbeoPoint>"
  (cl:format cl:nil "uint8 device_id~%uint8 echo~%uint16 flags~%uint8 layer~%float32 position_x~%float32 position_y~%float32 position_z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'IbeoPoint)))
  "Returns full string definition for message of type 'IbeoPoint"
  (cl:format cl:nil "uint8 device_id~%uint8 echo~%uint16 flags~%uint8 layer~%float32 position_x~%float32 position_y~%float32 position_z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <IbeoPoint>))
  (cl:+ 0
     1
     1
     2
     1
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <IbeoPoint>))
  "Converts a ROS message object to a list"
  (cl:list 'IbeoPoint
    (cl:cons ':device_id (device_id msg))
    (cl:cons ':echo (echo msg))
    (cl:cons ':flags (flags msg))
    (cl:cons ':layer (layer msg))
    (cl:cons ':position_x (position_x msg))
    (cl:cons ':position_y (position_y msg))
    (cl:cons ':position_z (position_z msg))
))
