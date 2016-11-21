; Auto-generated. Do not edit!


(cl:in-package av_msgs-msg)


;//! \htmlinclude CameraVelodyneObjectList.msg.html

(cl:defclass <CameraVelodyneObjectList> (roslisp-msg-protocol:ros-message)
  ((timestamp
    :reader timestamp
    :initarg :timestamp
    :type cl:integer
    :initform 0)
   (camera_velodyne_object_list
    :reader camera_velodyne_object_list
    :initarg :camera_velodyne_object_list
    :type (cl:vector av_msgs-msg:Object3D)
   :initform (cl:make-array 0 :element-type 'av_msgs-msg:Object3D :initial-element (cl:make-instance 'av_msgs-msg:Object3D)))
   (width
    :reader width
    :initarg :width
    :type cl:integer
    :initform 0)
   (length
    :reader length
    :initarg :length
    :type cl:integer
    :initform 0)
   (center_x
    :reader center_x
    :initarg :center_x
    :type cl:integer
    :initform 0)
   (center_y
    :reader center_y
    :initarg :center_y
    :type cl:integer
    :initform 0)
   (grid_map
    :reader grid_map
    :initarg :grid_map
    :type (cl:vector cl:fixnum)
   :initform (cl:make-array 0 :element-type 'cl:fixnum :initial-element 0)))
)

(cl:defclass CameraVelodyneObjectList (<CameraVelodyneObjectList>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <CameraVelodyneObjectList>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'CameraVelodyneObjectList)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name av_msgs-msg:<CameraVelodyneObjectList> is deprecated: use av_msgs-msg:CameraVelodyneObjectList instead.")))

(cl:ensure-generic-function 'timestamp-val :lambda-list '(m))
(cl:defmethod timestamp-val ((m <CameraVelodyneObjectList>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:timestamp-val is deprecated.  Use av_msgs-msg:timestamp instead.")
  (timestamp m))

(cl:ensure-generic-function 'camera_velodyne_object_list-val :lambda-list '(m))
(cl:defmethod camera_velodyne_object_list-val ((m <CameraVelodyneObjectList>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:camera_velodyne_object_list-val is deprecated.  Use av_msgs-msg:camera_velodyne_object_list instead.")
  (camera_velodyne_object_list m))

(cl:ensure-generic-function 'width-val :lambda-list '(m))
(cl:defmethod width-val ((m <CameraVelodyneObjectList>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:width-val is deprecated.  Use av_msgs-msg:width instead.")
  (width m))

(cl:ensure-generic-function 'length-val :lambda-list '(m))
(cl:defmethod length-val ((m <CameraVelodyneObjectList>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:length-val is deprecated.  Use av_msgs-msg:length instead.")
  (length m))

(cl:ensure-generic-function 'center_x-val :lambda-list '(m))
(cl:defmethod center_x-val ((m <CameraVelodyneObjectList>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:center_x-val is deprecated.  Use av_msgs-msg:center_x instead.")
  (center_x m))

(cl:ensure-generic-function 'center_y-val :lambda-list '(m))
(cl:defmethod center_y-val ((m <CameraVelodyneObjectList>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:center_y-val is deprecated.  Use av_msgs-msg:center_y instead.")
  (center_y m))

(cl:ensure-generic-function 'grid_map-val :lambda-list '(m))
(cl:defmethod grid_map-val ((m <CameraVelodyneObjectList>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:grid_map-val is deprecated.  Use av_msgs-msg:grid_map instead.")
  (grid_map m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <CameraVelodyneObjectList>) ostream)
  "Serializes a message object of type '<CameraVelodyneObjectList>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'timestamp)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'timestamp)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'timestamp)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'timestamp)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 32) (cl:slot-value msg 'timestamp)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 40) (cl:slot-value msg 'timestamp)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 48) (cl:slot-value msg 'timestamp)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 56) (cl:slot-value msg 'timestamp)) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'camera_velodyne_object_list))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'camera_velodyne_object_list))
  (cl:let* ((signed (cl:slot-value msg 'width)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'length)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'center_x)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'center_y)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'grid_map))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:write-byte (cl:ldb (cl:byte 8 0) ele) ostream))
   (cl:slot-value msg 'grid_map))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <CameraVelodyneObjectList>) istream)
  "Deserializes a message object of type '<CameraVelodyneObjectList>"
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
  (cl:setf (cl:slot-value msg 'camera_velodyne_object_list) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'camera_velodyne_object_list)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'av_msgs-msg:Object3D))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'width) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'length) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'center_x) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'center_y) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'grid_map) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'grid_map)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:aref vals i)) (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<CameraVelodyneObjectList>)))
  "Returns string type for a message object of type '<CameraVelodyneObjectList>"
  "av_msgs/CameraVelodyneObjectList")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CameraVelodyneObjectList)))
  "Returns string type for a message object of type 'CameraVelodyneObjectList"
  "av_msgs/CameraVelodyneObjectList")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<CameraVelodyneObjectList>)))
  "Returns md5sum for a message object of type '<CameraVelodyneObjectList>"
  "00e3352e253ca731c1d5f90db8fe49fc")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'CameraVelodyneObjectList)))
  "Returns md5sum for a message object of type 'CameraVelodyneObjectList"
  "00e3352e253ca731c1d5f90db8fe49fc")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<CameraVelodyneObjectList>)))
  "Returns full string definition for message of type '<CameraVelodyneObjectList>"
  (cl:format cl:nil "uint64 timestamp~%Object3D[] camera_velodyne_object_list~%int32 width~%int32 length~%int32 center_x~%int32 center_y~%uint8[] grid_map~%~%================================================================================~%MSG: av_msgs/Object3D~%uint8 class_id~%float32 center_x~%float32 center_y~%float32 center_z~%float32 length~%float32 width~%float32 height~%float32 orient~%float32 confidence~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'CameraVelodyneObjectList)))
  "Returns full string definition for message of type 'CameraVelodyneObjectList"
  (cl:format cl:nil "uint64 timestamp~%Object3D[] camera_velodyne_object_list~%int32 width~%int32 length~%int32 center_x~%int32 center_y~%uint8[] grid_map~%~%================================================================================~%MSG: av_msgs/Object3D~%uint8 class_id~%float32 center_x~%float32 center_y~%float32 center_z~%float32 length~%float32 width~%float32 height~%float32 orient~%float32 confidence~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <CameraVelodyneObjectList>))
  (cl:+ 0
     8
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'camera_velodyne_object_list) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4
     4
     4
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'grid_map) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 1)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <CameraVelodyneObjectList>))
  "Converts a ROS message object to a list"
  (cl:list 'CameraVelodyneObjectList
    (cl:cons ':timestamp (timestamp msg))
    (cl:cons ':camera_velodyne_object_list (camera_velodyne_object_list msg))
    (cl:cons ':width (width msg))
    (cl:cons ':length (length msg))
    (cl:cons ':center_x (center_x msg))
    (cl:cons ':center_y (center_y msg))
    (cl:cons ':grid_map (grid_map msg))
))
