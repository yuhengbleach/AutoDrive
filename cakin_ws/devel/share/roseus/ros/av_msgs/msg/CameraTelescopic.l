;; Auto-generated. Do not edit!


(when (boundp 'av_msgs::CameraTelescopic)
  (if (not (find-package "AV_MSGS"))
    (make-package "AV_MSGS"))
  (shadow 'CameraTelescopic (find-package "AV_MSGS")))
(unless (find-package "AV_MSGS::CAMERATELESCOPIC")
  (make-package "AV_MSGS::CAMERATELESCOPIC"))

(in-package "ROS")
;;//! \htmlinclude CameraTelescopic.msg.html
(if (not (find-package "SENSOR_MSGS"))
  (ros::roseus-add-msgs "sensor_msgs"))
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass av_msgs::CameraTelescopic
  :super ros::object
  :slots (_header _img_up ))

(defmethod av_msgs::CameraTelescopic
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:img_up __img_up) (instance sensor_msgs::Image :init))
    )
   (send-super :init)
   (setq _header __header)
   (setq _img_up __img_up)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:img_up
   (&rest __img_up)
   (if (keywordp (car __img_up))
       (send* _img_up __img_up)
     (progn
       (if __img_up (setq _img_up (car __img_up)))
       _img_up)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; sensor_msgs/Image _img_up
    (send _img_up :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; sensor_msgs/Image _img_up
       (send _img_up :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; sensor_msgs/Image _img_up
     (send _img_up :deserialize buf ptr-) (incf ptr- (send _img_up :serialization-length))
   ;;
   self)
  )

(setf (get av_msgs::CameraTelescopic :md5sum-) "2377dbfb1d7f0da98e845c57caac477d")
(setf (get av_msgs::CameraTelescopic :datatype-) "av_msgs/CameraTelescopic")
(setf (get av_msgs::CameraTelescopic :definition-)
      "std_msgs/Header header
sensor_msgs/Image img_up 
#长焦摄像头图像


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



(provide :av_msgs/CameraTelescopic "2377dbfb1d7f0da98e845c57caac477d")


