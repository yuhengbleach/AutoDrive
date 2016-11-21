; Auto-generated. Do not edit!


(cl:in-package av_msgs-msg)


;//! \htmlinclude SectionList.msg.html

(cl:defclass <SectionList> (roslisp-msg-protocol:ros-message)
  ((lane_marker_list
    :reader lane_marker_list
    :initarg :lane_marker_list
    :type (cl:vector av_msgs-msg:LaneMarker)
   :initform (cl:make-array 0 :element-type 'av_msgs-msg:LaneMarker :initial-element (cl:make-instance 'av_msgs-msg:LaneMarker)))
   (section_type
    :reader section_type
    :initarg :section_type
    :type cl:fixnum
    :initform 0))
)

(cl:defclass SectionList (<SectionList>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SectionList>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SectionList)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name av_msgs-msg:<SectionList> is deprecated: use av_msgs-msg:SectionList instead.")))

(cl:ensure-generic-function 'lane_marker_list-val :lambda-list '(m))
(cl:defmethod lane_marker_list-val ((m <SectionList>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:lane_marker_list-val is deprecated.  Use av_msgs-msg:lane_marker_list instead.")
  (lane_marker_list m))

(cl:ensure-generic-function 'section_type-val :lambda-list '(m))
(cl:defmethod section_type-val ((m <SectionList>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:section_type-val is deprecated.  Use av_msgs-msg:section_type instead.")
  (section_type m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SectionList>) ostream)
  "Serializes a message object of type '<SectionList>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'lane_marker_list))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'lane_marker_list))
  (cl:let* ((signed (cl:slot-value msg 'section_type)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SectionList>) istream)
  "Deserializes a message object of type '<SectionList>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'lane_marker_list) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'lane_marker_list)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'av_msgs-msg:LaneMarker))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'section_type) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SectionList>)))
  "Returns string type for a message object of type '<SectionList>"
  "av_msgs/SectionList")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SectionList)))
  "Returns string type for a message object of type 'SectionList"
  "av_msgs/SectionList")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SectionList>)))
  "Returns md5sum for a message object of type '<SectionList>"
  "1f46dda376e2a4428945ad2016aa2228")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SectionList)))
  "Returns md5sum for a message object of type 'SectionList"
  "1f46dda376e2a4428945ad2016aa2228")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SectionList>)))
  "Returns full string definition for message of type '<SectionList>"
  (cl:format cl:nil "# SectionList~%LaneMarker[] lane_marker_list~%# 0:curved 1:straight~%int8 section_type~%~%~%================================================================================~%MSG: av_msgs/LaneMarker~%#车道线类型~%int8 paint_type~%#车道线点序列~%WayPoint[] waypoints~%~%~%================================================================================~%MSG: av_msgs/WayPoint~%float64 x~%float64 y~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SectionList)))
  "Returns full string definition for message of type 'SectionList"
  (cl:format cl:nil "# SectionList~%LaneMarker[] lane_marker_list~%# 0:curved 1:straight~%int8 section_type~%~%~%================================================================================~%MSG: av_msgs/LaneMarker~%#车道线类型~%int8 paint_type~%#车道线点序列~%WayPoint[] waypoints~%~%~%================================================================================~%MSG: av_msgs/WayPoint~%float64 x~%float64 y~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SectionList>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'lane_marker_list) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SectionList>))
  "Converts a ROS message object to a list"
  (cl:list 'SectionList
    (cl:cons ':lane_marker_list (lane_marker_list msg))
    (cl:cons ':section_type (section_type msg))
))
