;; Auto-generated. Do not edit!


(when (boundp 'av_msgs::FusionMap)
  (if (not (find-package "AV_MSGS"))
    (make-package "AV_MSGS"))
  (shadow 'FusionMap (find-package "AV_MSGS")))
(unless (find-package "AV_MSGS::FUSIONMAP")
  (make-package "AV_MSGS::FUSIONMAP"))

(in-package "ROS")
;;//! \htmlinclude FusionMap.msg.html


(defclass av_msgs::FusionMap
  :super ros::object
  :slots (_timestamp _dynamic_object_list _obstacle_map _section_list _pose ))

(defmethod av_msgs::FusionMap
  (:init
   (&key
    ((:timestamp __timestamp) 0)
    ((:dynamic_object_list __dynamic_object_list) (let (r) (dotimes (i 0) (push (instance av_msgs::DynamicObstacle :init) r)) r))
    ((:obstacle_map __obstacle_map) (instance av_msgs::GridMap :init))
    ((:section_list __section_list) (let (r) (dotimes (i 0) (push (instance av_msgs::SectionList :init) r)) r))
    ((:pose __pose) (instance av_msgs::Pose :init))
    )
   (send-super :init)
   (setq _timestamp (round __timestamp))
   (setq _dynamic_object_list __dynamic_object_list)
   (setq _obstacle_map __obstacle_map)
   (setq _section_list __section_list)
   (setq _pose __pose)
   self)
  (:timestamp
   (&optional __timestamp)
   (if __timestamp (setq _timestamp __timestamp)) _timestamp)
  (:dynamic_object_list
   (&rest __dynamic_object_list)
   (if (keywordp (car __dynamic_object_list))
       (send* _dynamic_object_list __dynamic_object_list)
     (progn
       (if __dynamic_object_list (setq _dynamic_object_list (car __dynamic_object_list)))
       _dynamic_object_list)))
  (:obstacle_map
   (&rest __obstacle_map)
   (if (keywordp (car __obstacle_map))
       (send* _obstacle_map __obstacle_map)
     (progn
       (if __obstacle_map (setq _obstacle_map (car __obstacle_map)))
       _obstacle_map)))
  (:section_list
   (&rest __section_list)
   (if (keywordp (car __section_list))
       (send* _section_list __section_list)
     (progn
       (if __section_list (setq _section_list (car __section_list)))
       _section_list)))
  (:pose
   (&rest __pose)
   (if (keywordp (car __pose))
       (send* _pose __pose)
     (progn
       (if __pose (setq _pose (car __pose)))
       _pose)))
  (:serialization-length
   ()
   (+
    ;; uint64 _timestamp
    8
    ;; av_msgs/DynamicObstacle[] _dynamic_object_list
    (apply #'+ (send-all _dynamic_object_list :serialization-length)) 4
    ;; av_msgs/GridMap _obstacle_map
    (send _obstacle_map :serialization-length)
    ;; av_msgs/SectionList[] _section_list
    (apply #'+ (send-all _section_list :serialization-length)) 4
    ;; av_msgs/Pose _pose
    (send _pose :serialization-length)
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
     ;; av_msgs/DynamicObstacle[] _dynamic_object_list
     (write-long (length _dynamic_object_list) s)
     (dolist (elem _dynamic_object_list)
       (send elem :serialize s)
       )
     ;; av_msgs/GridMap _obstacle_map
       (send _obstacle_map :serialize s)
     ;; av_msgs/SectionList[] _section_list
     (write-long (length _section_list) s)
     (dolist (elem _section_list)
       (send elem :serialize s)
       )
     ;; av_msgs/Pose _pose
       (send _pose :serialize s)
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
   ;; av_msgs/DynamicObstacle[] _dynamic_object_list
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _dynamic_object_list (let (r) (dotimes (i n) (push (instance av_msgs::DynamicObstacle :init) r)) r))
     (dolist (elem- _dynamic_object_list)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; av_msgs/GridMap _obstacle_map
     (send _obstacle_map :deserialize buf ptr-) (incf ptr- (send _obstacle_map :serialization-length))
   ;; av_msgs/SectionList[] _section_list
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _section_list (let (r) (dotimes (i n) (push (instance av_msgs::SectionList :init) r)) r))
     (dolist (elem- _section_list)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; av_msgs/Pose _pose
     (send _pose :deserialize buf ptr-) (incf ptr- (send _pose :serialization-length))
   ;;
   self)
  )

(setf (get av_msgs::FusionMap :md5sum-) "aa32fc0bd4214ed3b5eceff3c45ac56b")
(setf (get av_msgs::FusionMap :datatype-) "av_msgs/FusionMap")
(setf (get av_msgs::FusionMap :definition-)
      "# Fusion map.

uint64 timestamp                        # 当前时间戳

DynamicObstacle[] dynamic_object_list   # 动态障碍物列表

GridMap obstacle_map                    # 静态障碍物矩阵，150*100m(前100，后50，左50，右50)，
                                        # 粒度10cm*10cm, 可行驶区域为0，障碍物为1，不可见区域－1
SectionList[] section_list           	# 车道线列表

Pose pose

================================================================================
MSG: av_msgs/DynamicObstacle
uint8 class_id
uint64 id
float32 center_x
float32 center_y
float32 center_z
float32 width
float32 height
float32 length
float32 velocity
# 车头夹角
float32 heading
# 角速度
float32 omega
# 加速度
float32 acceleration
# 遮挡时间，单位 sec
uint32 shield_time

# 测速 box 模型的协方差（用一维数组模拟二维数组，需要转换，6 * 6）
float64[] velocity_measurement_covariance


================================================================================
MSG: av_msgs/GridMap
int32 width
int32 length
int32 center_x
int32 center_y
uint8[] grid_map

================================================================================
MSG: av_msgs/SectionList
# SectionList
LaneMarker[] lane_marker_list
# 0:curved 1:straight
int8 section_type


================================================================================
MSG: av_msgs/LaneMarker
#车道线类型
int8 paint_type
#车道线点序列
WayPoint[] waypoints


================================================================================
MSG: av_msgs/WayPoint
float64 x
float64 y
================================================================================
MSG: av_msgs/Pose
# 时间戳
uint64 timestamp
# 轨迹x坐标
float64 x
# 轨迹y坐标
float64 y
# 轨迹朝向角坐标
float64 theta
# 曲率
float64 curvature
# 速度
float64 velocity
# 加速度
float64 acceleration

")



(provide :av_msgs/FusionMap "aa32fc0bd4214ed3b5eceff3c45ac56b")


