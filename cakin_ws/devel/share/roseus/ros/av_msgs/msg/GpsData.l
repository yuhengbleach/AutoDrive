;; Auto-generated. Do not edit!


(when (boundp 'av_msgs::GpsData)
  (if (not (find-package "AV_MSGS"))
    (make-package "AV_MSGS"))
  (shadow 'GpsData (find-package "AV_MSGS")))
(unless (find-package "AV_MSGS::GPSDATA")
  (make-package "AV_MSGS::GPSDATA"))

(in-package "ROS")
;;//! \htmlinclude GpsData.msg.html


(defclass av_msgs::GpsData
  :super ros::object
  :slots (_timestamp _raw_data _mTime _latitude _longitude _altitude _vel_x _vel_y _vel_z _acc_x _acc_y _acc_z _nav_mode _pos_mode _vel_mode _att_mode _yaw_x _yaw_y _yaw_z _heading _pitch _roll ))

(defmethod av_msgs::GpsData
  (:init
   (&key
    ((:timestamp __timestamp) 0)
    ((:raw_data __raw_data) "")
    ((:mTime __mTime) 0.0)
    ((:latitude __latitude) 0.0)
    ((:longitude __longitude) 0.0)
    ((:altitude __altitude) 0.0)
    ((:vel_x __vel_x) 0.0)
    ((:vel_y __vel_y) 0.0)
    ((:vel_z __vel_z) 0.0)
    ((:acc_x __acc_x) 0.0)
    ((:acc_y __acc_y) 0.0)
    ((:acc_z __acc_z) 0.0)
    ((:nav_mode __nav_mode) 0)
    ((:pos_mode __pos_mode) 0)
    ((:vel_mode __vel_mode) 0)
    ((:att_mode __att_mode) 0)
    ((:yaw_x __yaw_x) 0.0)
    ((:yaw_y __yaw_y) 0.0)
    ((:yaw_z __yaw_z) 0.0)
    ((:heading __heading) 0.0)
    ((:pitch __pitch) 0.0)
    ((:roll __roll) 0.0)
    )
   (send-super :init)
   (setq _timestamp (round __timestamp))
   (setq _raw_data (string __raw_data))
   (setq _mTime (float __mTime))
   (setq _latitude (float __latitude))
   (setq _longitude (float __longitude))
   (setq _altitude (float __altitude))
   (setq _vel_x (float __vel_x))
   (setq _vel_y (float __vel_y))
   (setq _vel_z (float __vel_z))
   (setq _acc_x (float __acc_x))
   (setq _acc_y (float __acc_y))
   (setq _acc_z (float __acc_z))
   (setq _nav_mode (round __nav_mode))
   (setq _pos_mode (round __pos_mode))
   (setq _vel_mode (round __vel_mode))
   (setq _att_mode (round __att_mode))
   (setq _yaw_x (float __yaw_x))
   (setq _yaw_y (float __yaw_y))
   (setq _yaw_z (float __yaw_z))
   (setq _heading (float __heading))
   (setq _pitch (float __pitch))
   (setq _roll (float __roll))
   self)
  (:timestamp
   (&optional __timestamp)
   (if __timestamp (setq _timestamp __timestamp)) _timestamp)
  (:raw_data
   (&optional __raw_data)
   (if __raw_data (setq _raw_data __raw_data)) _raw_data)
  (:mTime
   (&optional __mTime)
   (if __mTime (setq _mTime __mTime)) _mTime)
  (:latitude
   (&optional __latitude)
   (if __latitude (setq _latitude __latitude)) _latitude)
  (:longitude
   (&optional __longitude)
   (if __longitude (setq _longitude __longitude)) _longitude)
  (:altitude
   (&optional __altitude)
   (if __altitude (setq _altitude __altitude)) _altitude)
  (:vel_x
   (&optional __vel_x)
   (if __vel_x (setq _vel_x __vel_x)) _vel_x)
  (:vel_y
   (&optional __vel_y)
   (if __vel_y (setq _vel_y __vel_y)) _vel_y)
  (:vel_z
   (&optional __vel_z)
   (if __vel_z (setq _vel_z __vel_z)) _vel_z)
  (:acc_x
   (&optional __acc_x)
   (if __acc_x (setq _acc_x __acc_x)) _acc_x)
  (:acc_y
   (&optional __acc_y)
   (if __acc_y (setq _acc_y __acc_y)) _acc_y)
  (:acc_z
   (&optional __acc_z)
   (if __acc_z (setq _acc_z __acc_z)) _acc_z)
  (:nav_mode
   (&optional __nav_mode)
   (if __nav_mode (setq _nav_mode __nav_mode)) _nav_mode)
  (:pos_mode
   (&optional __pos_mode)
   (if __pos_mode (setq _pos_mode __pos_mode)) _pos_mode)
  (:vel_mode
   (&optional __vel_mode)
   (if __vel_mode (setq _vel_mode __vel_mode)) _vel_mode)
  (:att_mode
   (&optional __att_mode)
   (if __att_mode (setq _att_mode __att_mode)) _att_mode)
  (:yaw_x
   (&optional __yaw_x)
   (if __yaw_x (setq _yaw_x __yaw_x)) _yaw_x)
  (:yaw_y
   (&optional __yaw_y)
   (if __yaw_y (setq _yaw_y __yaw_y)) _yaw_y)
  (:yaw_z
   (&optional __yaw_z)
   (if __yaw_z (setq _yaw_z __yaw_z)) _yaw_z)
  (:heading
   (&optional __heading)
   (if __heading (setq _heading __heading)) _heading)
  (:pitch
   (&optional __pitch)
   (if __pitch (setq _pitch __pitch)) _pitch)
  (:roll
   (&optional __roll)
   (if __roll (setq _roll __roll)) _roll)
  (:serialization-length
   ()
   (+
    ;; uint64 _timestamp
    8
    ;; string _raw_data
    4 (length _raw_data)
    ;; float64 _mTime
    8
    ;; float64 _latitude
    8
    ;; float64 _longitude
    8
    ;; float64 _altitude
    8
    ;; float64 _vel_x
    8
    ;; float64 _vel_y
    8
    ;; float64 _vel_z
    8
    ;; float64 _acc_x
    8
    ;; float64 _acc_y
    8
    ;; float64 _acc_z
    8
    ;; uint8 _nav_mode
    1
    ;; uint8 _pos_mode
    1
    ;; uint8 _vel_mode
    1
    ;; uint8 _att_mode
    1
    ;; float64 _yaw_x
    8
    ;; float64 _yaw_y
    8
    ;; float64 _yaw_z
    8
    ;; float64 _heading
    8
    ;; float64 _pitch
    8
    ;; float64 _roll
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
     ;; string _raw_data
       (write-long (length _raw_data) s) (princ _raw_data s)
     ;; float64 _mTime
       (sys::poke _mTime (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _latitude
       (sys::poke _latitude (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _longitude
       (sys::poke _longitude (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _altitude
       (sys::poke _altitude (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _vel_x
       (sys::poke _vel_x (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _vel_y
       (sys::poke _vel_y (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _vel_z
       (sys::poke _vel_z (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _acc_x
       (sys::poke _acc_x (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _acc_y
       (sys::poke _acc_y (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _acc_z
       (sys::poke _acc_z (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; uint8 _nav_mode
       (write-byte _nav_mode s)
     ;; uint8 _pos_mode
       (write-byte _pos_mode s)
     ;; uint8 _vel_mode
       (write-byte _vel_mode s)
     ;; uint8 _att_mode
       (write-byte _att_mode s)
     ;; float64 _yaw_x
       (sys::poke _yaw_x (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _yaw_y
       (sys::poke _yaw_y (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _yaw_z
       (sys::poke _yaw_z (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _heading
       (sys::poke _heading (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _pitch
       (sys::poke _pitch (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _roll
       (sys::poke _roll (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
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
   ;; string _raw_data
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _raw_data (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; float64 _mTime
     (setq _mTime (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _latitude
     (setq _latitude (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _longitude
     (setq _longitude (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _altitude
     (setq _altitude (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _vel_x
     (setq _vel_x (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _vel_y
     (setq _vel_y (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _vel_z
     (setq _vel_z (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _acc_x
     (setq _acc_x (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _acc_y
     (setq _acc_y (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _acc_z
     (setq _acc_z (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; uint8 _nav_mode
     (setq _nav_mode (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _pos_mode
     (setq _pos_mode (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _vel_mode
     (setq _vel_mode (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _att_mode
     (setq _att_mode (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; float64 _yaw_x
     (setq _yaw_x (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _yaw_y
     (setq _yaw_y (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _yaw_z
     (setq _yaw_z (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _heading
     (setq _heading (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _pitch
     (setq _pitch (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _roll
     (setq _roll (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get av_msgs::GpsData :md5sum-) "87fee0452d2944b3759d7782dace9b68")
(setf (get av_msgs::GpsData :datatype-) "av_msgs/GpsData")
(setf (get av_msgs::GpsData :definition-)
      "uint64 timestamp
string raw_data
float64 mTime
float64 latitude
float64 longitude
float64 altitude
float64 vel_x
float64 vel_y
float64 vel_z
float64 acc_x
float64 acc_y
float64 acc_z
uint8 nav_mode
uint8 pos_mode
uint8 vel_mode
uint8 att_mode
float64 yaw_x
float64 yaw_y
float64 yaw_z
float64 heading
float64 pitch
float64 roll

")



(provide :av_msgs/GpsData "87fee0452d2944b3759d7782dace9b68")


