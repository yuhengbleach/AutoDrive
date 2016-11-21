;; Auto-generated. Do not edit!


(when (boundp 'av_msgs::RadarObject)
  (if (not (find-package "AV_MSGS"))
    (make-package "AV_MSGS"))
  (shadow 'RadarObject (find-package "AV_MSGS")))
(unless (find-package "AV_MSGS::RADAROBJECT")
  (make-package "AV_MSGS::RADAROBJECT"))

(in-package "ROS")
;;//! \htmlinclude RadarObject.msg.html


(defclass av_msgs::RadarObject
  :super ros::object
  :slots (_id _range _angle _velocity _accel _msg ))

(defmethod av_msgs::RadarObject
  (:init
   (&key
    ((:id __id) 0)
    ((:range __range) 0.0)
    ((:angle __angle) 0.0)
    ((:velocity __velocity) 0.0)
    ((:accel __accel) 0.0)
    ((:msg __msg) "")
    )
   (send-super :init)
   (setq _id (round __id))
   (setq _range (float __range))
   (setq _angle (float __angle))
   (setq _velocity (float __velocity))
   (setq _accel (float __accel))
   (setq _msg (string __msg))
   self)
  (:id
   (&optional __id)
   (if __id (setq _id __id)) _id)
  (:range
   (&optional __range)
   (if __range (setq _range __range)) _range)
  (:angle
   (&optional __angle)
   (if __angle (setq _angle __angle)) _angle)
  (:velocity
   (&optional __velocity)
   (if __velocity (setq _velocity __velocity)) _velocity)
  (:accel
   (&optional __accel)
   (if __accel (setq _accel __accel)) _accel)
  (:msg
   (&optional __msg)
   (if __msg (setq _msg __msg)) _msg)
  (:serialization-length
   ()
   (+
    ;; uint64 _id
    8
    ;; float32 _range
    4
    ;; float32 _angle
    4
    ;; float32 _velocity
    4
    ;; float32 _accel
    4
    ;; string _msg
    4 (length _msg)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint64 _id
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _id (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _id) (= (length (_id . bv)) 2)) ;; bignum
              (write-long (ash (elt (_id . bv) 0) 0) s)
              (write-long (ash (elt (_id . bv) 1) -1) s))
             ((and (class _id) (= (length (_id . bv)) 1)) ;; big1
              (write-long (elt (_id . bv) 0) s)
              (write-long (if (>= _id 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _id s)(write-long (if (>= _id 0) 0 #xffffffff) s)))
     ;; float32 _range
       (sys::poke _range (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _angle
       (sys::poke _angle (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _velocity
       (sys::poke _velocity (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _accel
       (sys::poke _accel (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; string _msg
       (write-long (length _msg) s) (princ _msg s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint64 _id
     
#+(or :alpha :irix6 :x86_64)
      (setf _id (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _id (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; float32 _range
     (setq _range (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _angle
     (setq _angle (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _velocity
     (setq _velocity (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _accel
     (setq _accel (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; string _msg
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _msg (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(setf (get av_msgs::RadarObject :md5sum-) "04d2359ae111a6d565942bf7ca37cffd")
(setf (get av_msgs::RadarObject :datatype-) "av_msgs/RadarObject")
(setf (get av_msgs::RadarObject :definition-)
      "uint64 id               # 物体ID

float32 range           # 物体的距离 0 到 204.7 m
float32 angle           # 物体的方向角 -51.2 to 51.1 deg
float32 velocity        # 物体的速度    -81.92 to 81.91 m/s
float32 accel           # 物体的加速度  -25.60 to 25.55 m/s/s
string msg


")



(provide :av_msgs/RadarObject "04d2359ae111a6d565942bf7ca37cffd")


