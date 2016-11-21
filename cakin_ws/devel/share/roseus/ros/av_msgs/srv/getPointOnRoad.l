;; Auto-generated. Do not edit!


(when (boundp 'av_msgs::getPointOnRoad)
  (if (not (find-package "AV_MSGS"))
    (make-package "AV_MSGS"))
  (shadow 'getPointOnRoad (find-package "AV_MSGS")))
(unless (find-package "AV_MSGS::GETPOINTONROAD")
  (make-package "AV_MSGS::GETPOINTONROAD"))
(unless (find-package "AV_MSGS::GETPOINTONROADREQUEST")
  (make-package "AV_MSGS::GETPOINTONROADREQUEST"))
(unless (find-package "AV_MSGS::GETPOINTONROADRESPONSE")
  (make-package "AV_MSGS::GETPOINTONROADRESPONSE"))

(in-package "ROS")





(defclass av_msgs::getPointOnRoadRequest
  :super ros::object
  :slots (_origin_x _origin_y _r _pose_point ))

(defmethod av_msgs::getPointOnRoadRequest
  (:init
   (&key
    ((:origin_x __origin_x) 0.0)
    ((:origin_y __origin_y) 0.0)
    ((:r __r) 0.0)
    ((:pose_point __pose_point) (let (r) (dotimes (i 0) (push (instance av_msgs::WayPoint :init) r)) r))
    )
   (send-super :init)
   (setq _origin_x (float __origin_x))
   (setq _origin_y (float __origin_y))
   (setq _r (float __r))
   (setq _pose_point __pose_point)
   self)
  (:origin_x
   (&optional __origin_x)
   (if __origin_x (setq _origin_x __origin_x)) _origin_x)
  (:origin_y
   (&optional __origin_y)
   (if __origin_y (setq _origin_y __origin_y)) _origin_y)
  (:r
   (&optional __r)
   (if __r (setq _r __r)) _r)
  (:pose_point
   (&rest __pose_point)
   (if (keywordp (car __pose_point))
       (send* _pose_point __pose_point)
     (progn
       (if __pose_point (setq _pose_point (car __pose_point)))
       _pose_point)))
  (:serialization-length
   ()
   (+
    ;; float64 _origin_x
    8
    ;; float64 _origin_y
    8
    ;; float64 _r
    8
    ;; av_msgs/WayPoint[] _pose_point
    (apply #'+ (send-all _pose_point :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _origin_x
       (sys::poke _origin_x (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _origin_y
       (sys::poke _origin_y (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _r
       (sys::poke _r (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; av_msgs/WayPoint[] _pose_point
     (write-long (length _pose_point) s)
     (dolist (elem _pose_point)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _origin_x
     (setq _origin_x (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _origin_y
     (setq _origin_y (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _r
     (setq _r (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; av_msgs/WayPoint[] _pose_point
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _pose_point (let (r) (dotimes (i n) (push (instance av_msgs::WayPoint :init) r)) r))
     (dolist (elem- _pose_point)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(defclass av_msgs::getPointOnRoadResponse
  :super ros::object
  :slots (_result ))

(defmethod av_msgs::getPointOnRoadResponse
  (:init
   (&key
    ((:result __result) (let (r) (dotimes (i 0) (push nil r)) r))
    )
   (send-super :init)
   (setq _result __result)
   self)
  (:result
   (&optional __result)
   (if __result (setq _result __result)) _result)
  (:serialization-length
   ()
   (+
    ;; bool[] _result
    (* 1    (length _result)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool[] _result
     (write-long (length _result) s)
     (dotimes (i (length _result))
       (if (elt _result i) (write-byte -1 s) (write-byte 0 s))
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool[] _result
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _result (make-list n))
     (dotimes (i n)
     (setf (elt _result i) (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
     ))
   ;;
   self)
  )

(defclass av_msgs::getPointOnRoad
  :super ros::object
  :slots ())

(setf (get av_msgs::getPointOnRoad :md5sum-) "738f40f3eff47b68be9fc103c5b62eb4")
(setf (get av_msgs::getPointOnRoad :datatype-) "av_msgs/getPointOnRoad")
(setf (get av_msgs::getPointOnRoad :request) av_msgs::getPointOnRoadRequest)
(setf (get av_msgs::getPointOnRoad :response) av_msgs::getPointOnRoadResponse)

(defmethod av_msgs::getPointOnRoadRequest
  (:response () (instance av_msgs::getPointOnRoadResponse :init)))

(setf (get av_msgs::getPointOnRoadRequest :md5sum-) "738f40f3eff47b68be9fc103c5b62eb4")
(setf (get av_msgs::getPointOnRoadRequest :datatype-) "av_msgs/getPointOnRoadRequest")
(setf (get av_msgs::getPointOnRoadRequest :definition-)
      "float64 origin_x
float64 origin_y
float64 r
WayPoint[] pose_point

================================================================================
MSG: av_msgs/WayPoint
float64 x
---
bool[] result

")

(setf (get av_msgs::getPointOnRoadResponse :md5sum-) "738f40f3eff47b68be9fc103c5b62eb4")
(setf (get av_msgs::getPointOnRoadResponse :datatype-) "av_msgs/getPointOnRoadResponse")
(setf (get av_msgs::getPointOnRoadResponse :definition-)
      "float64 origin_x
float64 origin_y
float64 r
WayPoint[] pose_point

================================================================================
MSG: av_msgs/WayPoint
float64 x
---
bool[] result

")



(provide :av_msgs/getPointOnRoad "738f40f3eff47b68be9fc103c5b62eb4")


