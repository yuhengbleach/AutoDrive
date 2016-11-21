;; Auto-generated. Do not edit!


(when (boundp 'av_msgs::LaneMarker)
  (if (not (find-package "AV_MSGS"))
    (make-package "AV_MSGS"))
  (shadow 'LaneMarker (find-package "AV_MSGS")))
(unless (find-package "AV_MSGS::LANEMARKER")
  (make-package "AV_MSGS::LANEMARKER"))

(in-package "ROS")
;;//! \htmlinclude LaneMarker.msg.html


(defclass av_msgs::LaneMarker
  :super ros::object
  :slots (_paint_type _waypoints ))

(defmethod av_msgs::LaneMarker
  (:init
   (&key
    ((:paint_type __paint_type) 0)
    ((:waypoints __waypoints) (let (r) (dotimes (i 0) (push (instance av_msgs::WayPoint :init) r)) r))
    )
   (send-super :init)
   (setq _paint_type (round __paint_type))
   (setq _waypoints __waypoints)
   self)
  (:paint_type
   (&optional __paint_type)
   (if __paint_type (setq _paint_type __paint_type)) _paint_type)
  (:waypoints
   (&rest __waypoints)
   (if (keywordp (car __waypoints))
       (send* _waypoints __waypoints)
     (progn
       (if __waypoints (setq _waypoints (car __waypoints)))
       _waypoints)))
  (:serialization-length
   ()
   (+
    ;; int8 _paint_type
    1
    ;; av_msgs/WayPoint[] _waypoints
    (apply #'+ (send-all _waypoints :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int8 _paint_type
       (write-byte _paint_type s)
     ;; av_msgs/WayPoint[] _waypoints
     (write-long (length _waypoints) s)
     (dolist (elem _waypoints)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int8 _paint_type
     (setq _paint_type (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _paint_type 127) (setq _paint_type (- _paint_type 256)))
   ;; av_msgs/WayPoint[] _waypoints
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _waypoints (let (r) (dotimes (i n) (push (instance av_msgs::WayPoint :init) r)) r))
     (dolist (elem- _waypoints)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get av_msgs::LaneMarker :md5sum-) "ffcd1cee711ed2faf1d975c0f17d3c4a")
(setf (get av_msgs::LaneMarker :datatype-) "av_msgs/LaneMarker")
(setf (get av_msgs::LaneMarker :definition-)
      "#车道线类型
int8 paint_type
#车道线点序列
WayPoint[] waypoints


================================================================================
MSG: av_msgs/WayPoint
float64 x
float64 y
")



(provide :av_msgs/LaneMarker "ffcd1cee711ed2faf1d975c0f17d3c4a")


