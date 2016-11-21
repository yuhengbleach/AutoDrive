;; Auto-generated. Do not edit!


(when (boundp 'av_msgs::TrafficLightDetect)
  (if (not (find-package "AV_MSGS"))
    (make-package "AV_MSGS"))
  (shadow 'TrafficLightDetect (find-package "AV_MSGS")))
(unless (find-package "AV_MSGS::TRAFFICLIGHTDETECT")
  (make-package "AV_MSGS::TRAFFICLIGHTDETECT"))

(in-package "ROS")
;;//! \htmlinclude TrafficLightDetect.msg.html


(defclass av_msgs::TrafficLightDetect
  :super ros::object
  :slots (_timestamp _tl_det_list ))

(defmethod av_msgs::TrafficLightDetect
  (:init
   (&key
    ((:timestamp __timestamp) 0)
    ((:tl_det_list __tl_det_list) (let (r) (dotimes (i 0) (push (instance av_msgs::TrafficLight :init) r)) r))
    )
   (send-super :init)
   (setq _timestamp (round __timestamp))
   (setq _tl_det_list __tl_det_list)
   self)
  (:timestamp
   (&optional __timestamp)
   (if __timestamp (setq _timestamp __timestamp)) _timestamp)
  (:tl_det_list
   (&rest __tl_det_list)
   (if (keywordp (car __tl_det_list))
       (send* _tl_det_list __tl_det_list)
     (progn
       (if __tl_det_list (setq _tl_det_list (car __tl_det_list)))
       _tl_det_list)))
  (:serialization-length
   ()
   (+
    ;; uint64 _timestamp
    8
    ;; av_msgs/TrafficLight[] _tl_det_list
    (apply #'+ (send-all _tl_det_list :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint64 _timestamp
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _timestamp (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _timestamp) (= (length (_timestamp . bv)) 2)) ;; bignum
              (write-long (ash (elt (_timestamp . bv) 0) 0) s)
              (write-long (ash (elt (_timestamp . bv) 1) -1) s))
             ((and (class _timestamp) (= (length (_timestamp . bv)) 1)) ;; big1
              (write-long (elt (_timestamp . bv) 0) s)
              (write-long (if (>= _timestamp 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _timestamp s)(write-long (if (>= _timestamp 0) 0 #xffffffff) s)))
     ;; av_msgs/TrafficLight[] _tl_det_list
     (write-long (length _tl_det_list) s)
     (dolist (elem _tl_det_list)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint64 _timestamp
     
#+(or :alpha :irix6 :x86_64)
      (setf _timestamp (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _timestamp (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; av_msgs/TrafficLight[] _tl_det_list
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _tl_det_list (let (r) (dotimes (i n) (push (instance av_msgs::TrafficLight :init) r)) r))
     (dolist (elem- _tl_det_list)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get av_msgs::TrafficLightDetect :md5sum-) "33316cd0fd07b9b668bdae386f00ea87")
(setf (get av_msgs::TrafficLightDetect :datatype-) "av_msgs/TrafficLightDetect")
(setf (get av_msgs::TrafficLightDetect :definition-)
      "uint64 timestamp
TrafficLight[]  tl_det_list

================================================================================
MSG: av_msgs/TrafficLight
uint8 id
#交通灯ID
uint8 type
#圆形1 左转2 直行3 右转4 左转掉头5 掉头6
uint8 status
#红1 绿2 黄3
uint8 time
#当前状态倒数数字
float32 confidence
#置信度

")



(provide :av_msgs/TrafficLightDetect "33316cd0fd07b9b668bdae386f00ea87")


