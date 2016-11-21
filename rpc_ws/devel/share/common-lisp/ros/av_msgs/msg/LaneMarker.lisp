; Auto-generated. Do not edit!


(cl:in-package av_msgs-msg)


;//! \htmlinclude LaneMarker.msg.html

(cl:defclass <LaneMarker> (roslisp-msg-protocol:ros-message)
  ((paint_type
    :reader paint_type
    :initarg :paint_type
    :type cl:fixnum
    :initform 0)
   (waypoints
    :reader waypoints
    :initarg :waypoints
    :type (cl:vector av_msgs-msg:WayPoint)
   :initform (cl:make-array 0 :element-type 'av_msgs-msg:WayPoint :initial-element (cl:make-instance 'av_msgs-msg:WayPoint))))
)

(cl:defclass LaneMarker (<LaneMarker>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <LaneMarker>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'LaneMarker)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name av_msgs-msg:<LaneMarker> is deprecated: use av_msgs-msg:LaneMarker instead.")))

(cl:ensure-generic-function 'paint_type-val :lambda-list '(m))
(cl:defmethod paint_type-val ((m <LaneMarker>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:paint_type-val is deprecated.  Use av_msgs-msg:paint_type instead.")
  (paint_type m))

(cl:ensure-generic-function 'waypoints-val :lambda-list '(m))
(cl:defmethod waypoints-val ((m <LaneMarker>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:waypoints-val is deprecated.  Use av_msgs-msg:waypoints instead.")
  (waypoints m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <LaneMarker>) ostream)
  "Serializes a message object of type '<LaneMarker>"
  (cl:let* ((signed (cl:slot-value msg 'paint_type)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'waypoints))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'waypoints))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <LaneMarker>) istream)
  "Deserializes a message object of type '<LaneMarker>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'paint_type) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'waypoints) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'waypoints)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'av_msgs-msg:WayPoint))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<LaneMarker>)))
  "Returns string type for a message object of type '<LaneMarker>"
  "av_msgs/LaneMarker")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'LaneMarker)))
  "Returns string type for a message object of type 'LaneMarker"
  "av_msgs/LaneMarker")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<LaneMarker>)))
  "Returns md5sum for a message object of type '<LaneMarker>"
  "ffcd1cee711ed2faf1d975c0f17d3c4a")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'LaneMarker)))
  "Returns md5sum for a message object of type 'LaneMarker"
  "ffcd1cee711ed2faf1d975c0f17d3c4a")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<LaneMarker>)))
  "Returns full string definition for message of type '<LaneMarker>"
  (cl:format cl:nil "#车道线类型~%int8 paint_type~%#车道线点序列~%WayPoint[] waypoints~%~%~%================================================================================~%MSG: av_msgs/WayPoint~%float64 x~%float64 y~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'LaneMarker)))
  "Returns full string definition for message of type 'LaneMarker"
  (cl:format cl:nil "#车道线类型~%int8 paint_type~%#车道线点序列~%WayPoint[] waypoints~%~%~%================================================================================~%MSG: av_msgs/WayPoint~%float64 x~%float64 y~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <LaneMarker>))
  (cl:+ 0
     1
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'waypoints) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <LaneMarker>))
  "Converts a ROS message object to a list"
  (cl:list 'LaneMarker
    (cl:cons ':paint_type (paint_type msg))
    (cl:cons ':waypoints (waypoints msg))
))
