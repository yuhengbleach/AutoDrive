;; Auto-generated. Do not edit!


(when (boundp 'av_msgs::SectionList)
  (if (not (find-package "AV_MSGS"))
    (make-package "AV_MSGS"))
  (shadow 'SectionList (find-package "AV_MSGS")))
(unless (find-package "AV_MSGS::SECTIONLIST")
  (make-package "AV_MSGS::SECTIONLIST"))

(in-package "ROS")
;;//! \htmlinclude SectionList.msg.html


(defclass av_msgs::SectionList
  :super ros::object
  :slots (_lane_marker_list _section_type ))

(defmethod av_msgs::SectionList
  (:init
   (&key
    ((:lane_marker_list __lane_marker_list) (let (r) (dotimes (i 0) (push (instance av_msgs::LaneMarker :init) r)) r))
    ((:section_type __section_type) 0)
    )
   (send-super :init)
   (setq _lane_marker_list __lane_marker_list)
   (setq _section_type (round __section_type))
   self)
  (:lane_marker_list
   (&rest __lane_marker_list)
   (if (keywordp (car __lane_marker_list))
       (send* _lane_marker_list __lane_marker_list)
     (progn
       (if __lane_marker_list (setq _lane_marker_list (car __lane_marker_list)))
       _lane_marker_list)))
  (:section_type
   (&optional __section_type)
   (if __section_type (setq _section_type __section_type)) _section_type)
  (:serialization-length
   ()
   (+
    ;; av_msgs/LaneMarker[] _lane_marker_list
    (apply #'+ (send-all _lane_marker_list :serialization-length)) 4
    ;; int8 _section_type
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; av_msgs/LaneMarker[] _lane_marker_list
     (write-long (length _lane_marker_list) s)
     (dolist (elem _lane_marker_list)
       (send elem :serialize s)
       )
     ;; int8 _section_type
       (write-byte _section_type s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; av_msgs/LaneMarker[] _lane_marker_list
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _lane_marker_list (let (r) (dotimes (i n) (push (instance av_msgs::LaneMarker :init) r)) r))
     (dolist (elem- _lane_marker_list)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; int8 _section_type
     (setq _section_type (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _section_type 127) (setq _section_type (- _section_type 256)))
   ;;
   self)
  )

(setf (get av_msgs::SectionList :md5sum-) "1f46dda376e2a4428945ad2016aa2228")
(setf (get av_msgs::SectionList :datatype-) "av_msgs/SectionList")
(setf (get av_msgs::SectionList :definition-)
      "# SectionList
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
float64 y
")



(provide :av_msgs/SectionList "1f46dda376e2a4428945ad2016aa2228")


