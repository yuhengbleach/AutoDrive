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
  :slots (_acc_pedal_pos _brake_pedal_pos _steering_angle ))

(defmethod av_msgs::ControlSignal
  (:init
   (&key
    ((:acc_pedal_pos __acc_pedal_pos) 0.0)
    ((:brake_pedal_pos __brake_pedal_pos) 0.0)
    ((:steering_angle __steering_angle) 0.0)
    )
   (send-super :init)
   (setq _acc_pedal_pos (float __acc_pedal_pos))
   (setq _brake_pedal_pos (float __brake_pedal_pos))
   (setq _steering_angle (float __steering_angle))
   self)
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
   ;; float64 _acc_pedal_pos
     (setq _acc_pedal_pos (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _brake_pedal_pos
     (setq _brake_pedal_pos (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _steering_angle
     (setq _steering_angle (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get av_msgs::ControlSignal :md5sum-) "380757b3e6e5a38260032bb0b5a75882")
(setf (get av_msgs::ControlSignal :datatype-) "av_msgs/ControlSignal")
(setf (get av_msgs::ControlSignal :definition-)
      "float64 acc_pedal_pos
float64 brake_pedal_pos
float64 steering_angle

")



(provide :av_msgs/ControlSignal "380757b3e6e5a38260032bb0b5a75882")


