;; Auto-generated. Do not edit!


(when (boundp 'av_msgs::DynamicObstacle)
  (if (not (find-package "AV_MSGS"))
    (make-package "AV_MSGS"))
  (shadow 'DynamicObstacle (find-package "AV_MSGS")))
(unless (find-package "AV_MSGS::DYNAMICOBSTACLE")
  (make-package "AV_MSGS::DYNAMICOBSTACLE"))

(in-package "ROS")
;;//! \htmlinclude DynamicObstacle.msg.html


(defclass av_msgs::DynamicObstacle
  :super ros::object
  :slots (_class_id _id _center_x _center_y _center_z _width _height _length _velocity _heading _omega _acceleration _shield_time _velocity_measurement_covariance ))

(defmethod av_msgs::DynamicObstacle
  (:init
   (&key
    ((:class_id __class_id) 0)
    ((:id __id) 0)
    ((:center_x __center_x) 0.0)
    ((:center_y __center_y) 0.0)
    ((:center_z __center_z) 0.0)
    ((:width __width) 0.0)
    ((:height __height) 0.0)
    ((:length __length) 0.0)
    ((:velocity __velocity) 0.0)
    ((:heading __heading) 0.0)
    ((:omega __omega) 0.0)
    ((:acceleration __acceleration) 0.0)
    ((:shield_time __shield_time) 0)
    ((:velocity_measurement_covariance __velocity_measurement_covariance) (make-array 0 :initial-element 0.0 :element-type :float))
    )
   (send-super :init)
   (setq _class_id (round __class_id))
   (setq _id (round __id))
   (setq _center_x (float __center_x))
   (setq _center_y (float __center_y))
   (setq _center_z (float __center_z))
   (setq _width (float __width))
   (setq _height (float __height))
   (setq _length (float __length))
   (setq _velocity (float __velocity))
   (setq _heading (float __heading))
   (setq _omega (float __omega))
   (setq _acceleration (float __acceleration))
   (setq _shield_time (round __shield_time))
   (setq _velocity_measurement_covariance __velocity_measurement_covariance)
   self)
  (:class_id
   (&optional __class_id)
   (if __class_id (setq _class_id __class_id)) _class_id)
  (:id
   (&optional __id)
   (if __id (setq _id __id)) _id)
  (:center_x
   (&optional __center_x)
   (if __center_x (setq _center_x __center_x)) _center_x)
  (:center_y
   (&optional __center_y)
   (if __center_y (setq _center_y __center_y)) _center_y)
  (:center_z
   (&optional __center_z)
   (if __center_z (setq _center_z __center_z)) _center_z)
  (:width
   (&optional __width)
   (if __width (setq _width __width)) _width)
  (:height
   (&optional __height)
   (if __height (setq _height __height)) _height)
  (:length
   (&optional __length)
   (if __length (setq _length __length)) _length)
  (:velocity
   (&optional __velocity)
   (if __velocity (setq _velocity __velocity)) _velocity)
  (:heading
   (&optional __heading)
   (if __heading (setq _heading __heading)) _heading)
  (:omega
   (&optional __omega)
   (if __omega (setq _omega __omega)) _omega)
  (:acceleration
   (&optional __acceleration)
   (if __acceleration (setq _acceleration __acceleration)) _acceleration)
  (:shield_time
   (&optional __shield_time)
   (if __shield_time (setq _shield_time __shield_time)) _shield_time)
  (:velocity_measurement_covariance
   (&optional __velocity_measurement_covariance)
   (if __velocity_measurement_covariance (setq _velocity_measurement_covariance __velocity_measurement_covariance)) _velocity_measurement_covariance)
  (:serialization-length
   ()
   (+
    ;; uint8 _class_id
    1
    ;; uint64 _id
    8
    ;; float32 _center_x
    4
    ;; float32 _center_y
    4
    ;; float32 _center_z
    4
    ;; float32 _width
    4
    ;; float32 _height
    4
    ;; float32 _length
    4
    ;; float32 _velocity
    4
    ;; float32 _heading
    4
    ;; float32 _omega
    4
    ;; float32 _acceleration
    4
    ;; uint32 _shield_time
    4
    ;; float64[] _velocity_measurement_covariance
    (* 8    (length _velocity_measurement_covariance)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8 _class_id
       (write-byte _class_id s)
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
     ;; float32 _center_x
       (sys::poke _center_x (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _center_y
       (sys::poke _center_y (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _center_z
       (sys::poke _center_z (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _width
       (sys::poke _width (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _height
       (sys::poke _height (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _length
       (sys::poke _length (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _velocity
       (sys::poke _velocity (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _heading
       (sys::poke _heading (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _omega
       (sys::poke _omega (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _acceleration
       (sys::poke _acceleration (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; uint32 _shield_time
       (write-long _shield_time s)
     ;; float64[] _velocity_measurement_covariance
     (write-long (length _velocity_measurement_covariance) s)
     (dotimes (i (length _velocity_measurement_covariance))
       (sys::poke (elt _velocity_measurement_covariance i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8 _class_id
     (setq _class_id (sys::peek buf ptr- :char)) (incf ptr- 1)
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
   ;; float32 _center_x
     (setq _center_x (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _center_y
     (setq _center_y (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _center_z
     (setq _center_z (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _width
     (setq _width (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _height
     (setq _height (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _length
     (setq _length (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _velocity
     (setq _velocity (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _heading
     (setq _heading (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _omega
     (setq _omega (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _acceleration
     (setq _acceleration (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; uint32 _shield_time
     (setq _shield_time (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float64[] _velocity_measurement_covariance
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _velocity_measurement_covariance (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _velocity_measurement_covariance i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     ))
   ;;
   self)
  )

(setf (get av_msgs::DynamicObstacle :md5sum-) "eda31db303c9b60e362d01b3c33e6bce")
(setf (get av_msgs::DynamicObstacle :datatype-) "av_msgs/DynamicObstacle")
(setf (get av_msgs::DynamicObstacle :definition-)
      "uint8 class_id
uint64 id
float32 center_x
float32 center_y
float32 center_z
float32 width
float32 height
float32 length
float32 velocity
# 车头夹角
float32 heading
# 角速度
float32 omega
# 加速度
float32 acceleration
# 遮挡时间，单位 sec
uint32 shield_time

# 测速 box 模型的协方差（用一维数组模拟二维数组，需要转换，6 * 6）
float64[] velocity_measurement_covariance


")



(provide :av_msgs/DynamicObstacle "eda31db303c9b60e362d01b3c33e6bce")


