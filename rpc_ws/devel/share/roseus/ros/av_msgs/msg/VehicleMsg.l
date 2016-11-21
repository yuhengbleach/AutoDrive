;; Auto-generated. Do not edit!


(when (boundp 'av_msgs::VehicleMsg)
  (if (not (find-package "AV_MSGS"))
    (make-package "AV_MSGS"))
  (shadow 'VehicleMsg (find-package "AV_MSGS")))
(unless (find-package "AV_MSGS::VEHICLEMSG")
  (make-package "AV_MSGS::VEHICLEMSG"))

(in-package "ROS")
;;//! \htmlinclude VehicleMsg.msg.html


(defclass av_msgs::VehicleMsg
  :super ros::object
  :slots (_id _VehicleSpeedValid _Wheelspeed_RL _Wheelspeed_RR _Wheelspeed_RL_Valid _Wheelspeed_RR_Valid _VehicleSpeed _YawRate _LatAcceleration _LongAcceleration _EngineSpeed _EngineIdleSpeed _STAT_AcceleratorpedalPosition _STAT_AcceleratorPosRaw _Torsion_Bar_Torque _SteeringAngle _Steering_Angle_Speed ))

(defmethod av_msgs::VehicleMsg
  (:init
   (&key
    ((:id __id) 0)
    ((:VehicleSpeedValid __VehicleSpeedValid) 0.0)
    ((:Wheelspeed_RL __Wheelspeed_RL) 0.0)
    ((:Wheelspeed_RR __Wheelspeed_RR) 0.0)
    ((:Wheelspeed_RL_Valid __Wheelspeed_RL_Valid) 0.0)
    ((:Wheelspeed_RR_Valid __Wheelspeed_RR_Valid) 0.0)
    ((:VehicleSpeed __VehicleSpeed) 0.0)
    ((:YawRate __YawRate) 0.0)
    ((:LatAcceleration __LatAcceleration) 0.0)
    ((:LongAcceleration __LongAcceleration) 0.0)
    ((:EngineSpeed __EngineSpeed) 0.0)
    ((:EngineIdleSpeed __EngineIdleSpeed) 0.0)
    ((:STAT_AcceleratorpedalPosition __STAT_AcceleratorpedalPosition) 0.0)
    ((:STAT_AcceleratorPosRaw __STAT_AcceleratorPosRaw) 0.0)
    ((:Torsion_Bar_Torque __Torsion_Bar_Torque) 0.0)
    ((:SteeringAngle __SteeringAngle) 0.0)
    ((:Steering_Angle_Speed __Steering_Angle_Speed) 0.0)
    )
   (send-super :init)
   (setq _id (round __id))
   (setq _VehicleSpeedValid (float __VehicleSpeedValid))
   (setq _Wheelspeed_RL (float __Wheelspeed_RL))
   (setq _Wheelspeed_RR (float __Wheelspeed_RR))
   (setq _Wheelspeed_RL_Valid (float __Wheelspeed_RL_Valid))
   (setq _Wheelspeed_RR_Valid (float __Wheelspeed_RR_Valid))
   (setq _VehicleSpeed (float __VehicleSpeed))
   (setq _YawRate (float __YawRate))
   (setq _LatAcceleration (float __LatAcceleration))
   (setq _LongAcceleration (float __LongAcceleration))
   (setq _EngineSpeed (float __EngineSpeed))
   (setq _EngineIdleSpeed (float __EngineIdleSpeed))
   (setq _STAT_AcceleratorpedalPosition (float __STAT_AcceleratorpedalPosition))
   (setq _STAT_AcceleratorPosRaw (float __STAT_AcceleratorPosRaw))
   (setq _Torsion_Bar_Torque (float __Torsion_Bar_Torque))
   (setq _SteeringAngle (float __SteeringAngle))
   (setq _Steering_Angle_Speed (float __Steering_Angle_Speed))
   self)
  (:id
   (&optional __id)
   (if __id (setq _id __id)) _id)
  (:VehicleSpeedValid
   (&optional __VehicleSpeedValid)
   (if __VehicleSpeedValid (setq _VehicleSpeedValid __VehicleSpeedValid)) _VehicleSpeedValid)
  (:Wheelspeed_RL
   (&optional __Wheelspeed_RL)
   (if __Wheelspeed_RL (setq _Wheelspeed_RL __Wheelspeed_RL)) _Wheelspeed_RL)
  (:Wheelspeed_RR
   (&optional __Wheelspeed_RR)
   (if __Wheelspeed_RR (setq _Wheelspeed_RR __Wheelspeed_RR)) _Wheelspeed_RR)
  (:Wheelspeed_RL_Valid
   (&optional __Wheelspeed_RL_Valid)
   (if __Wheelspeed_RL_Valid (setq _Wheelspeed_RL_Valid __Wheelspeed_RL_Valid)) _Wheelspeed_RL_Valid)
  (:Wheelspeed_RR_Valid
   (&optional __Wheelspeed_RR_Valid)
   (if __Wheelspeed_RR_Valid (setq _Wheelspeed_RR_Valid __Wheelspeed_RR_Valid)) _Wheelspeed_RR_Valid)
  (:VehicleSpeed
   (&optional __VehicleSpeed)
   (if __VehicleSpeed (setq _VehicleSpeed __VehicleSpeed)) _VehicleSpeed)
  (:YawRate
   (&optional __YawRate)
   (if __YawRate (setq _YawRate __YawRate)) _YawRate)
  (:LatAcceleration
   (&optional __LatAcceleration)
   (if __LatAcceleration (setq _LatAcceleration __LatAcceleration)) _LatAcceleration)
  (:LongAcceleration
   (&optional __LongAcceleration)
   (if __LongAcceleration (setq _LongAcceleration __LongAcceleration)) _LongAcceleration)
  (:EngineSpeed
   (&optional __EngineSpeed)
   (if __EngineSpeed (setq _EngineSpeed __EngineSpeed)) _EngineSpeed)
  (:EngineIdleSpeed
   (&optional __EngineIdleSpeed)
   (if __EngineIdleSpeed (setq _EngineIdleSpeed __EngineIdleSpeed)) _EngineIdleSpeed)
  (:STAT_AcceleratorpedalPosition
   (&optional __STAT_AcceleratorpedalPosition)
   (if __STAT_AcceleratorpedalPosition (setq _STAT_AcceleratorpedalPosition __STAT_AcceleratorpedalPosition)) _STAT_AcceleratorpedalPosition)
  (:STAT_AcceleratorPosRaw
   (&optional __STAT_AcceleratorPosRaw)
   (if __STAT_AcceleratorPosRaw (setq _STAT_AcceleratorPosRaw __STAT_AcceleratorPosRaw)) _STAT_AcceleratorPosRaw)
  (:Torsion_Bar_Torque
   (&optional __Torsion_Bar_Torque)
   (if __Torsion_Bar_Torque (setq _Torsion_Bar_Torque __Torsion_Bar_Torque)) _Torsion_Bar_Torque)
  (:SteeringAngle
   (&optional __SteeringAngle)
   (if __SteeringAngle (setq _SteeringAngle __SteeringAngle)) _SteeringAngle)
  (:Steering_Angle_Speed
   (&optional __Steering_Angle_Speed)
   (if __Steering_Angle_Speed (setq _Steering_Angle_Speed __Steering_Angle_Speed)) _Steering_Angle_Speed)
  (:serialization-length
   ()
   (+
    ;; uint64 _id
    8
    ;; float32 _VehicleSpeedValid
    4
    ;; float32 _Wheelspeed_RL
    4
    ;; float32 _Wheelspeed_RR
    4
    ;; float32 _Wheelspeed_RL_Valid
    4
    ;; float32 _Wheelspeed_RR_Valid
    4
    ;; float32 _VehicleSpeed
    4
    ;; float32 _YawRate
    4
    ;; float32 _LatAcceleration
    4
    ;; float32 _LongAcceleration
    4
    ;; float32 _EngineSpeed
    4
    ;; float32 _EngineIdleSpeed
    4
    ;; float32 _STAT_AcceleratorpedalPosition
    4
    ;; float32 _STAT_AcceleratorPosRaw
    4
    ;; float32 _Torsion_Bar_Torque
    4
    ;; float32 _SteeringAngle
    4
    ;; float32 _Steering_Angle_Speed
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint64 _id
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _id (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _id) (= (length (_id . bv)) 2)) ;; bignum
              (write-long (ash (elt (_id . bv) 0) 0) s)
              (write-long (ash (elt (_id . bv) 1) -1) s))
             ((and (class _id) (= (length (_id . bv)) 1)) ;; big1
              (write-long (elt (_id . bv) 0) s)
              (write-long (if (>= _id 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _id s)(write-long (if (>= _id 0) 0 #xffffffff) s)))
     ;; float32 _VehicleSpeedValid
       (sys::poke _VehicleSpeedValid (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _Wheelspeed_RL
       (sys::poke _Wheelspeed_RL (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _Wheelspeed_RR
       (sys::poke _Wheelspeed_RR (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _Wheelspeed_RL_Valid
       (sys::poke _Wheelspeed_RL_Valid (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _Wheelspeed_RR_Valid
       (sys::poke _Wheelspeed_RR_Valid (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _VehicleSpeed
       (sys::poke _VehicleSpeed (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _YawRate
       (sys::poke _YawRate (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _LatAcceleration
       (sys::poke _LatAcceleration (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _LongAcceleration
       (sys::poke _LongAcceleration (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _EngineSpeed
       (sys::poke _EngineSpeed (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _EngineIdleSpeed
       (sys::poke _EngineIdleSpeed (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _STAT_AcceleratorpedalPosition
       (sys::poke _STAT_AcceleratorpedalPosition (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _STAT_AcceleratorPosRaw
       (sys::poke _STAT_AcceleratorPosRaw (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _Torsion_Bar_Torque
       (sys::poke _Torsion_Bar_Torque (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _SteeringAngle
       (sys::poke _SteeringAngle (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _Steering_Angle_Speed
       (sys::poke _Steering_Angle_Speed (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint64 _id
     
#+(or :alpha :irix6 :x86_64)
      (setf _id (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _id (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; float32 _VehicleSpeedValid
     (setq _VehicleSpeedValid (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _Wheelspeed_RL
     (setq _Wheelspeed_RL (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _Wheelspeed_RR
     (setq _Wheelspeed_RR (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _Wheelspeed_RL_Valid
     (setq _Wheelspeed_RL_Valid (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _Wheelspeed_RR_Valid
     (setq _Wheelspeed_RR_Valid (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _VehicleSpeed
     (setq _VehicleSpeed (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _YawRate
     (setq _YawRate (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _LatAcceleration
     (setq _LatAcceleration (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _LongAcceleration
     (setq _LongAcceleration (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _EngineSpeed
     (setq _EngineSpeed (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _EngineIdleSpeed
     (setq _EngineIdleSpeed (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _STAT_AcceleratorpedalPosition
     (setq _STAT_AcceleratorpedalPosition (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _STAT_AcceleratorPosRaw
     (setq _STAT_AcceleratorPosRaw (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _Torsion_Bar_Torque
     (setq _Torsion_Bar_Torque (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _SteeringAngle
     (setq _SteeringAngle (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _Steering_Angle_Speed
     (setq _Steering_Angle_Speed (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get av_msgs::VehicleMsg :md5sum-) "a0af1fb5c8e3ba97ad6e7bf3ebe7aed9")
(setf (get av_msgs::VehicleMsg :datatype-) "av_msgs/VehicleMsg")
(setf (get av_msgs::VehicleMsg :definition-)
      "uint64     id
float32    VehicleSpeedValid
float32    Wheelspeed_RL
float32    Wheelspeed_RR
float32    Wheelspeed_RL_Valid
float32    Wheelspeed_RR_Valid
float32    VehicleSpeed
float32    YawRate
float32    LatAcceleration
float32    LongAcceleration
float32    EngineSpeed
float32    EngineIdleSpeed
float32    STAT_AcceleratorpedalPosition
float32    STAT_AcceleratorPosRaw
float32    Torsion_Bar_Torque
float32    SteeringAngle
float32    Steering_Angle_Speed

")



(provide :av_msgs/VehicleMsg "a0af1fb5c8e3ba97ad6e7bf3ebe7aed9")


