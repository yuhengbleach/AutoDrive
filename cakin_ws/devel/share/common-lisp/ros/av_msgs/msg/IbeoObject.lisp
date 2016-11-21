; Auto-generated. Do not edit!


(cl:in-package av_msgs-msg)


;//! \htmlinclude IbeoObject.msg.html

(cl:defclass <IbeoObject> (roslisp-msg-protocol:ros-message)
  ((object_id
    :reader object_id
    :initarg :object_id
    :type cl:fixnum
    :initform 0)
   (object_box_center_x
    :reader object_box_center_x
    :initarg :object_box_center_x
    :type cl:float
    :initform 0.0)
   (object_box_center_y
    :reader object_box_center_y
    :initarg :object_box_center_y
    :type cl:float
    :initform 0.0)
   (object_box_length
    :reader object_box_length
    :initarg :object_box_length
    :type cl:float
    :initform 0.0)
   (object_box_width
    :reader object_box_width
    :initarg :object_box_width
    :type cl:float
    :initform 0.0)
   (object_box_orientation
    :reader object_box_orientation
    :initarg :object_box_orientation
    :type cl:float
    :initform 0.0)
   (relative_velocity_x
    :reader relative_velocity_x
    :initarg :relative_velocity_x
    :type cl:float
    :initform 0.0)
   (relative_velocity_y
    :reader relative_velocity_y
    :initarg :relative_velocity_y
    :type cl:float
    :initform 0.0)
   (relative_velocity_sigma_x
    :reader relative_velocity_sigma_x
    :initarg :relative_velocity_sigma_x
    :type cl:float
    :initform 0.0)
   (relative_velocity_sigma_y
    :reader relative_velocity_sigma_y
    :initarg :relative_velocity_sigma_y
    :type cl:float
    :initform 0.0)
   (object_class
    :reader object_class
    :initarg :object_class
    :type cl:fixnum
    :initform 0)
   (object_class_certainty
    :reader object_class_certainty
    :initarg :object_class_certainty
    :type cl:float
    :initform 0.0)
   (exist_measurement
    :reader exist_measurement
    :initarg :exist_measurement
    :type cl:float
    :initform 0.0))
)

