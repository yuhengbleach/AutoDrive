; Auto-generated. Do not edit!


(cl:in-package av_msgs-msg)


;//! \htmlinclude IbeoObjectList.msg.html

(cl:defclass <IbeoObjectList> (roslisp-msg-protocol:ros-message)
  ((timestamp
    :reader timestamp
    :initarg :timestamp
    :type cl:integer
    :initform 0)
   (ibeo_object_list
    :reader ibeo_object_list
    :initarg :ibeo_object_list
    :type (cl:vector av_msgs-msg:IbeoObject)
   :initform (cl:make-array 0 :element-type 'av_msgs-msg:IbeoObject :initial-element (cl:make-instance 'av_msgs-msg:IbeoObject))))
)

(cl:defclass IbeoObjectList (<IbeoObjectList>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <IbeoObjectList>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'IbeoObjectList)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name av_msgs-msg:<IbeoObjectList> is deprecated: use av_msgs-msg:IbeoObjectList instead.")))

(cl:ensure-generic-function 'timestamp-val :lambda-list '(m))
(cl:defmethod timestamp-val ((m <IbeoObjectList>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:timestamp-val is deprecated.  Use av_msgs-msg:timestamp instead.")
  (timestamp m))

(cl:ensure-generic-function 'ibeo_object_list-val :lambda-list '(m))
(cl:defmethod ibeo_object_list-val ((m <IbeoObjectList>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:ibeo_object_list-val is deprecated.  Use av_msgs-msg:ibeo_object_list instead.")
  (ibeo_object_list m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <IbeoObjectList>) ostream)
  "Serializes a message object of type '<IbeoObjectList>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'timestamp)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'timestamp)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'timestamp)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'timestamp)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 32) (cl:slot-value msg 'timestamp)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 40) (cl:slot-value msg 'timestamp)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 48) (cl:slot-value msg 'timestamp)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 56) (cl:slot-value msg 'timestamp)) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'ibeo_object_list))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'ibeo_object_list))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <IbeoObjectList>) istream)
  "Deserializes a message object of type '<IbeoObjectList>"
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
  (cl:setf (cl:slot-value msg 'ibeo_object_list) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'ibeo_object_list)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'av_msgs-msg:IbeoObject))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<IbeoObjectList>)))
  "Returns string type for a message object of type '<IbeoObjectList>"
  "av_msgs/IbeoObjectList")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'IbeoObjectList)))
  "Returns string type for a message object of type 'IbeoObjectList"
  "av_msgs/IbeoObjectList")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<IbeoObjectList>)))
  "Returns md5sum for a message object of type '<IbeoObjectList>"
  "981f29f62d860aaf5829de1d977ef990")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'IbeoObjectList)))
  "Returns md5sum for a message object of type 'IbeoObjectList"
  "981f29f62d860aaf5829de1d977ef990")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<IbeoObjectList>)))
  "Returns full string definition for message of type '<IbeoObjectList>"
  (cl:format cl:nil "uint64 timestamp~%IbeoObject[] ibeo_object_list~%~%================================================================================~%MSG: av_msgs/IbeoObject~%uint16 object_id~%float32 object_box_center_x~%float32 object_box_center_y~%float32 object_box_length~%float32 object_box_width~%float32 object_box_orientation~%float32 relative_velocity_x~%float32 relative_velocity_y~%float32 relative_velocity_sigma_x~%float32 relative_velocity_sigma_y~%uint8 object_class~%float32 object_class_certainty~%float32 exist_measurement~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'IbeoObjectList)))
  "Returns full string definition for message of type 'IbeoObjectList"
  (cl:format cl:nil "uint64 timestamp~%IbeoObject[] ibeo_object_list~%~%================================================================================~%MSG: av_msgs/IbeoObject~%uint16 object_id~%float32 object_box_center_x~%float32 object_box_center_y~%float32 object_box_length~%float32 object_box_width~%float32 object_box_orientation~%float32 relative_velocity_x~%float32 relative_velocity_y~%float32 relative_velocity_sigma_x~%float32 relative_velocity_sigma_y~%uint8 object_class~%float32 object_class_certainty~%float32 exist_measurement~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <IbeoObjectList>))
  (cl:+ 0
     8
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'ibeo_object_list) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <IbeoObjectList>))
  "Converts a ROS message object to a list"
  (cl:list 'IbeoObjectList
    (cl:cons ':timestamp (timestamp msg))
    (cl:cons ':ibeo_object_list (ibeo_object_list msg))
))
