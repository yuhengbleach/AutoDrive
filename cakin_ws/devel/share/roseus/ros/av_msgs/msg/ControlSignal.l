;; Auto-generated. Do not edit!


(when (boundp 'av_msgs::ControlSignal)
  (if (not (find-package "AV_MSGS"))
    (make-package "AV_MSGS"))
  (shadow 'ControlSignal (find-package "AV_MSGS")))
(unless (find-package "AV_MSGS::CONTROLSIGNAL")
  (make-package "AV_MSGS::CONTROLSIGNAL"))

(in-package "ROS")
;;//! \htmlinclude ControlSignal.msg.html


(defclass av_msgs::ControlSignal
  :super ros::object
  :slots (_timestamp _acc_pedal_pos _brake_pedal_pos _steering_angle ))

(defmethod av_msgs::ControlSignal
  (:init
   (&key
    ((:timestamp __timestamp) 0)
    ((:acc_pedal_pos __acc_pedal_pos) 0.0)
    ((:brake_pedal_pos __brake_pedal_pos) 0.0)
    ((:steering_angle __steering_angle) 0.0)
    )
   (send-super :init)
   (setq _timestamp (round __timestamp))
   (setq _acc_pedal_pos (float __acc_pedal_pos))
   (setq _brake_pedal_pos (float __brake_pedal_pos))
   (setq _steering_angle (float __steering_angle))
   self)
  (:timestamp
   (&optional __timestamp)
   (if __timestamp (setq _timestamp __timestamp)) _timestamp)
  (:acc_pedal_pos
   (&optional __acc_pedal_pos)
   (if __acc_pedal_pos (setq _acc_pedal_pos __acc_pedal_pos)) _acc_pedal_pos)
  (:brake_pedal_pos
   (&optional __brake_pedal_pos)
   (if __brake_pedal_pos (setq _brake_pedal_pos __brake_pedal_pos)) _brake_pedal_pos)
  (:steering_angle
   (&optional __steering_angle)
   (if __steering_angle (setq _steering_angle __steering_angle)) _steering_angle)
  (:serialization-length
   ()
   (+
    ;; uint64 _timestamp
    8
    ;; float64 _acc_pedal_pos
    8
    ;; float64 _brake_pedal_pos
    8
    ;; float64 _steering_angle
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
     ;; float64 _acc_pedal_pos
       (sys::poke _acc_pedal_pos (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _brake_pedal_pos
       (sys::poke _brake_pedal_pos (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _steering_angle
       (sys::poke _steering_angle (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
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
   ;; float64 _acc_pedal_pos
     (setq _acc_pedal_pos (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _brake_pedal_pos
     (setq _brake_pedal_pos (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _steering_angle
     (setq _steering_angle (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get av_msgs::ControlSignal :md5sum-) "499f20eed8f057955b487203ef4437b9")
(setf (get av_msgs::ControlSignal :datatype-) "av_msgs/ControlSignal")
(setf (get av_msgs::ControlSignal :definition-)
      "uint64 timestamp
float64 acc_pedal_pos
float64 brake_pedal_pos
float64 steering_angle

")



(provide :av_msgs/ControlSignal "499f20eed8f057955b487203ef4437b9")