(cl:defclass IbeoObject (<IbeoObject>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <IbeoObject>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'IbeoObject)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name av_msgs-msg:<IbeoObject> is deprecated: use av_msgs-msg:IbeoObject instead.")))

(cl:ensure-generic-function 'object_id-val :lambda-list '(m))
(cl:defmethod object_id-val ((m <IbeoObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:object_id-val is deprecated.  Use av_msgs-msg:object_id instead.")
  (object_id m))

(cl:ensure-generic-function 'object_box_center_x-val :lambda-list '(m))
(cl:defmethod object_box_center_x-val ((m <IbeoObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:object_box_center_x-val is deprecated.  Use av_msgs-msg:object_box_center_x instead.")
  (object_box_center_x m))

(cl:ensure-generic-function 'object_box_center_y-val :lambda-list '(m))
(cl:defmethod object_box_center_y-val ((m <IbeoObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:object_box_center_y-val is deprecated.  Use av_msgs-msg:object_box_center_y instead.")
  (object_box_center_y m))

(cl:ensure-generic-function 'object_box_length-val :lambda-list '(m))
(cl:defmethod object_box_length-val ((m <IbeoObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:object_box_length-val is deprecated.  Use av_msgs-msg:object_box_length instead.")
  (object_box_length m))

(cl:ensure-generic-function 'object_box_width-val :lambda-list '(m))
(cl:defmethod object_box_width-val ((m <IbeoObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:object_box_width-val is deprecated.  Use av_msgs-msg:object_box_width instead.")
  (object_box_width m))

(cl:ensure-generic-function 'object_box_orientation-val :lambda-list '(m))
(cl:defmethod object_box_orientation-val ((m <IbeoObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:object_box_orientation-val is deprecated.  Use av_msgs-msg:object_box_orientation instead.")
  (object_box_orientation m))

(cl:ensure-generic-function 'relative_velocity_x-val :lambda-list '(m))
(cl:defmethod relative_velocity_x-val ((m <IbeoObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:relative_velocity_x-val is deprecated.  Use av_msgs-msg:relative_velocity_x instead.")
  (relative_velocity_x m))

(cl:ensure-generic-function 'relative_velocity_y-val :lambda-list '(m))
(cl:defmethod relative_velocity_y-val ((m <IbeoObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:relative_velocity_y-val is deprecated.  Use av_msgs-msg:relative_velocity_y instead.")
  (relative_velocity_y m))

(cl:ensure-generic-function 'relative_velocity_sigma_x-val :lambda-list '(m))
(cl:defmethod relative_velocity_sigma_x-val ((m <IbeoObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:relative_velocity_sigma_x-val is deprecated.  Use av_msgs-msg:relative_velocity_sigma_x instead.")
  (relative_velocity_sigma_x m))

(cl:ensure-generic-function 'relative_velocity_sigma_y-val :lambda-list '(m))
(cl:defmethod relative_velocity_sigma_y-val ((m <IbeoObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:relative_velocity_sigma_y-val is deprecated.  Use av_msgs-msg:relative_velocity_sigma_y instead.")
  (relative_velocity_sigma_y m))

(cl:ensure-generic-function 'object_class-val :lambda-list '(m))
(cl:defmethod object_class-val ((m <IbeoObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:object_class-val is deprecated.  Use av_msgs-msg:object_class instead.")
  (object_class m))

(cl:ensure-generic-function 'object_class_certainty-val :lambda-list '(m))
(cl:defmethod object_class_certainty-val ((m <IbeoObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:object_class_certainty-val is deprecated.  Use av_msgs-msg:object_class_certainty instead.")
  (object_class_certainty m))

(cl:ensure-generic-function 'exist_measurement-val :lambda-list '(m))
(cl:defmethod exist_measurement-val ((m <IbeoObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:exist_measurement-val is deprecated.  Use av_msgs-msg:exist_measurement instead.")
  (exist_measurement m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <IbeoObject>) ostream)
  "Serializes a message object of type '<IbeoObject>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'object_id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'object_id)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'object_box_center_x))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'object_box_center_y))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'object_box_length))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'object_box_width))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'object_box_orientation))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'relative_velocity_x))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'relative_velocity_y))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'relative_velocity_sigma_x))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'relative_velocity_sigma_y))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'object_class)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'object_class_certainty))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'exist_measurement))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <IbeoObject>) istream)
  "Deserializes a message object of type '<IbeoObject>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'object_id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'object_id)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'object_box_center_x) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'object_box_center_y) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'object_box_length) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'object_box_width) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'object_box_orientation) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'relative_velocity_x) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'relative_velocity_y) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'relative_velocity_sigma_x) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'relative_velocity_sigma_y) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'object_class)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'object_class_certainty) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'exist_measurement) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<IbeoObject>)))
  "Returns string type for a message object of type '<IbeoObject>"
  "av_msgs/IbeoObject")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'IbeoObject)))
  "Returns string type for a message object of type 'IbeoObject"
  "av_msgs/IbeoObject")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<IbeoObject>)))
  "Returns md5sum for a message object of type '<IbeoObject>"
  "eeb943ae30859d40f26de4eba16114d0")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'IbeoObject)))
  "Returns md5sum for a message object of type 'IbeoObject"
  "eeb943ae30859d40f26de4eba16114d0")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<IbeoObject>)))
  "Returns full string definition for message of type '<IbeoObject>"
  (cl:format cl:nil "uint16 object_id~%float32 object_box_center_x~%float32 object_box_center_y~%float32 object_box_length~%float32 object_box_width~%float32 object_box_orientation~%float32 relative_velocity_x~%float32 relative_velocity_y~%float32 relative_velocity_sigma_x~%float32 relative_velocity_sigma_y~%uint8 object_class~%float32 object_class_certainty~%float32 exist_measurement~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'IbeoObject)))
  "Returns full string definition for message of type 'IbeoObject"
  (cl:format cl:nil "uint16 object_id~%float32 object_box_center_x~%float32 object_box_center_y~%float32 object_box_length~%float32 object_box_width~%float32 object_box_orientation~%float32 relative_velocity_x~%float32 relative_velocity_y~%float32 relative_velocity_sigma_x~%float32 relative_velocity_sigma_y~%uint8 object_class~%float32 object_class_certainty~%float32 exist_measurement~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <IbeoObject>))
  (cl:+ 0
     2
     4
     4
     4
     4
     4
     4
     4
     4
     4
     1
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <IbeoObject>))
  "Converts a ROS message object to a list"
  (cl:list 'IbeoObject
    (cl:cons ':object_id (object_id msg))
    (cl:cons ':object_box_center_x (object_box_center_x msg))
    (cl:cons ':object_box_center_y (object_box_center_y msg))
    (cl:cons ':object_box_length (object_box_length msg))
    (cl:cons ':object_box_width (object_box_width msg))
    (cl:cons ':object_box_orientation (object_box_orientation msg))
    (cl:cons ':relative_velocity_x (relative_velocity_x msg))
    (cl:cons ':relative_velocity_y (relative_velocity_y msg))
    (cl:cons ':relative_velocity_sigma_x (relative_velocity_sigma_x msg))
    (cl:cons ':relative_velocity_sigma_y (relative_velocity_sigma_y msg))
    (cl:cons ':object_class (object_class msg))
    (cl:cons ':object_class_certainty (object_class_certainty msg))
    (cl:cons ':exist_measurement (exist_measurement msg))
))
