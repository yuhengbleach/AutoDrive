;; Auto-generated. Do not edit!


(when (boundp 'av_msgs::CameraBinocular)
  (if (not (find-package "AV_MSGS"))
    (make-package "AV_MSGS"))
  (shadow 'CameraBinocular (find-package "AV_MSGS")))
(unless (find-package "AV_MSGS::CAMERABINOCULAR")
  (make-package "AV_MSGS::CAMERABINOCULAR"))

(in-package "ROS")
;;//! \htmlinclude CameraBinocular.msg.html
(if (not (find-package "SENSOR_MSGS"))
  (ros::roseus-add-msgs "sensor_msgs"))
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass av_msgs::CameraBinocular
  :super ros::object
  :slots (_header _img_left _img_right ))

(defmethod av_msgs::CameraBinocular
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:img_left __img_left) (instance sensor_msgs::Image :init))
    ((:img_right __img_right) (instance sensor_msgs::Image :init))
    )
   (send-super :init)
   (setq _header __header)
   (setq _img_left __img_left)
   (setq _img_right __img_right)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:img_left
   (&rest __img_left)
   (if (keywordp (car __img_left))
       (send* _img_left __img_left)
     (progn
       (if __img_left (setq _img_left (car __img_left)))
       _img_left)))
  (:img_right
   (&rest __img_right)
   (if (keywordp (car __img_right))
       (send* _img_right __img_right)
     (progn
       (if __img_right (setq _img_right (car __img_right)))
       _img_right)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; sensor_msgs/Image _img_left
    (send _img_left :serialization-length)
    ;; sensor_msgs/Image _img_right
    (send _img_right :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; sensor_msgs/Image _img_left
       (send _img_left :serialize s)
     ;; sensor_msgs/Image _img_right
       (send _img_right :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; sensor_msgs/Image _img_left
     (send _img_left :deserialize buf ptr-) (incf ptr- (send _img_left :serialization-length))
   ;; sensor_msgs/Image _img_right
     (send _img_right :deserialize buf ptr-) (incf ptr- (send _img_right :serialization-length))
   ;;
   self)
  )

(setf (get av_msgs::CameraBinocular :md5sum-) "70b7e839a03a5e2d2c1d6da956f454b1")
(setf (get av_msgs::CameraBinocular :datatype-) "av_msgs/CameraBinocular")
(setf (get av_msgs::CameraBinocular :definition-)
      "std_msgs/Header header
sensor_msgs/Image img_left  
#双目摄像头左图像
sensor_msgs/Image img_right 
#双目摄像头右图像


================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
# 0: no frame
# 1: global frame
string frame_id

================================================================================
MSG: sensor_msgs/Image
# This message contains an uncompressed image
# (0, 0) is at top-left corner of image
#

Header header        # Header timestamp should be acquisition time of image
                     # Header frame_id should be optical frame of camera
                     # origin of frame should be optical center of cameara
                     # +x should point to the right in the image
                     # +y should point down in the image
                     # +z should point into to plane of the image
                     # If the frame_id here and the frame_id of the CameraInfo
                     # message associated with the image conflict
                     # the behavior is undefined

uint32 height         # image height, that is, number of rows
uint32 width          # image width, that is, number of columns

# The legal values for encoding are in file src/image_encodings.cpp
# If you want to standardize a new string format, join
# ros-users@lists.sourceforge.net and send an email proposing a new encoding.

string encoding       # Encoding of pixels -- channel meaning, ordering, size
                      # taken from the list of strings in include/sensor_msgs/image_encodings.h

uint8 is_bigendian    # is this data bigendian?
uint32 step           # Full row length in bytes
uint8[] data          # actual matrix data, size is (step * rows)

")



(provide :av_msgs/CameraBinocular "70b7e839a03a5e2d2c1d6da956f454b1")


