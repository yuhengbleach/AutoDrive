;; Auto-generated. Do not edit!


(when (boundp 'av_msgs::IbeoObject)
  (if (not (find-package "AV_MSGS"))
    (make-package "AV_MSGS"))
  (shadow 'IbeoObject (find-package "AV_MSGS")))
(unless (find-package "AV_MSGS::IBEOOBJECT")
  (make-package "AV_MSGS::IBEOOBJECT"))

(in-package "ROS")
;;//! \htmlinclude IbeoObject.msg.html


(defclass av_msgs::IbeoObject
  :super ros::object
  :slots (_object_id _object_box_center_x _object_box_center_y _object_box_length _object_box_width _object_box_orientation _relative_velocity_x _relative_velocity_y _relative_velocity_sigma_x _relative_velocity_sigma_y _object_class _object_class_certainty _exist_measurement ))

(defmethod av_msgs::IbeoObject
  (:init
   (&key
    ((:object_id __object_id) 0)
    ((:object_box_center_x __object_box_center_x) 0.0)
    ((:object_box_center_y __object_box_center_y) 0.0)
    ((:object_box_length __object_box_length) 0.0)
    ((:object_box_width __object_box_width) 0.0)
    ((:object_box_orientation __object_box_orientation) 0.0)
    ((:relative_velocity_x __relative_velocity_x) 0.0)
    ((:relative_velocity_y __relative_velocity_y) 0.0)
    ((:relative_velocity_sigma_x __relative_velocity_sigma_x) 0.0)
    ((:relative_velocity_sigma_y __relative_velocity_sigma_y) 0.0)
    ((:object_class __object_class) 0)
    ((:object_class_certainty __object_class_certainty) 0.0)
    ((:exist_measurement __exist_measurement) 0.0)
    )
   (send-super :init)
   (setq _object_id (round __object_id))
   (setq _object_box_center_x (float __object_box_center_x))
   (setq _object_box_center_y (float __object_box_center_y))
   (setq _object_box_length (float __object_box_length))
   (setq _object_box_width (float __object_box_width))
   (setq _object_box_orientation (float __object_box_orientation))
   (setq _relative_velocity_x (float __relative_velocity_x))
   (setq _relative_velocity_y (float __relative_velocity_y))
   (setq _relative_velocity_sigma_x (float __relative_velocity_sigma_x))
   (setq _relative_velocity_sigma_y (float __relative_velocity_sigma_y))
   (setq _object_class (round __object_class))
   (setq _object_class_certainty (float __object_class_certainty))
   (setq _exist_measurement (float __exist_measurement))
   self)
  (:object_id
   (&optional __object_id)
   (if __object_id (setq _object_id __object_id)) _object_id)
  (:object_box_center_x
   (&optional __object_box_center_x)
   (if __object_box_center_x (setq _object_box_center_x __object_box_center_x)) _object_box_center_x)
  (:object_box_center_y
   (&optional __object_box_center_y)
   (if __object_box_center_y (setq _object_box_center_y __object_box_center_y)) _object_box_center_y)
  (:object_box_length
   (&optional __object_box_length)
   (if __object_box_length (setq _object_box_length __object_box_length)) _object_box_length)
  (:object_box_width
   (&optional __object_box_width)
   (if __object_box_width (setq _object_box_width __object_box_width)) _object_box_width)
  (:object_box_orientation
   (&optional __object_box_orientation)
   (if __object_box_orientation (setq _object_box_orientation __object_box_orientation)) _object_box_orientation)
  (:relative_velocity_x
   (&optional __relative_velocity_x)
   (if __relative_velocity_x (setq _relative_velocity_x __relative_velocity_x)) _relative_velocity_x)
  (:relative_velocity_y
   (&optional __relative_velocity_y)
   (if __relative_velocity_y (setq _relative_velocity_y __relative_velocity_y)) _relative_velocity_y)
  (:relative_velocity_sigma_x
   (&optional __relative_velocity_sigma_x)
   (if __relative_velocity_sigma_x (setq _relative_velocity_sigma_x __relative_velocity_sigma_x)) _relative_velocity_sigma_x)
  (:relative_velocity_sigma_y
   (&optional __relative_velocity_sigma_y)
   (if __relative_velocity_sigma_y (setq _relative_velocity_sigma_y __relative_velocity_sigma_y)) _relative_velocity_sigma_y)
  (:object_class
   (&optional __object_class)
   (if __object_class (setq _object_class __object_class)) _object_class)
  (:object_class_certainty
   (&optional __object_class_certainty)
   (if __object_class_certainty (setq _object_class_certainty __object_class_certainty)) _object_class_certainty)
  (:exist_measurement
   (&optional __exist_measurement)
   (if __exist_measurement (setq _exist_measurement __exist_measurement)) _exist_measurement)
  (:serialization-length
   ()
   (+
    ;; uint16 _object_id
    2
    ;; float32 _object_box_center_x
    4
    ;; float32 _object_box_center_y
    4
    ;; float32 _object_box_length
    4
    ;; float32 _object_box_width
    4
    ;; float32 _object_box_orientation
    4
    ;; float32 _relative_velocity_x
    4
    ;; float32 _relative_velocity_y
    4
    ;; float32 _relative_velocity_sigma_x
    4
    ;; float32 _relative_velocity_sigma_y
    4
    ;; uint8 _object_class
    1
    ;; float32 _object_class_certainty
    4
    ;; float32 _exist_measurement
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint16 _object_id
       (write-word _object_id s)
     ;; float32 _object_box_center_x
       (sys::poke _object_box_center_x (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _object_box_center_y
       (sys::poke _object_box_center_y (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _object_box_length
       (sys::poke _object_box_length (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _object_box_width
       (sys::poke _object_box_width (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _object_box_orientation
       (sys::poke _object_box_orientation (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _relative_velocity_x
       (sys::poke _relative_velocity_x (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _relative_velocity_y
       (sys::poke _relative_velocity_y (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _relative_velocity_sigma_x
       (sys::poke _relative_velocity_sigma_x (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _relative_velocity_sigma_y
       (sys::poke _relative_velocity_sigma_y (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; uint8 _object_class
       (write-byte _object_class s)
     ;; float32 _object_class_certainty
       (sys::poke _object_class_certainty (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _exist_measurement
       (sys::poke _exist_measurement (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint16 _object_id
     (setq _object_id (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; float32 _object_box_center_x
     (setq _object_box_center_x (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _object_box_center_y
     (setq _object_box_center_y (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _object_box_length
     (setq _object_box_length (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _object_box_width
     (setq _object_box_width (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _object_box_orientation
     (setq _object_box_orientation (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _relative_velocity_x
     (setq _relative_velocity_x (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _relative_velocity_y
     (setq _relative_velocity_y (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _relative_velocity_sigma_x
     (setq _relative_velocity_sigma_x (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _relative_velocity_sigma_y
     (setq _relative_velocity_sigma_y (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; uint8 _object_class
     (setq _object_class (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; float32 _object_class_certainty
     (setq _object_class_certainty (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _exist_measurement
     (setq _exist_measurement (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get av_msgs::IbeoObject :md5sum-) "eeb943ae30859d40f26de4eba16114d0")
(setf (get av_msgs::IbeoObject :datatype-) "av_msgs/IbeoObject")
(setf (get av_msgs::IbeoObject :definition-)
      "uint16 object_id
float32 object_box_center_x
float32 object_box_center_y
float32 object_box_length
float32 object_box_width
float32 object_box_orientation
float32 relative_velocity_x
float32 relative_velocity_y
float32 relative_velocity_sigma_x
float32 relative_velocity_sigma_y
uint8 object_class
float32 object_class_certainty
float32 exist_measurement



")



(provide :av_msgs/IbeoObject "eeb943ae30859d40f26de4eba16114d0")


