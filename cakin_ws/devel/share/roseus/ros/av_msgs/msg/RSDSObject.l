;; Auto-generated. Do not edit!


(when (boundp 'av_msgs::RSDSObject)
  (if (not (find-package "AV_MSGS"))
    (make-package "AV_MSGS"))
  (shadow 'RSDSObject (find-package "AV_MSGS")))
(unless (find-package "AV_MSGS::RSDSOBJECT")
  (make-package "AV_MSGS::RSDSOBJECT"))

(in-package "ROS")
;;//! \htmlinclude RSDSObject.msg.html


(defclass av_msgs::RSDSObject
  :super ros::object
  :slots (_id _x_pos _x_vel _x_acc _y_pos _y_vel _y_acc _tracker_status _station_flags ))

(defmethod av_msgs::RSDSObject
  (:init
   (&key
    ((:id __id) 0)
    ((:x_pos __x_pos) 0.0)
    ((:x_vel __x_vel) 0.0)
    ((:x_acc __x_acc) 0.0)
    ((:y_pos __y_pos) 0.0)
    ((:y_vel __y_vel) 0.0)
    ((:y_acc __y_acc) 0.0)
    ((:tracker_status __tracker_status) 0)
    ((:station_flags __station_flags) 0)
    )
   (send-super :init)
   (setq _id (round __id))
   (setq _x_pos (float __x_pos))
   (setq _x_vel (float __x_vel))
   (setq _x_acc (float __x_acc))
   (setq _y_pos (float __y_pos))
   (setq _y_vel (float __y_vel))
   (setq _y_acc (float __y_acc))
   (setq _tracker_status (round __tracker_status))
   (setq _station_flags (round __station_flags))
   self)
  (:id
   (&optional __id)
   (if __id (setq _id __id)) _id)
  (:x_pos
   (&optional __x_pos)
   (if __x_pos (setq _x_pos __x_pos)) _x_pos)
  (:x_vel
   (&optional __x_vel)
   (if __x_vel (setq _x_vel __x_vel)) _x_vel)
  (:x_acc
   (&optional __x_acc)
   (if __x_acc (setq _x_acc __x_acc)) _x_acc)
  (:y_pos
   (&optional __y_pos)
   (if __y_pos (setq _y_pos __y_pos)) _y_pos)
  (:y_vel
   (&optional __y_vel)
   (if __y_vel (setq _y_vel __y_vel)) _y_vel)
  (:y_acc
   (&optional __y_acc)
   (if __y_acc (setq _y_acc __y_acc)) _y_acc)
  (:tracker_status
   (&optional __tracker_status)
   (if __tracker_status (setq _tracker_status __tracker_status)) _tracker_status)
  (:station_flags
   (&optional __station_flags)
   (if __station_flags (setq _station_flags __station_flags)) _station_flags)
  (:serialization-length
   ()
   (+
    ;; uint64 _id
    8
    ;; float32 _x_pos
    4
    ;; float32 _x_vel
    4
    ;; float32 _x_acc
    4
    ;; float32 _y_pos
    4
    ;; float32 _y_vel
    4
    ;; float32 _y_acc
    4
    ;; int32 _tracker_status
    4
    ;; int32 _station_flags
    4
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
     ;; float32 _x_pos
       (sys::poke _x_pos (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _x_vel
       (sys::poke _x_vel (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _x_acc
       (sys::poke _x_acc (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _y_pos
       (sys::poke _y_pos (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _y_vel
       (sys::poke _y_vel (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _y_acc
       (sys::poke _y_acc (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; int32 _tracker_status
       (write-long _tracker_status s)
     ;; int32 _station_flags
       (write-long _station_flags s)
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
   ;; float32 _x_pos
     (setq _x_pos (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _x_vel
     (setq _x_vel (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _x_acc
     (setq _x_acc (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _y_pos
     (setq _y_pos (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _y_vel
     (setq _y_vel (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _y_acc
     (setq _y_acc (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int32 _tracker_status
     (setq _tracker_status (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _station_flags
     (setq _station_flags (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get av_msgs::RSDSObject :md5sum-) "fc65ae1aba0b450ccf817515a12e2dd0")
(setf (get av_msgs::RSDSObject :datatype-) "av_msgs/RSDSObject")
(setf (get av_msgs::RSDSObject :definition-)
      "uint64 id # object id
float32 x_pos 
float32 x_vel
float32 x_acc
float32 y_pos
float32 y_vel
float32 y_acc
int32 tracker_status
int32 station_flags


")



(provide :av_msgs/RSDSObject "fc65ae1aba0b450ccf817515a12e2dd0")


