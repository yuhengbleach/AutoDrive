; Auto-generated. Do not edit!


(cl:in-package av_msgs-msg)


;//! \htmlinclude RSDSObject.msg.html

(cl:defclass <RSDSObject> (roslisp-msg-protocol:ros-message)
  ((id
    :reader id
    :initarg :id
    :type cl:integer
    :initform 0)
   (x_pos
    :reader x_pos
    :initarg :x_pos
    :type cl:float
    :initform 0.0)
   (x_vel
    :reader x_vel
    :initarg :x_vel
    :type cl:float
    :initform 0.0)
   (x_acc
    :reader x_acc
    :initarg :x_acc
    :type cl:float
    :initform 0.0)
   (y_pos
    :reader y_pos
    :initarg :y_pos
    :type cl:float
    :initform 0.0)
   (y_vel
    :reader y_vel
    :initarg :y_vel
    :type cl:float
    :initform 0.0)
   (y_acc
    :reader y_acc
    :initarg :y_acc
    :type cl:float
    :initform 0.0)
   (tracker_status
    :reader tracker_status
    :initarg :tracker_status
    :type cl:integer
    :initform 0)
   (station_flags
    :reader station_flags
    :initarg :station_flags
    :type cl:integer
    :initform 0))
)

(cl:defclass RSDSObject (<RSDSObject>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <RSDSObject>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'RSDSObject)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name av_msgs-msg:<RSDSObject> is deprecated: use av_msgs-msg:RSDSObject instead.")))

(cl:ensure-generic-function 'id-val :lambda-list '(m))
(cl:defmethod id-val ((m <RSDSObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:id-val is deprecated.  Use av_msgs-msg:id instead.")
  (id m))

(cl:ensure-generic-function 'x_pos-val :lambda-list '(m))
(cl:defmethod x_pos-val ((m <RSDSObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:x_pos-val is deprecated.  Use av_msgs-msg:x_pos instead.")
  (x_pos m))

(cl:ensure-generic-function 'x_vel-val :lambda-list '(m))
(cl:defmethod x_vel-val ((m <RSDSObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:x_vel-val is deprecated.  Use av_msgs-msg:x_vel instead.")
  (x_vel m))

(cl:ensure-generic-function 'x_acc-val :lambda-list '(m))
(cl:defmethod x_acc-val ((m <RSDSObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:x_acc-val is deprecated.  Use av_msgs-msg:x_acc instead.")
  (x_acc m))

(cl:ensure-generic-function 'y_pos-val :lambda-list '(m))
(cl:defmethod y_pos-val ((m <RSDSObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:y_pos-val is deprecated.  Use av_msgs-msg:y_pos instead.")
  (y_pos m))

(cl:ensure-generic-function 'y_vel-val :lambda-list '(m))
(cl:defmethod y_vel-val ((m <RSDSObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:y_vel-val is deprecated.  Use av_msgs-msg:y_vel instead.")
  (y_vel m))

(cl:ensure-generic-function 'y_acc-val :lambda-list '(m))
(cl:defmethod y_acc-val ((m <RSDSObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:y_acc-val is deprecated.  Use av_msgs-msg:y_acc instead.")
  (y_acc m))

(cl:ensure-generic-function 'tracker_status-val :lambda-list '(m))
(cl:defmethod tracker_status-val ((m <RSDSObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:tracker_status-val is deprecated.  Use av_msgs-msg:tracker_status instead.")
  (tracker_status m))

(cl:ensure-generic-function 'station_flags-val :lambda-list '(m))
(cl:defmethod station_flags-val ((m <RSDSObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:station_flags-val is deprecated.  Use av_msgs-msg:station_flags instead.")
  (station_flags m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <RSDSObject>) ostream)
  "Serializes a message object of type '<RSDSObject>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 32) (cl:slot-value msg 'id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 40) (cl:slot-value msg 'id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 48) (cl:slot-value msg 'id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 56) (cl:slot-value msg 'id)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'x_pos))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'x_vel))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'x_acc))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'y_pos))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'y_vel))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'y_acc))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let* ((signed (cl:slot-value msg 'tracker_status)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'station_flags)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <RSDSObject>) istream)
  "Deserializes a message object of type '<RSDSObject>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 32) (cl:slot-value msg 'id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 40) (cl:slot-value msg 'id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 48) (cl:slot-value msg 'id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 56) (cl:slot-value msg 'id)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'x_pos) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'x_vel) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'x_acc) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'y_pos) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'y_vel) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'y_acc) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'tracker_status) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'station_flags) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<RSDSObject>)))
  "Returns string type for a message object of type '<RSDSObject>"
  "av_msgs/RSDSObject")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'RSDSObject)))
  "Returns string type for a message object of type 'RSDSObject"
  "av_msgs/RSDSObject")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<RSDSObject>)))
  "Returns md5sum for a message object of type '<RSDSObject>"
  "fc65ae1aba0b450ccf817515a12e2dd0")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'RSDSObject)))
  "Returns md5sum for a message object of type 'RSDSObject"
  "fc65ae1aba0b450ccf817515a12e2dd0")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<RSDSObject>)))
  "Returns full string definition for message of type '<RSDSObject>"
  (cl:format cl:nil "uint64 id # object id~%float32 x_pos ~%float32 x_vel~%float32 x_acc~%float32 y_pos~%float32 y_vel~%float32 y_acc~%int32 tracker_status~%int32 station_flags~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'RSDSObject)))
  "Returns full string definition for message of type 'RSDSObject"
  (cl:format cl:nil "uint64 id # object id~%float32 x_pos ~%float32 x_vel~%float32 x_acc~%float32 y_pos~%float32 y_vel~%float32 y_acc~%int32 tracker_status~%int32 station_flags~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <RSDSObject>))
  (cl:+ 0
     8
     4
     4
     4
     4
     4
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <RSDSObject>))
  "Converts a ROS message object to a list"
  (cl:list 'RSDSObject
    (cl:cons ':id (id msg))
    (cl:cons ':x_pos (x_pos msg))
    (cl:cons ':x_vel (x_vel msg))
    (cl:cons ':x_acc (x_acc msg))
    (cl:cons ':y_pos (y_pos msg))
    (cl:cons ':y_vel (y_vel msg))
    (cl:cons ':y_acc (y_acc msg))
    (cl:cons ':tracker_status (tracker_status msg))
    (cl:cons ':station_flags (station_flags msg))
))
