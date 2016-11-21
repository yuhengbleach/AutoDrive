; Auto-generated. Do not edit!


(cl:in-package av_msgs-srv)


;//! \htmlinclude getLocalLanemarkers-request.msg.html

(cl:defclass <getLocalLanemarkers-request> (roslisp-msg-protocol:ros-message)
  ((x
    :reader x
    :initarg :x
    :type cl:float
    :initform 0.0)
   (y
    :reader y
    :initarg :y
    :type cl:float
    :initform 0.0))
)

(cl:defclass getLocalLanemarkers-request (<getLocalLanemarkers-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <getLocalLanemarkers-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'getLocalLanemarkers-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name av_msgs-srv:<getLocalLanemarkers-request> is deprecated: use av_msgs-srv:getLocalLanemarkers-request instead.")))

(cl:ensure-generic-function 'x-val :lambda-list '(m))
(cl:defmethod x-val ((m <getLocalLanemarkers-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-srv:x-val is deprecated.  Use av_msgs-srv:x instead.")
  (x m))

(cl:ensure-generic-function 'y-val :lambda-list '(m))
(cl:defmethod y-val ((m <getLocalLanemarkers-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-srv:y-val is deprecated.  Use av_msgs-srv:y instead.")
  (y m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <getLocalLanemarkers-request>) ostream)
  "Serializes a message object of type '<getLocalLanemarkers-request>"
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'x))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'y))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <getLocalLanemarkers-request>) istream)
  "Deserializes a message object of type '<getLocalLanemarkers-request>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'x) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'y) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<getLocalLanemarkers-request>)))
  "Returns string type for a service object of type '<getLocalLanemarkers-request>"
  "av_msgs/getLocalLanemarkersRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'getLocalLanemarkers-request)))
  "Returns string type for a service object of type 'getLocalLanemarkers-request"
  "av_msgs/getLocalLanemarkersRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<getLocalLanemarkers-request>)))
  "Returns md5sum for a message object of type '<getLocalLanemarkers-request>"
  "a154757fc95dc3366fcef9af186dff3e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'getLocalLanemarkers-request)))
  "Returns md5sum for a message object of type 'getLocalLanemarkers-request"
  "a154757fc95dc3366fcef9af186dff3e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<getLocalLanemarkers-request>)))
  "Returns full string definition for message of type '<getLocalLanemarkers-request>"
  (cl:format cl:nil "float32 x~%float32 y~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'getLocalLanemarkers-request)))
  "Returns full string definition for message of type 'getLocalLanemarkers-request"
  (cl:format cl:nil "float32 x~%float32 y~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <getLocalLanemarkers-request>))
  (cl:+ 0
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <getLocalLanemarkers-request>))
  "Converts a ROS message object to a list"
  (cl:list 'getLocalLanemarkers-request
    (cl:cons ':x (x msg))
    (cl:cons ':y (y msg))
))
;//! \htmlinclude getLocalLanemarkers-response.msg.html

(cl:defclass <getLocalLanemarkers-response> (roslisp-msg-protocol:ros-message)
  ((section_list
    :reader section_list
    :initarg :section_list
    :type (cl:vector av_msgs-msg:SectionList)
   :initform (cl:make-array 0 :element-type 'av_msgs-msg:SectionList :initial-element (cl:make-instance 'av_msgs-msg:SectionList))))
)

(cl:defclass getLocalLanemarkers-response (<getLocalLanemarkers-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <getLocalLanemarkers-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'getLocalLanemarkers-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name av_msgs-srv:<getLocalLanemarkers-response> is deprecated: use av_msgs-srv:getLocalLanemarkers-response instead.")))

(cl:ensure-generic-function 'section_list-val :lambda-list '(m))
(cl:defmethod section_list-val ((m <getLocalLanemarkers-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-srv:section_list-val is deprecated.  Use av_msgs-srv:section_list instead.")
  (section_list m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <getLocalLanemarkers-response>) ostream)
  "Serializes a message object of type '<getLocalLanemarkers-response>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'section_list))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'section_list))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <getLocalLanemarkers-response>) istream)
  "Deserializes a message object of type '<getLocalLanemarkers-response>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'section_list) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'section_list)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'av_msgs-msg:SectionList))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<getLocalLanemarkers-response>)))
  "Returns string type for a service object of type '<getLocalLanemarkers-response>"
  "av_msgs/getLocalLanemarkersResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'getLocalLanemarkers-response)))
  "Returns string type for a service object of type 'getLocalLanemarkers-response"
  "av_msgs/getLocalLanemarkersResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<getLocalLanemarkers-response>)))
  "Returns md5sum for a message object of type '<getLocalLanemarkers-response>"
  "a154757fc95dc3366fcef9af186dff3e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'getLocalLanemarkers-response)))
  "Returns md5sum for a message object of type 'getLocalLanemarkers-response"
  "a154757fc95dc3366fcef9af186dff3e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<getLocalLanemarkers-response>)))
  "Returns full string definition for message of type '<getLocalLanemarkers-response>"
  (cl:format cl:nil "SectionList[] section_list~%~%~%================================================================================~%MSG: av_msgs/SectionList~%# SectionList~%LaneMarker[] lane_marker_list~%# 0:curved 1:straight~%int8 section_type~%~%~%================================================================================~%MSG: av_msgs/LaneMarker~%#车道线类型~%int8 paint_type~%#车道线点序列~%WayPoint[] waypoints~%~%~%================================================================================~%MSG: av_msgs/WayPoint~%float64 x~%float64 y~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'getLocalLanemarkers-response)))
  "Returns full string definition for message of type 'getLocalLanemarkers-response"
  (cl:format cl:nil "SectionList[] section_list~%~%~%================================================================================~%MSG: av_msgs/SectionList~%# SectionList~%LaneMarker[] lane_marker_list~%# 0:curved 1:straight~%int8 section_type~%~%~%================================================================================~%MSG: av_msgs/LaneMarker~%#车道线类型~%int8 paint_type~%#车道线点序列~%WayPoint[] waypoints~%~%~%================================================================================~%MSG: av_msgs/WayPoint~%float64 x~%float64 y~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <getLocalLanemarkers-response>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'section_list) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <getLocalLanemarkers-response>))
  "Converts a ROS message object to a list"
  (cl:list 'getLocalLanemarkers-response
    (cl:cons ':section_list (section_list msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'getLocalLanemarkers)))
  'getLocalLanemarkers-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'getLocalLanemarkers)))
  'getLocalLanemarkers-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'getLocalLanemarkers)))
  "Returns string type for a service object of type '<getLocalLanemarkers>"
  "av_msgs/getLocalLanemarkers")