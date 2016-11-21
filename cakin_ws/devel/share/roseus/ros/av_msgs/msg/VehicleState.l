;; Auto-generated. Do not edit!


(when (boundp 'av_msgs::VehicleState)
  (if (not (find-package "AV_MSGS"))
    (make-package "AV_MSGS"))
  (shadow 'VehicleState (find-package "AV_MSGS")))
(unless (find-package "AV_MSGS::VEHICLESTATE")
  (make-package "AV_MSGS::VEHICLESTATE"))

(in-package "ROS")
;;//! \htmlinclude VehicleState.msg.html


(defclass av_msgs::VehicleState
  :super ros::object
  :slots (_timestamp _x _y _ang _vel_x _vel_y _vel_ang _acc_x _acc_y _acc_ang _ref_curvature ))

(defmethod av_msgs::VehicleState
  (:init
   (&key
    ((:timestamp __timestamp) 0)
    ((:x __x) 0.0)
    ((:y __y) 0.0)
    ((:ang __ang) 0.0)
    ((:vel_x __vel_x) 0.0)
    ((:vel_y __vel_y) 0.0)
    ((:vel_ang __vel_ang) 0.0)
    ((:acc_x __acc_x) 0.0)
    ((:acc_y __acc_y) 0.0)
    ((:acc_ang __acc_ang) 0.0)
    ((:ref_curvature __ref_curvature) 0.0)
    )
   (send-super :init)
   (setq _timestamp (round __timestamp))
   (setq _x (float __x))
   (setq _y (float __y))
   (setq _ang (float __ang))
   (setq _vel_x (float __vel_x))
   (setq _vel_y (float __vel_y))
   (setq _vel_ang (float __vel_ang))
   (setq _acc_x (float __acc_x))
   (setq _acc_y (float __acc_y))
   (setq _acc_ang (float __acc_ang))
   (setq _ref_curvature (float __ref_curvature))
   self)
  (:timestamp
   (&optional __timestamp)
   (if __timestamp (setq _timestamp __timestamp)) _timestamp)
  (:x
   (&optional __x)
   (if __x (setq _x __x)) _x)
  (:y
   (&optional __y)
   (if __y (setq _y __y)) _y)
  (:ang
   (&optional __ang)
   (if __ang (setq _ang __ang)) _ang)
  (:vel_x
   (&optional __vel_x)
   (if __vel_x (setq _vel_x __vel_x)) _vel_x)
  (:vel_y
   (&optional __vel_y)
   (if __vel_y (setq _vel_y __vel_y)) _vel_y)
  (:vel_ang
   (&optional __vel_ang)
   (if __vel_ang (setq _vel_ang __vel_ang)) _vel_ang)
  (:acc_x
   (&optional __acc_x)
   (if __acc_x (setq _acc_x __acc_x)) _acc_x)
  (:acc_y
   (&optional __acc_y)
   (if __acc_y (setq _acc_y __acc_y)) _acc_y)
  (:acc_ang
   (&optional __acc_ang)
   (if __acc_ang (setq _acc_ang __acc_ang)) _acc_ang)
  (:ref_curvature
   (&optional __ref_curvature)
   (if __ref_curvature (setq _ref_curvature __ref_curvature)) _ref_curvature)
  (:serialization-length
   ()
   (+
    ;; uint64 _timestamp
    8
    ;; float64 _x
    8
    ;; float64 _y
    8
    ;; float64 _ang
    8
    ;; float64 _vel_x
    8
    ;; float64 _vel_y
    8
    ;; float64 _vel_ang
    8
    ;; float64 _acc_x
    8
    ;; float64 _acc_y
    8
    ;; float64 _acc_ang
    8
    ;; float64 _ref_curvature
    8
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
     ;; float64 _x
       (sys::poke _x (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _y
       (sys::poke _y (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _ang
       (sys::poke _ang (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _vel_x
       (sys::poke _vel_x (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _vel_y
       (sys::poke _vel_y (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _vel_ang
       (sys::poke _vel_ang (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _acc_x
       (sys::poke _acc_x (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _acc_y
       (sys::poke _acc_y (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _acc_ang
       (sys::poke _acc_ang (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _ref_curvature
       (sys::poke _ref_curvature (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
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
   ;; float64 _x
     (setq _x (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _y
     (setq _y (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _ang
     (setq _ang (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _vel_x
     (setq _vel_x (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _vel_y
     (setq _vel_y (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _vel_ang
     (setq _vel_ang (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _acc_x
     (setq _acc_x (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _acc_y
     (setq _acc_y (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _acc_ang
     (setq _acc_ang (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _ref_curvature
     (setq _ref_curvature (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get av_msgs::VehicleState :md5sum-) "cf167c65e8246be405f6d862a2d02a6d")
(setf (get av_msgs::VehicleState :datatype-) "av_msgs/VehicleState")
(setf (get av_msgs::VehicleState :definition-)
      "uint64 timestamp
float64 x
float64 y
float64 ang
float64 vel_x
float64 vel_y
float64 vel_ang
float64 acc_x
float64 acc_y
float64 acc_ang
float64 ref_curvature

")



(provide :av_msgs/VehicleState "cf167c65e8246be405f6d862a2d02a6d")


