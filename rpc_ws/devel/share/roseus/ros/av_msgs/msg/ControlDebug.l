;; Auto-generated. Do not edit!


(when (boundp 'av_msgs::ControlDebug)
  (if (not (find-package "AV_MSGS"))
    (make-package "AV_MSGS"))
  (shadow 'ControlDebug (find-package "AV_MSGS")))
(unless (find-package "AV_MSGS::CONTROLDEBUG")
  (make-package "AV_MSGS::CONTROLDEBUG"))

(in-package "ROS")
;;//! \htmlinclude ControlDebug.msg.html


(defclass av_msgs::ControlDebug
  :super ros::object
  :slots (_desired_velocity _current_velocity _e_pose _e_angle ))

(defmethod av_msgs::ControlDebug
  (:init
   (&key
    ((:desired_velocity __desired_velocity) 0.0)
    ((:current_velocity __current_velocity) 0.0)
    ((:e_pose __e_pose) 0.0)
    ((:e_angle __e_angle) 0.0)
    )
   (send-super :init)
   (setq _desired_velocity (float __desired_velocity))
   (setq _current_velocity (float __current_velocity))
   (setq _e_pose (float __e_pose))
   (setq _e_angle (float __e_angle))
   self)
  (:desired_velocity
   (&optional __desired_velocity)
   (if __desired_velocity (setq _desired_velocity __desired_velocity)) _desired_velocity)
  (:current_velocity
   (&optional __current_velocity)
   (if __current_velocity (setq _current_velocity __current_velocity)) _current_velocity)
  (:e_pose
   (&optional __e_pose)
   (if __e_pose (setq _e_pose __e_pose)) _e_pose)
  (:e_angle
   (&optional __e_angle)
   (if __e_angle (setq _e_angle __e_angle)) _e_angle)
  (:serialization-length
   ()
   (+
    ;; float64 _desired_velocity
    8
    ;; float64 _current_velocity
    8
    ;; float64 _e_pose
    8
    ;; float64 _e_angle
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _desired_velocity
       (sys::poke _desired_velocity (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _current_velocity
       (sys::poke _current_velocity (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _e_pose
       (sys::poke _e_pose (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _e_angle
       (sys::poke _e_angle (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _desired_velocity
     (setq _desired_velocity (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _current_velocity
     (setq _current_velocity (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _e_pose
     (setq _e_pose (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _e_angle
     (setq _e_angle (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get av_msgs::ControlDebug :md5sum-) "7d5523c0fa27208129ad6a5de3491e13")
(setf (get av_msgs::ControlDebug :datatype-) "av_msgs/ControlDebug")
(setf (get av_msgs::ControlDebug :definition-)
      "#longitudinal
float64 desired_velocity
float64 current_velocity

#lateral 
float64 e_pose
float64 e_angle


")



(provide :av_msgs/ControlDebug "7d5523c0fa27208129ad6a5de3491e13")


