;; Auto-generated. Do not edit!


(when (boundp 'av_msgs::Trajectory)
  (if (not (find-package "AV_MSGS"))
    (make-package "AV_MSGS"))
  (shadow 'Trajectory (find-package "AV_MSGS")))
(unless (find-package "AV_MSGS::TRAJECTORY")
  (make-package "AV_MSGS::TRAJECTORY"))

(in-package "ROS")
;;//! \htmlinclude Trajectory.msg.html


(defclass av_msgs::Trajectory
  :super ros::object
  :slots (_initial_pose _poses _driving_direction _driving_state ))

(defmethod av_msgs::Trajectory
  (:init
   (&key
    ((:initial_pose __initial_pose) (instance av_msgs::Pose :init))
    ((:poses __poses) (let (r) (dotimes (i 0) (push (instance av_msgs::Pose :init) r)) r))
    ((:driving_direction __driving_direction) 0)
    ((:driving_state __driving_state) 0)
    )
   (send-super :init)
   (setq _initial_pose __initial_pose)
   (setq _poses __poses)
   (setq _driving_direction (round __driving_direction))
   (setq _driving_state (round __driving_state))
   self)
  (:initial_pose
   (&rest __initial_pose)
   (if (keywordp (car __initial_pose))
       (send* _initial_pose __initial_pose)
     (progn
       (if __initial_pose (setq _initial_pose (car __initial_pose)))
       _initial_pose)))
  (:poses
   (&rest __poses)
   (if (keywordp (car __poses))
       (send* _poses __poses)
     (progn
       (if __poses (setq _poses (car __poses)))
       _poses)))
  (:driving_direction
   (&optional __driving_direction)
   (if __driving_direction (setq _driving_direction __driving_direction)) _driving_direction)
  (:driving_state
   (&optional __driving_state)
   (if __driving_state (setq _driving_state __driving_state)) _driving_state)
  (:serialization-length
   ()
   (+
    ;; av_msgs/Pose _initial_pose
    (send _initial_pose :serialization-length)
    ;; av_msgs/Pose[] _poses
    (apply #'+ (send-all _poses :serialization-length)) 4
    ;; uint8 _driving_direction
    1
    ;; uint8 _driving_state
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; av_msgs/Pose _initial_pose
       (send _initial_pose :serialize s)
     ;; av_msgs/Pose[] _poses
     (write-long (length _poses) s)
     (dolist (elem _poses)
       (send elem :serialize s)
       )
     ;; uint8 _driving_direction
       (write-byte _driving_direction s)
     ;; uint8 _driving_state
       (write-byte _driving_state s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; av_msgs/Pose _initial_pose
     (send _initial_pose :deserialize buf ptr-) (incf ptr- (send _initial_pose :serialization-length))
   ;; av_msgs/Pose[] _poses
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _poses (let (r) (dotimes (i n) (push (instance av_msgs::Pose :init) r)) r))
     (dolist (elem- _poses)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; uint8 _driving_direction
     (setq _driving_direction (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _driving_state
     (setq _driving_state (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;;
   self)
  )

(setf (get av_msgs::Trajectory :md5sum-) "11573a4fb030f7929e047f56621802a1")
(setf (get av_msgs::Trajectory :datatype-) "av_msgs/Trajectory")
(setf (get av_msgs::Trajectory :definition-)
      "Pose initial_pose
Pose[] poses
uint8 driving_direction
uint8 driving_state

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



(provide :av_msgs/Trajectory "11573a4fb030f7929e047f56621802a1")


