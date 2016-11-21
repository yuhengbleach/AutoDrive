;; Auto-generated. Do not edit!


(when (boundp 'av_msgs::IbeoPoint)
  (if (not (find-package "AV_MSGS"))
    (make-package "AV_MSGS"))
  (shadow 'IbeoPoint (find-package "AV_MSGS")))
(unless (find-package "AV_MSGS::IBEOPOINT")
  (make-package "AV_MSGS::IBEOPOINT"))

(in-package "ROS")
;;//! \htmlinclude IbeoPoint.msg.html


(defclass av_msgs::IbeoPoint
  :super ros::object
  :slots (_device_id _echo _flags _layer _position_x _position_y _position_z ))

(defmethod av_msgs::IbeoPoint
  (:init
   (&key
    ((:device_id __device_id) 0)
    ((:echo __echo) 0)
    ((:flags __flags) 0)
    ((:layer __layer) 0)
    ((:position_x __position_x) 0.0)
    ((:position_y __position_y) 0.0)
    ((:position_z __position_z) 0.0)
    )
   (send-super :init)
   (setq _device_id (round __device_id))
   (setq _echo (round __echo))
   (setq _flags (round __flags))
   (setq _layer (round __layer))
   (setq _position_x (float __position_x))
   (setq _position_y (float __position_y))
   (setq _position_z (float __position_z))
   self)
  (:device_id
   (&optional __device_id)
   (if __device_id (setq _device_id __device_id)) _device_id)
  (:echo
   (&optional __echo)
   (if __echo (setq _echo __echo)) _echo)
  (:flags
   (&optional __flags)
   (if __flags (setq _flags __flags)) _flags)
  (:layer
   (&optional __layer)
   (if __layer (setq _layer __layer)) _layer)
  (:position_x
   (&optional __position_x)
   (if __position_x (setq _position_x __position_x)) _position_x)
  (:position_y
   (&optional __position_y)
   (if __position_y (setq _position_y __position_y)) _position_y)
  (:position_z
   (&optional __position_z)
   (if __position_z (setq _position_z __position_z)) _position_z)
  (:serialization-length
   ()
   (+
    ;; uint8 _device_id
    1
    ;; uint8 _echo
    1
    ;; uint16 _flags
    2
    ;; uint8 _layer
    1
    ;; float32 _position_x
    4
    ;; float32 _position_y
    4
    ;; float32 _position_z
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8 _device_id
       (write-byte _device_id s)
     ;; uint8 _echo
       (write-byte _echo s)
     ;; uint16 _flags
       (write-word _flags s)
     ;; uint8 _layer
       (write-byte _layer s)
     ;; float32 _position_x
       (sys::poke _position_x (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _position_y
       (sys::poke _position_y (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _position_z
       (sys::poke _position_z (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8 _device_id
     (setq _device_id (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _echo
     (setq _echo (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint16 _flags
     (setq _flags (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; uint8 _layer
     (setq _layer (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; float32 _position_x
     (setq _position_x (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _position_y
     (setq _position_y (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _position_z
     (setq _position_z (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get av_msgs::IbeoPoint :md5sum-) "9be76836bccda774e0c4ed9114e101d6")
(setf (get av_msgs::IbeoPoint :datatype-) "av_msgs/IbeoPoint")
(setf (get av_msgs::IbeoPoint :definition-)
      "uint8 device_id
uint8 echo
uint16 flags
uint8 layer
float32 position_x
float32 position_y
float32 position_z

")



(provide :av_msgs/IbeoPoint "9be76836bccda774e0c4ed9114e101d6")


