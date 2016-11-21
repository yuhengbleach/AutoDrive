;; Auto-generated. Do not edit!


(when (boundp 'av_msgs::getLocalLanemarkers)
  (if (not (find-package "AV_MSGS"))
    (make-package "AV_MSGS"))
  (shadow 'getLocalLanemarkers (find-package "AV_MSGS")))
(unless (find-package "AV_MSGS::GETLOCALLANEMARKERS")
  (make-package "AV_MSGS::GETLOCALLANEMARKERS"))
(unless (find-package "AV_MSGS::GETLOCALLANEMARKERSREQUEST")
  (make-package "AV_MSGS::GETLOCALLANEMARKERSREQUEST"))
(unless (find-package "AV_MSGS::GETLOCALLANEMARKERSRESPONSE")
  (make-package "AV_MSGS::GETLOCALLANEMARKERSRESPONSE"))

(in-package "ROS")





(defclass av_msgs::getLocalLanemarkersRequest
  :super ros::object
  :slots (_x _y ))

(defmethod av_msgs::getLocalLanemarkersRequest
  (:init
   (&key
    ((:x __x) 0.0)
    ((:y __y) 0.0)
    )
   (send-super :init)
   (setq _x (float __x))
   (setq _y (float __y))
   self)
  (:x
   (&optional __x)
   (if __x (setq _x __x)) _x)
  (:y
   (&optional __y)
   (if __y (setq _y __y)) _y)
  (:serialization-length
   ()
   (+
    ;; float32 _x
    4
    ;; float32 _y
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32 _x
       (sys::poke _x (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _y
       (sys::poke _y (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _x
     (setq _x (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _y
     (setq _y (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(defclass av_msgs::getLocalLanemarkersResponse
  :super ros::object
  :slots (_section_list ))

(defmethod av_msgs::getLocalLanemarkersResponse
  (:init
   (&key
    ((:section_list __section_list) (let (r) (dotimes (i 0) (push (instance av_msgs::SectionList :init) r)) r))
    )
   (send-super :init)
   (setq _section_list __section_list)
   self)
  (:section_list
   (&rest __section_list)
   (if (keywordp (car __section_list))
       (send* _section_list __section_list)
     (progn
       (if __section_list (setq _section_list (car __section_list)))
       _section_list)))
  (:serialization-length
   ()
   (+
    ;; av_msgs/SectionList[] _section_list
    (apply #'+ (send-all _section_list :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; av_msgs/SectionList[] _section_list
     (write-long (length _section_list) s)
     (dolist (elem _section_list)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; av_msgs/SectionList[] _section_list
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _section_list (let (r) (dotimes (i n) (push (instance av_msgs::SectionList :init) r)) r))
     (dolist (elem- _section_list)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(defclass av_msgs::getLocalLanemarkers
  :super ros::object
  :slots ())

(setf (get av_msgs::getLocalLanemarkers :md5sum-) "a154757fc95dc3366fcef9af186dff3e")
(setf (get av_msgs::getLocalLanemarkers :datatype-) "av_msgs/getLocalLanemarkers")
(setf (get av_msgs::getLocalLanemarkers :request) av_msgs::getLocalLanemarkersRequest)
(setf (get av_msgs::getLocalLanemarkers :response) av_msgs::getLocalLanemarkersResponse)

(defmethod av_msgs::getLocalLanemarkersRequest
  (:response () (instance av_msgs::getLocalLanemarkersResponse :init)))

(setf (get av_msgs::getLocalLanemarkersRequest :md5sum-) "a154757fc95dc3366fcef9af186dff3e")
(setf (get av_msgs::getLocalLanemarkersRequest :datatype-) "av_msgs/getLocalLanemarkersRequest")
(setf (get av_msgs::getLocalLanemarkersRequest :definition-)
      "float32 x
float32 y
---
SectionList[] section_list


================================================================================
MSG: av_msgs/SectionList
# SectionList
LaneMarker[] lane_marker_list
# 0:curved 1:straight
int8 section_type


================================================================================
MSG: av_msgs/LaneMarker
#车道线类型
int8 paint_type
#车道线点序列
WayPoint[] waypoints


================================================================================
MSG: av_msgs/WayPoint
float64 x
")

(setf (get av_msgs::getLocalLanemarkersResponse :md5sum-) "a154757fc95dc3366fcef9af186dff3e")
(setf (get av_msgs::getLocalLanemarkersResponse :datatype-) "av_msgs/getLocalLanemarkersResponse")
(setf (get av_msgs::getLocalLanemarkersResponse :definition-)
      "float32 x
float32 y
---
SectionList[] section_list


================================================================================
MSG: av_msgs/SectionList
# SectionList
LaneMarker[] lane_marker_list
# 0:curved 1:straight
int8 section_type


================================================================================
MSG: av_msgs/LaneMarker
#车道线类型
int8 paint_type
#车道线点序列
WayPoint[] waypoints


================================================================================
MSG: av_msgs/WayPoint
float64 x
")



(provide :av_msgs/getLocalLanemarkers "a154757fc95dc3366fcef9af186dff3e")


