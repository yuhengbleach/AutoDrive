;; Auto-generated. Do not edit!


(when (boundp 'av_msgs::TrafficLightMapData)
  (if (not (find-package "AV_MSGS"))
    (make-package "AV_MSGS"))
  (shadow 'TrafficLightMapData (find-package "AV_MSGS")))
(unless (find-package "AV_MSGS::TRAFFICLIGHTMAPDATA")
  (make-package "AV_MSGS::TRAFFICLIGHTMAPDATA"))

(in-package "ROS")
;;//! \htmlinclude TrafficLightMapData.msg.html


(defclass av_msgs::TrafficLightMapData
  :super ros::object
  :slots (_tl_map_list ))

(defmethod av_msgs::TrafficLightMapData
  (:init
   (&key
    ((:tl_map_list __tl_map_list) (let (r) (dotimes (i 0) (push (instance av_msgs::TrafficLightLoc :init) r)) r))
    )
   (send-super :init)
   (setq _tl_map_list __tl_map_list)
   self)
  (:tl_map_list
   (&rest __tl_map_list)
   (if (keywordp (car __tl_map_list))
       (send* _tl_map_list __tl_map_list)
     (progn
       (if __tl_map_list (setq _tl_map_list (car __tl_map_list)))
       _tl_map_list)))
  (:serialization-length
   ()
   (+
    ;; av_msgs/TrafficLightLoc[] _tl_map_list
    (apply #'+ (send-all _tl_map_list :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; av_msgs/TrafficLightLoc[] _tl_map_list
     (write-long (length _tl_map_list) s)
     (dolist (elem _tl_map_list)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; av_msgs/TrafficLightLoc[] _tl_map_list
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _tl_map_list (let (r) (dotimes (i n) (push (instance av_msgs::TrafficLightLoc :init) r)) r))
     (dolist (elem- _tl_map_list)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get av_msgs::TrafficLightMapData :md5sum-) "b4a02ab3c37e7cabb4dd223f9294396e")
(setf (get av_msgs::TrafficLightMapData :datatype-) "av_msgs/TrafficLightMapData")
(setf (get av_msgs::TrafficLightMapData :definition-)
      "TrafficLightLoc[] tl_map_list

================================================================================
MSG: av_msgs/TrafficLightLoc
float32 x
float32 y
float32 z

")



(provide :av_msgs/TrafficLightMapData "b4a02ab3c37e7cabb4dd223f9294396e")


