; Auto-generated. Do not edit!


(cl:in-package av_msgs-srv)


;//! \htmlinclude getPointOnRoad-request.msg.html

(cl:defclass <getPointOnRoad-request> (roslisp-msg-protocol:ros-message)
  ((origin_x
    :reader origin_x
    :initarg :origin_x
    :type cl:float
    :initform 0.0)
   (origin_y
    :reader origin_y
    :initarg :origin_y
    :type cl:float
    :initform 0.0)
   (r
    :reader r
    :initarg :r
    :type cl:float
    :initform 0.0)
   (pose_point
    :reader pose_point
    :initarg :pose_point
    :type (cl:vector av_msgs-msg:WayPoint)
   :initform (cl:make-array 0 :element-type 'av_msgs-msg:WayPoint :initial-element (cl:make-instance 'av_msgs-msg:WayPoint))))
)

(cl:defclass getPointOnRoad-request (<getPointOnRoad-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <getPointOnRoad-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'getPointOnRoad-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name av_msgs-srv:<getPointOnRoad-request> is deprecated: use av_msgs-srv:getPointOnRoad-request instead.")))

(cl:ensure-generic-function 'origin_x-val :lambda-list '(m))
(cl:defmethod origin_x-val ((m <getPointOnRoad-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-srv:origin_x-val is deprecated.  Use av_msgs-srv:origin_x instead.")
  (origin_x m))

(cl:ensure-generic-function 'origin_y-val :lambda-list '(m))
(cl:defmethod origin_y-val ((m <getPointOnRoad-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-srv:origin_y-val is deprecated.  Use av_msgs-srv:origin_y instead.")
  (origin_y m))

(cl:ensure-generic-function 'r-val :lambda-list '(m))
(cl:defmethod r-val ((m <getPointOnRoad-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-srv:r-val is deprecated.  Use av_msgs-srv:r instead.")
  (r m))

(cl:ensure-generic-function 'pose_point-val :lambda-list '(m))
(cl:defmethod pose_point-val ((m <getPointOnRoad-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-srv:pose_point-val is deprecated.  Use av_msgs-srv:pose_point instead.")
  (pose_point m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <getPointOnRoad-request>) ostream)
  "Serializes a message object of type '<getPointOnRoad-request>"
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'origin_x))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'origin_y))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'r))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'pose_point))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'pose_point))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <getPointOnRoad-request>) istream)
  "Deserializes a message object of type '<getPointOnRoad-request>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'origin_x) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'origin_y) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'r) (roslisp-utils:decode-double-float-bits bits)))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'pose_point) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'pose_point)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'av_msgs-msg:WayPoint))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<getPointOnRoad-request>)))
  "Returns string type for a service object of type '<getPointOnRoad-request>"
  "av_msgs/getPointOnRoadRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'getPointOnRoad-request)))
  "Returns string type for a service object of type 'getPointOnRoad-request"
  "av_msgs/getPointOnRoadRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<getPointOnRoad-request>)))
  "Returns md5sum for a message object of type '<getPointOnRoad-request>"
  "738f40f3eff47b68be9fc103c5b62eb4")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'getPointOnRoad-request)))
  "Returns md5sum for a message object of type 'getPointOnRoad-request"
  "738f40f3eff47b68be9fc103c5b62eb4")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<getPointOnRoad-request>)))
  "Returns full string definition for message of type '<getPointOnRoad-request>"
  (cl:format cl:nil "float64 origin_x~%float64 origin_y~%float64 r~%WayPoint[] pose_point~%~%================================================================================~%MSG: av_msgs/WayPoint~%float64 x~%float64 y~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'getPointOnRoad-request)))
  "Returns full string definition for message of type 'getPointOnRoad-request"
  (cl:format cl:nil "float64 origin_x~%float64 origin_y~%float64 r~%WayPoint[] pose_point~%~%================================================================================~%MSG: av_msgs/WayPoint~%float64 x~%float64 y~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <getPointOnRoad-request>))
  (cl:+ 0
     8
     8
     8
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'pose_point) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <getPointOnRoad-request>))
  "Converts a ROS message object to a list"
  (cl:list 'getPointOnRoad-request
    (cl:cons ':origin_x (origin_x msg))
    (cl:cons ':origin_y (origin_y msg))
    (cl:cons ':r (r msg))
    (cl:cons ':pose_point (pose_point msg))
))
;//! \htmlinclude getPointOnRoad-response.msg.html

(cl:defclass <getPointOnRoad-response> (roslisp-msg-protocol:ros-message)
  ((result
    :reader result
    :initarg :result
    :type (cl:vector cl:boolean)
   :initform (cl:make-array 0 :element-type 'cl:boolean :initial-element cl:nil)))
)

(cl:defclass getPointOnRoad-response (<getPointOnRoad-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <getPointOnRoad-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'getPointOnRoad-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name av_msgs-srv:<getPointOnRoad-response> is deprecated: use av_msgs-srv:getPointOnRoad-response instead.")))

(cl:ensure-generic-function 'result-val :lambda-list '(m))
(cl:defmethod result-val ((m <getPointOnRoad-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-srv:result-val is deprecated.  Use av_msgs-srv:result instead.")
  (result m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <getPointOnRoad-response>) ostream)
  "Serializes a message object of type '<getPointOnRoad-response>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'result))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if ele 1 0)) ostream))
   (cl:slot-value msg 'result))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <getPointOnRoad-response>) istream)
  "Deserializes a message object of type '<getPointOnRoad-response>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'result) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'result)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:not (cl:zerop (cl:read-byte istream)))))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<getPointOnRoad-response>)))
  "Returns string type for a service object of type '<getPointOnRoad-response>"
  "av_msgs/getPointOnRoadResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'getPointOnRoad-response)))
  "Returns string type for a service object of type 'getPointOnRoad-response"
  "av_msgs/getPointOnRoadResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<getPointOnRoad-response>)))
  "Returns md5sum for a message object of type '<getPointOnRoad-response>"
  "738f40f3eff47b68be9fc103c5b62eb4")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'getPointOnRoad-response)))
  "Returns md5sum for a message object of type 'getPointOnRoad-response"
  "738f40f3eff47b68be9fc103c5b62eb4")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<getPointOnRoad-response>)))
  "Returns full string definition for message of type '<getPointOnRoad-response>"
  (cl:format cl:nil "bool[] result~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'getPointOnRoad-response)))
  "Returns full string definition for message of type 'getPointOnRoad-response"
  (cl:format cl:nil "bool[] result~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <getPointOnRoad-response>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'result) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 1)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <getPointOnRoad-response>))
  "Converts a ROS message object to a list"
  (cl:list 'getPointOnRoad-response
    (cl:cons ':result (result msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'getPointOnRoad)))
  'getPointOnRoad-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'getPointOnRoad)))
  'getPointOnRoad-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'getPointOnRoad)))
  "Returns string type for a service object of type '<getPointOnRoad>"
  "av_msgs/getPointOnRoad")