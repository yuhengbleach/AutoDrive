; Auto-generated. Do not edit!


(cl:in-package av_msgs-msg)


;//! \htmlinclude IbeoPointList.msg.html

(cl:defclass <IbeoPointList> (roslisp-msg-protocol:ros-message)
  ((timestamp
    :reader timestamp
    :initarg :timestamp
    :type cl:integer
    :initform 0)
   (ibeo_point_list
    :reader ibeo_point_list
    :initarg :ibeo_point_list
    :type (cl:vector av_msgs-msg:IbeoPoint)
   :initform (cl:make-array 0 :element-type 'av_msgs-msg:IbeoPoint :initial-element (cl:make-instance 'av_msgs-msg:IbeoPoint))))
)

(cl:defclass IbeoPointList (<IbeoPointList>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <IbeoPointList>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'IbeoPointList)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name av_msgs-msg:<IbeoPointList> is deprecated: use av_msgs-msg:IbeoPointList instead.")))

(cl:ensure-generic-function 'timestamp-val :lambda-list '(m))
(cl:defmethod timestamp-val ((m <IbeoPointList>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:timestamp-val is deprecated.  Use av_msgs-msg:timestamp instead.")
  (timestamp m))

(cl:ensure-generic-function 'ibeo_point_list-val :lambda-list '(m))
(cl:defmethod ibeo_point_list-val ((m <IbeoPointList>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:ibeo_point_list-val is deprecated.  Use av_msgs-msg:ibeo_point_list instead.")
  (ibeo_point_list m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <IbeoPointList>) ostream)
  "Serializes a message object of type '<IbeoPointList>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'timestamp)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'timestamp)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'timestamp)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'timestamp)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 32) (cl:slot-value msg 'timestamp)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 40) (cl:slot-value msg 'timestamp)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 48) (cl:slot-value msg 'timestamp)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 56) (cl:slot-value msg 'timestamp)) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'ibeo_point_list))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'ibeo_point_list))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <IbeoPointList>) istream)
  "Deserializes a message object of type '<IbeoPointList>"
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
  (cl:setf (cl:slot-value msg 'ibeo_point_list) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'ibeo_point_list)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'av_msgs-msg:IbeoPoint))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<IbeoPointList>)))
  "Returns string type for a message object of type '<IbeoPointList>"
  "av_msgs/IbeoPointList")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'IbeoPointList)))
  "Returns string type for a message object of type 'IbeoPointList"
  "av_msgs/IbeoPointList")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<IbeoPointList>)))
  "Returns md5sum for a message object of type '<IbeoPointList>"
  "5e8e53115c68cc8aab3056cdae033bf9")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'IbeoPointList)))
  "Returns md5sum for a message object of type 'IbeoPointList"
  "5e8e53115c68cc8aab3056cdae033bf9")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<IbeoPointList>)))
  "Returns full string definition for message of type '<IbeoPointList>"
  (cl:format cl:nil "uint64 timestamp~%IbeoPoint[] ibeo_point_list~%~%================================================================================~%MSG: av_msgs/IbeoPoint~%uint8 device_id~%uint8 echo~%uint16 flags~%uint8 layer~%float32 position_x~%float32 position_y~%float32 position_z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'IbeoPointList)))
  "Returns full string definition for message of type 'IbeoPointList"
  (cl:format cl:nil "uint64 timestamp~%IbeoPoint[] ibeo_point_list~%~%================================================================================~%MSG: av_msgs/IbeoPoint~%uint8 device_id~%uint8 echo~%uint16 flags~%uint8 layer~%float32 position_x~%float32 position_y~%float32 position_z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <IbeoPointList>))
  (cl:+ 0
     8
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'ibeo_point_list) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <IbeoPointList>))
  "Converts a ROS message object to a list"
  (cl:list 'IbeoPointList
    (cl:cons ':timestamp (timestamp msg))
    (cl:cons ':ibeo_point_list (ibeo_point_list msg))
))
