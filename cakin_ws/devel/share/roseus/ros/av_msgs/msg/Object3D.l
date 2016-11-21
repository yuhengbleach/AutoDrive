;; Auto-generated. Do not edit!


(when (boundp 'av_msgs::Object3D)
  (if (not (find-package "AV_MSGS"))
    (make-package "AV_MSGS"))
  (shadow 'Object3D (find-package "AV_MSGS")))
(unless (find-package "AV_MSGS::OBJECT3D")
  (make-package "AV_MSGS::OBJECT3D"))

(in-package "ROS")
;;//! \htmlinclude Object3D.msg.html


(defclass av_msgs::Object3D
  :super ros::object
  :slots (_class_id _center_x _center_y _center_z _length _width _height _orient _confidence ))

(defmethod av_msgs::Object3D
  (:init
   (&key
    ((:class_id __class_id) 0)
    ((:center_x __center_x) 0.0)
    ((:center_y __center_y) 0.0)
    ((:center_z __center_z) 0.0)
    ((:length __length) 0.0)
    ((:width __width) 0.0)
    ((:height __height) 0.0)
    ((:orient __orient) 0.0)
    ((:confidence __confidence) 0.0)
    )
   (send-super :init)
   (setq _class_id (round __class_id))
   (setq _center_x (float __center_x))
   (setq _center_y (float __center_y))
   (setq _center_z (float __center_z))
   (setq _length (float __length))
   (setq _width (float __width))
   (setq _height (float __height))
   (setq _orient (float __orient))
   (setq _confidence (float __confidence))
   self)
  (:class_id
   (&optional __class_id)
   (if __class_id (setq _class_id __class_id)) _class_id)
  (:center_x
   (&optional __center_x)
   (if __center_x (setq _center_x __center_x)) _center_x)
  (:center_y
   (&optional __center_y)
   (if __center_y (setq _center_y __center_y)) _center_y)
  (:center_z
   (&optional __center_z)
   (if __center_z (setq _center_z __center_z)) _center_z)
  (:length
   (&optional __length)
   (if __length (setq _length __length)) _length)
  (:width
   (&optional __width)
   (if __width (setq _width __width)) _width)
  (:height
   (&optional __height)
   (if __height (setq _height __height)) _height)
  (:orient
   (&optional __orient)
   (if __orient (setq _orient __orient)) _orient)
  (:confidence
   (&optional __confidence)
   (if __confidence (setq _confidence __confidence)) _confidence)
  (:serialization-length
   ()
   (+
    ;; uint8 _class_id
    1
    ;; float32 _center_x
    4
    ;; float32 _center_y
    4
    ;; float32 _center_z
    4
    ;; float32 _length
    4
    ;; float32 _width
    4
    ;; float32 _height
    4
    ;; float32 _orient
    4
    ;; float32 _confidence
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8 _class_id
       (write-byte _class_id s)
     ;; float32 _center_x
       (sys::poke _center_x (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _center_y
       (sys::poke _center_y (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _center_z
       (sys::poke _center_z (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _length
       (sys::poke _length (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _width
       (sys::poke _width (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _height
       (sys::poke _height (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _orient
       (sys::poke _orient (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _confidence
       (sys::poke _confidence (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8 _class_id
     (setq _class_id (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; float32 _center_x
     (setq _center_x (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _center_y
     (setq _center_y (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _center_z
     (setq _center_z (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _length
     (setq _length (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _width
     (setq _width (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _height
     (setq _height (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _orient
     (setq _orient (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _confidence
     (setq _confidence (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get av_msgs::Object3D :md5sum-) "b61e17d31f6a6546d41ab0932afcccd8")
(setf (get av_msgs::Object3D :datatype-) "av_msgs/Object3D")
(setf (get av_msgs::Object3D :definition-)
      "uint8 class_id
float32 center_x
float32 center_y
float32 center_z
float32 length
float32 width
float32 height
float32 orient
float32 confidence

")



(provide :av_msgs/Object3D "b61e17d31f6a6546d41ab0932afcccd8")


