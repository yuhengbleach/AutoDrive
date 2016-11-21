;; Auto-generated. Do not edit!


(when (boundp 'av_msgs::CameraVelodyneObjectList)
  (if (not (find-package "AV_MSGS"))
    (make-package "AV_MSGS"))
  (shadow 'CameraVelodyneObjectList (find-package "AV_MSGS")))
(unless (find-package "AV_MSGS::CAMERAVELODYNEOBJECTLIST")
  (make-package "AV_MSGS::CAMERAVELODYNEOBJECTLIST"))

(in-package "ROS")
;;//! \htmlinclude CameraVelodyneObjectList.msg.html


(defclass av_msgs::CameraVelodyneObjectList
  :super ros::object
  :slots (_timestamp _camera_velodyne_object_list _width _length _center_x _center_y _grid_map ))

(defmethod av_msgs::CameraVelodyneObjectList
  (:init
   (&key
    ((:timestamp __timestamp) 0)
    ((:camera_velodyne_object_list __camera_velodyne_object_list) (let (r) (dotimes (i 0) (push (instance av_msgs::Object3D :init) r)) r))
    ((:width __width) 0)
    ((:length __length) 0)
    ((:center_x __center_x) 0)
    ((:center_y __center_y) 0)
    ((:grid_map __grid_map) (make-array 0 :initial-element 0 :element-type :char))
    )
   (send-super :init)
   (setq _timestamp (round __timestamp))
   (setq _camera_velodyne_object_list __camera_velodyne_object_list)
   (setq _width (round __width))
   (setq _length (round __length))
   (setq _center_x (round __center_x))
   (setq _center_y (round __center_y))
   (setq _grid_map __grid_map)
   self)
  (:timestamp
   (&optional __timestamp)
   (if __timestamp (setq _timestamp __timestamp)) _timestamp)
  (:camera_velodyne_object_list
   (&rest __camera_velodyne_object_list)
   (if (keywordp (car __camera_velodyne_object_list))
       (send* _camera_velodyne_object_list __camera_velodyne_object_list)
     (progn
       (if __camera_velodyne_object_list (setq _camera_velodyne_object_list (car __camera_velodyne_object_list)))
       _camera_velodyne_object_list)))
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
    ;; uint64 _timestamp
    8
    ;; av_msgs/Object3D[] _camera_velodyne_object_list
    (apply #'+ (send-all _camera_velodyne_object_list :serialization-length)) 4
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
     ;; av_msgs/Object3D[] _camera_velodyne_object_list
     (write-long (length _camera_velodyne_object_list) s)
     (dolist (elem _camera_velodyne_object_list)
       (send elem :serialize s)
       )
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
   ;; av_msgs/Object3D[] _camera_velodyne_object_list
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _camera_velodyne_object_list (let (r) (dotimes (i n) (push (instance av_msgs::Object3D :init) r)) r))
     (dolist (elem- _camera_velodyne_object_list)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
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

(setf (get av_msgs::CameraVelodyneObjectList :md5sum-) "00e3352e253ca731c1d5f90db8fe49fc")
(setf (get av_msgs::CameraVelodyneObjectList :datatype-) "av_msgs/CameraVelodyneObjectList")
(setf (get av_msgs::CameraVelodyneObjectList :definition-)
      "uint64 timestamp
Object3D[] camera_velodyne_object_list
int32 width
int32 length
int32 center_x
int32 center_y
uint8[] grid_map

================================================================================
MSG: av_msgs/Object3D
uint8 class_id
float32 center_x
float32 center_y
float32 center_z
float32 length
float32 width
float32 height
float32 orient
float32 confidence

")



(provide :av_msgs/CameraVelodyneObjectList "00e3352e253ca731c1d5f90db8fe49fc")


