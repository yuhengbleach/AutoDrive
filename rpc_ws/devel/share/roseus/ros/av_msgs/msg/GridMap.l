;; Auto-generated. Do not edit!


(when (boundp 'av_msgs::GridMap)
  (if (not (find-package "AV_MSGS"))
    (make-package "AV_MSGS"))
  (shadow 'GridMap (find-package "AV_MSGS")))
(unless (find-package "AV_MSGS::GRIDMAP")
  (make-package "AV_MSGS::GRIDMAP"))

(in-package "ROS")
;;//! \htmlinclude GridMap.msg.html


(defclass av_msgs::GridMap
  :super ros::object
  :slots (_width _length _center_x _center_y _grid_map ))

(defmethod av_msgs::GridMap
  (:init
   (&key
    ((:width __width) 0)
    ((:length __length) 0)
    ((:center_x __center_x) 0)
    ((:center_y __center_y) 0)
    ((:grid_map __grid_map) (make-array 0 :initial-element 0 :element-type :char))
    )
   (send-super :init)
   (setq _width (round __width))
   (setq _length (round __length))
   (setq _center_x (round __center_x))
   (setq _center_y (round __center_y))
   (setq _grid_map __grid_map)
   self)
  (:width
   (&optional __width)
   (if __width (setq _width __width)) _width)
  (:length
   (&optional __length)
   (if __length (setq _length __length)) _length)
  (:center_x
   (&optional __center_x)
   (if __center_x (setq _center_x __center_x)) _center_x)
  (:center_y
   (&optional __center_y)
   (if __center_y (setq _center_y __center_y)) _center_y)
  (:grid_map
   (&optional __grid_map)
   (if __grid_map (setq _grid_map __grid_map)) _grid_map)
  (:serialization-length
   ()
   (+
    ;; int32 _width
    4
    ;; int32 _length
    4
    ;; int32 _center_x
    4
    ;; int32 _center_y
    4
    ;; uint8[] _grid_map
    (* 1    (length _grid_map)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _width
       (write-long _width s)
     ;; int32 _length
       (write-long _length s)
     ;; int32 _center_x
       (write-long _center_x s)
     ;; int32 _center_y
       (write-long _center_y s)
     ;; uint8[] _grid_map
     (write-long (length _grid_map) s)
     (princ _grid_map s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _width
     (setq _width (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _length
     (setq _length (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _center_x
     (setq _center_x (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _center_y
     (setq _center_y (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; uint8[] _grid_map
   (let ((n (sys::peek buf ptr- :integer))) (incf ptr- 4)
     (setq _grid_map (make-array n :element-type :char))
     (replace _grid_map buf :start2 ptr-) (incf ptr- n))
   ;;
   self)
  )

(setf (get av_msgs::GridMap :md5sum-) "c2e2c1220954a6d55dc0c1c7ef445fe5")
(setf (get av_msgs::GridMap :datatype-) "av_msgs/GridMap")
(setf (get av_msgs::GridMap :definition-)
      "int32 width
int32 length
int32 center_x
int32 center_y
uint8[] grid_map

")



(provide :av_msgs/GridMap "c2e2c1220954a6d55dc0c1c7ef445fe5")


