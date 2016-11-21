; Auto-generated. Do not edit!


(cl:in-package av_msgs-msg)


;//! \htmlinclude TrafficLightMapData.msg.html

(cl:defclass <TrafficLightMapData> (roslisp-msg-protocol:ros-message)
  ((tl_map_list
    :reader tl_map_list
    :initarg :tl_map_list
    :type (cl:vector av_msgs-msg:TrafficLightLoc)
   :initform (cl:make-array 0 :element-type 'av_msgs-msg:TrafficLightLoc :initial-element (cl:make-instance 'av_msgs-msg:TrafficLightLoc))))
)

(cl:defclass TrafficLightMapData (<TrafficLightMapData>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <TrafficLightMapData>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'TrafficLightMapData)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name av_msgs-msg:<TrafficLightMapData> is deprecated: use av_msgs-msg:TrafficLightMapData instead.")))

(cl:ensure-generic-function 'tl_map_list-val :lambda-list '(m))
(cl:defmethod tl_map_list-val ((m <TrafficLightMapData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:tl_map_list-val is deprecated.  Use av_msgs-msg:tl_map_list instead.")
  (tl_map_list m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <TrafficLightMapData>) ostream)
  "Serializes a message object of type '<TrafficLightMapData>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'tl_map_list))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'tl_map_list))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <TrafficLightMapData>) istream)
  "Deserializes a message object of type '<TrafficLightMapData>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'tl_map_list) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'tl_map_list)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'av_msgs-msg:TrafficLightLoc))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<TrafficLightMapData>)))
  "Returns string type for a message object of type '<TrafficLightMapData>"
  "av_msgs/TrafficLightMapData")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'TrafficLightMapData)))
  "Returns string type for a message object of type 'TrafficLightMapData"
  "av_msgs/TrafficLightMapData")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<TrafficLightMapData>)))
  "Returns md5sum for a message object of type '<TrafficLightMapData>"
  "b4a02ab3c37e7cabb4dd223f9294396e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'TrafficLightMapData)))
  "Returns md5sum for a message object of type 'TrafficLightMapData"
  "b4a02ab3c37e7cabb4dd223f9294396e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<TrafficLightMapData>)))
  "Returns full string definition for message of type '<TrafficLightMapData>"
  (cl:format cl:nil "TrafficLightLoc[] tl_map_list~%~%================================================================================~%MSG: av_msgs/TrafficLightLoc~%float32 x~%float32 y~%float32 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'TrafficLightMapData)))
  "Returns full string definition for message of type 'TrafficLightMapData"
  (cl:format cl:nil "TrafficLightLoc[] tl_map_list~%~%================================================================================~%MSG: av_msgs/TrafficLightLoc~%float32 x~%float32 y~%float32 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <TrafficLightMapData>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'tl_map_list) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <TrafficLightMapData>))
  "Converts a ROS message object to a list"
  (cl:list 'TrafficLightMapData
    (cl:cons ':tl_map_list (tl_map_list msg))
))
