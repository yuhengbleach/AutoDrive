;; Auto-generated. Do not edit!


(when (boundp 'av_msgs::RadarObjectList)
  (if (not (find-package "AV_MSGS"))
    (make-package "AV_MSGS"))
  (shadow 'RadarObjectList (find-package "AV_MSGS")))
(unless (find-package "AV_MSGS::RADAROBJECTLIST")
  (make-package "AV_MSGS::RADAROBJECTLIST"))

(in-package "ROS")
;;//! \htmlinclude RadarObjectList.msg.html


(defclass av_msgs::RadarObjectList
  :super ros::object
  :slots (_timestamp _flag _radar_object_list ))

(defmethod av_msgs::RadarObjectList
  (:init
   (&key
    ((:timestamp __timestamp) 0)
    ((:flag __flag) "")
    ((:radar_object_list __radar_object_list) (let (r) (dotimes (i 0) (push (instance av_msgs::RadarObject :init) r)) r))
    )
   (send-super :init)
   (setq _timestamp (round __timestamp))
   (setq _flag (string __flag))
   (setq _radar_object_list __radar_object_list)
   self)
  (:timestamp
   (&optional __timestamp)
   (if __timestamp (setq _timestamp __timestamp)) _timestamp)
  (:flag
   (&optional __flag)
   (if __flag (setq _flag __flag)) _flag)
  (:radar_object_list
   (&rest __radar_object_list)
   (if (keywordp (car __radar_object_list))
       (send* _radar_object_list __radar_object_list)
     (progn
       (if __radar_object_list (setq _radar_object_list (car __radar_object_list)))
       _radar_object_list)))
  (:serialization-length
   ()
   (+
    ;; uint64 _timestamp
    8
    ;; string _flag
    4 (length _flag)
    ;; av_msgs/RadarObject[] _radar_object_list
    (apply #'+ (send-all _radar_object_list :serialization-length)) 4
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
     ;; string _flag
       (write-long (length _flag) s) (princ _flag s)
     ;; av_msgs/RadarObject[] _radar_object_list
     (write-long (length _radar_object_list) s)
     (dolist (elem _radar_object_list)
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
   ;; string _flag
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _flag (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; av_msgs/RadarObject[] _radar_object_list
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _radar_object_list (let (r) (dotimes (i n) (push (instance av_msgs::RadarObject :init) r)) r))
     (dolist (elem- _radar_object_list)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get av_msgs::RadarObjectList :md5sum-) "c5193a6df61f3d5bda7cb7e3b05fb09f")
(setf (get av_msgs::RadarObjectList :datatype-) "av_msgs/RadarObjectList")
(setf (get av_msgs::RadarObjectList :definition-)
      "uint64 timestamp
string flag
RadarObject[] radar_object_list

================================================================================
MSG: av_msgs/RadarObject
uint64 id               # 物体ID

float32 range           # 物体的距离 0 到 204.7 m
float32 angle           # 物体的方向角 -51.2 to 51.1 deg
float32 velocity        # 物体的速度    -81.92 to 81.91 m/s
float32 accel           # 物体的加速度  -25.60 to 25.55 m/s/s
string msg


")



(provide :av_msgs/RadarObjectList "c5193a6df61f3d5bda7cb7e3b05fb09f")


