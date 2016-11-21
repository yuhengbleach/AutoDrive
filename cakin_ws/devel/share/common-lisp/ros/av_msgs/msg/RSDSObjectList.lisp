; Auto-generated. Do not edit!


(cl:in-package av_msgs-msg)


;//! \htmlinclude RSDSObjectList.msg.html

(cl:defclass <RSDSObjectList> (roslisp-msg-protocol:ros-message)
  ((timestamp
    :reader timestamp
    :initarg :timestamp
    :type cl:integer
    :initform 0)
   (radar_object_list
    :reader radar_object_list
    :initarg :radar_object_list
    :type (cl:vector av_msgs-msg:RSDSObject)
   :initform (cl:make-array 0 :element-type 'av_msgs-msg:RSDSObject :initial-element (cl:make-instance 'av_msgs-msg:RSDSObject)))
   (ori_msg
    :reader ori_msg
    :initarg :ori_msg
    :type (cl:vector cl:fixnum)
   :initform (cl:make-array 1240 :element-type 'cl:fixnum :initial-element 0)))
)

(cl:defclass RSDSObjectList (<RSDSObjectList>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <RSDSObjectList>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'RSDSObjectList)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name av_msgs-msg:<RSDSObjectList> is deprecated: use av_msgs-msg:RSDSObjectList instead.")))

(cl:ensure-generic-function 'timestamp-val :lambda-list '(m))
(cl:defmethod timestamp-val ((m <RSDSObjectList>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:timestamp-val is deprecated.  Use av_msgs-msg:timestamp instead.")
  (timestamp m))

(cl:ensure-generic-function 'radar_object_list-val :lambda-list '(m))
(cl:defmethod radar_object_list-val ((m <RSDSObjectList>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:radar_object_list-val is deprecated.  Use av_msgs-msg:radar_object_list instead.")
  (radar_object_list m))

(cl:ensure-generic-function 'ori_msg-val :lambda-list '(m))
(cl:defmethod ori_msg-val ((m <RSDSObjectList>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:ori_msg-val is deprecated.  Use av_msgs-msg:ori_msg instead.")
  (ori_msg m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <RSDSObjectList>) ostream)
  "Serializes a message object of type '<RSDSObjectList>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'timestamp)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'timestamp)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'timestamp)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'timestamp)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 32) (cl:slot-value msg 'timestamp)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 40) (cl:slot-value msg 'timestamp)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 48) (cl:slot-value msg 'timestamp)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 56) (cl:slot-value msg 'timestamp)) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'radar_object_list))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'radar_object_list))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:write-byte (cl:ldb (cl:byte 8 0) ele) ostream))
   (cl:slot-value msg 'ori_msg))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <RSDSObjectList>) istream)
  "Deserializes a message object of type '<RSDSObjectList>"
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
  (cl:setf (cl:slot-value msg 'radar_object_list) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'radar_object_list)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'av_msgs-msg:RSDSObject))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (cl:setf (cl:slot-value msg 'ori_msg) (cl:make-array 1240))
  (cl:let ((vals (cl:slot-value msg 'ori_msg)))
    (cl:dotimes (i 1240)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:aref vals i)) (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<RSDSObjectList>)))
  "Returns string type for a message object of type '<RSDSObjectList>"
  "av_msgs/RSDSObjectList")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'RSDSObjectList)))
  "Returns string type for a message object of type 'RSDSObjectList"
  "av_msgs/RSDSObjectList")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<RSDSObjectList>)))
  "Returns md5sum for a message object of type '<RSDSObjectList>"
  "7d986c7de0623b45f1b9ae898cef8ac3")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'RSDSObjectList)))
  "Returns md5sum for a message object of type 'RSDSObjectList"
  "7d986c7de0623b45f1b9ae898cef8ac3")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<RSDSObjectList>)))
  "Returns full string definition for message of type '<RSDSObjectList>"
  (cl:format cl:nil "uint64 timestamp~%RSDSObject[] radar_object_list~%uint8[1240] ori_msg~%~%================================================================================~%MSG: av_msgs/RSDSObject~%uint64 id # object id~%float32 x_pos ~%float32 x_vel~%float32 x_acc~%float32 y_pos~%float32 y_vel~%float32 y_acc~%int32 tracker_status~%int32 station_flags~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'RSDSObjectList)))
  "Returns full string definition for message of type 'RSDSObjectList"
  (cl:format cl:nil "uint64 timestamp~%RSDSObject[] radar_object_list~%uint8[1240] ori_msg~%~%================================================================================~%MSG: av_msgs/RSDSObject~%uint64 id # object id~%float32 x_pos ~%float32 x_vel~%float32 x_acc~%float32 y_pos~%float32 y_vel~%float32 y_acc~%int32 tracker_status~%int32 station_flags~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <RSDSObjectList>))
  (cl:+ 0
     8
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'radar_object_list) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'ori_msg) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 1)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <RSDSObjectList>))
  "Converts a ROS message object to a list"
  (cl:list 'RSDSObjectList
    (cl:cons ':timestamp (timestamp msg))
    (cl:cons ':radar_object_list (radar_object_list msg))
    (cl:cons ':ori_msg (ori_msg msg))
))
