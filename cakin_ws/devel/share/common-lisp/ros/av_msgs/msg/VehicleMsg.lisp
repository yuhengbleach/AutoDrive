; Auto-generated. Do not edit!


(cl:in-package av_msgs-msg)


;//! \htmlinclude VehicleMsg.msg.html

(cl:defclass <VehicleMsg> (roslisp-msg-protocol:ros-message)
  ((id
    :reader id
    :initarg :id
    :type cl:integer
    :initform 0)
   (VehicleSpeedValid
    :reader VehicleSpeedValid
    :initarg :VehicleSpeedValid
    :type cl:float
    :initform 0.0)
   (Wheelspeed_RL
    :reader Wheelspeed_RL
    :initarg :Wheelspeed_RL
    :type cl:float
    :initform 0.0)
   (Wheelspeed_RR
    :reader Wheelspeed_RR
    :initarg :Wheelspeed_RR
    :type cl:float
    :initform 0.0)
   (Wheelspeed_RL_Valid
    :reader Wheelspeed_RL_Valid
    :initarg :Wheelspeed_RL_Valid
    :type cl:float
    :initform 0.0)
   (Wheelspeed_RR_Valid
    :reader Wheelspeed_RR_Valid
    :initarg :Wheelspeed_RR_Valid
    :type cl:float
    :initform 0.0)
   (VehicleSpeed
    :reader VehicleSpeed
    :initarg :VehicleSpeed
    :type cl:float
    :initform 0.0)
   (VehicleSpeed_stp
    :reader VehicleSpeed_stp
    :initarg :VehicleSpeed_stp
    :type cl:float
    :initform 0.0)
   (YawRate
    :reader YawRate
    :initarg :YawRate
    :type cl:float
    :initform 0.0)
   (LatAcceleration
    :reader LatAcceleration
    :initarg :LatAcceleration
    :type cl:float
    :initform 0.0)
   (LongAcceleration
    :reader LongAcceleration
    :initarg :LongAcceleration
    :type cl:float
    :initform 0.0)
   (EngineSpeed
    :reader EngineSpeed
    :initarg :EngineSpeed
    :type cl:float
    :initform 0.0)
   (EngineIdleSpeed
    :reader EngineIdleSpeed
    :initarg :EngineIdleSpeed
    :type cl:float
    :initform 0.0)
   (STAT_AcceleratorpedalPosition
    :reader STAT_AcceleratorpedalPosition
    :initarg :STAT_AcceleratorpedalPosition
    :type cl:float
    :initform 0.0)
   (STAT_AcceleratorPosRaw
    :reader STAT_AcceleratorPosRaw
    :initarg :STAT_AcceleratorPosRaw
    :type cl:float
    :initform 0.0)
   (Torsion_Bar_Torque
    :reader Torsion_Bar_Torque
    :initarg :Torsion_Bar_Torque
    :type cl:float
    :initform 0.0)
   (SteeringAngle
    :reader SteeringAngle
    :initarg :SteeringAngle
    :type cl:float
    :initform 0.0)
   (Steering_Angle_Speed
    :reader Steering_Angle_Speed
    :initarg :Steering_Angle_Speed
    :type cl:float
    :initform 0.0))
)

(cl:defclass VehicleMsg (<VehicleMsg>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <VehicleMsg>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'VehicleMsg)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name av_msgs-msg:<VehicleMsg> is deprecated: use av_msgs-msg:VehicleMsg instead.")))

(cl:ensure-generic-function 'id-val :lambda-list '(m))
(cl:defmethod id-val ((m <VehicleMsg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:id-val is deprecated.  Use av_msgs-msg:id instead.")
  (id m))

(cl:ensure-generic-function 'VehicleSpeedValid-val :lambda-list '(m))
(cl:defmethod VehicleSpeedValid-val ((m <VehicleMsg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:VehicleSpeedValid-val is deprecated.  Use av_msgs-msg:VehicleSpeedValid instead.")
  (VehicleSpeedValid m))

(cl:ensure-generic-function 'Wheelspeed_RL-val :lambda-list '(m))
(cl:defmethod Wheelspeed_RL-val ((m <VehicleMsg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:Wheelspeed_RL-val is deprecated.  Use av_msgs-msg:Wheelspeed_RL instead.")
  (Wheelspeed_RL m))

(cl:ensure-generic-function 'Wheelspeed_RR-val :lambda-list '(m))
(cl:defmethod Wheelspeed_RR-val ((m <VehicleMsg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:Wheelspeed_RR-val is deprecated.  Use av_msgs-msg:Wheelspeed_RR instead.")
  (Wheelspeed_RR m))

(cl:ensure-generic-function 'Wheelspeed_RL_Valid-val :lambda-list '(m))
(cl:defmethod Wheelspeed_RL_Valid-val ((m <VehicleMsg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:Wheelspeed_RL_Valid-val is deprecated.  Use av_msgs-msg:Wheelspeed_RL_Valid instead.")
  (Wheelspeed_RL_Valid m))

(cl:ensure-generic-function 'Wheelspeed_RR_Valid-val :lambda-list '(m))
(cl:defmethod Wheelspeed_RR_Valid-val ((m <VehicleMsg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:Wheelspeed_RR_Valid-val is deprecated.  Use av_msgs-msg:Wheelspeed_RR_Valid instead.")
  (Wheelspeed_RR_Valid m))

(cl:ensure-generic-function 'VehicleSpeed-val :lambda-list '(m))
(cl:defmethod VehicleSpeed-val ((m <VehicleMsg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:VehicleSpeed-val is deprecated.  Use av_msgs-msg:VehicleSpeed instead.")
  (VehicleSpeed m))

(cl:ensure-generic-function 'VehicleSpeed_stp-val :lambda-list '(m))
(cl:defmethod VehicleSpeed_stp-val ((m <VehicleMsg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:VehicleSpeed_stp-val is deprecated.  Use av_msgs-msg:VehicleSpeed_stp instead.")
  (VehicleSpeed_stp m))

(cl:ensure-generic-function 'YawRate-val :lambda-list '(m))
(cl:defmethod YawRate-val ((m <VehicleMsg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:YawRate-val is deprecated.  Use av_msgs-msg:YawRate instead.")
  (YawRate m))

(cl:ensure-generic-function 'LatAcceleration-val :lambda-list '(m))
(cl:defmethod LatAcceleration-val ((m <VehicleMsg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:LatAcceleration-val is deprecated.  Use av_msgs-msg:LatAcceleration instead.")
  (LatAcceleration m))

(cl:ensure-generic-function 'LongAcceleration-val :lambda-list '(m))
(cl:defmethod LongAcceleration-val ((m <VehicleMsg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:LongAcceleration-val is deprecated.  Use av_msgs-msg:LongAcceleration instead.")
  (LongAcceleration m))

(cl:ensure-generic-function 'EngineSpeed-val :lambda-list '(m))
(cl:defmethod EngineSpeed-val ((m <VehicleMsg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:EngineSpeed-val is deprecated.  Use av_msgs-msg:EngineSpeed instead.")
  (EngineSpeed m))

(cl:ensure-generic-function 'EngineIdleSpeed-val :lambda-list '(m))
(cl:defmethod EngineIdleSpeed-val ((m <VehicleMsg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:EngineIdleSpeed-val is deprecated.  Use av_msgs-msg:EngineIdleSpeed instead.")
  (EngineIdleSpeed m))

(cl:ensure-generic-function 'STAT_AcceleratorpedalPosition-val :lambda-list '(m))
(cl:defmethod STAT_AcceleratorpedalPosition-val ((m <VehicleMsg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:STAT_AcceleratorpedalPosition-val is deprecated.  Use av_msgs-msg:STAT_AcceleratorpedalPosition instead.")
  (STAT_AcceleratorpedalPosition m))

(cl:ensure-generic-function 'STAT_AcceleratorPosRaw-val :lambda-list '(m))
(cl:defmethod STAT_AcceleratorPosRaw-val ((m <VehicleMsg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:STAT_AcceleratorPosRaw-val is deprecated.  Use av_msgs-msg:STAT_AcceleratorPosRaw instead.")
  (STAT_AcceleratorPosRaw m))

(cl:ensure-generic-function 'Torsion_Bar_Torque-val :lambda-list '(m))
(cl:defmethod Torsion_Bar_Torque-val ((m <VehicleMsg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:Torsion_Bar_Torque-val is deprecated.  Use av_msgs-msg:Torsion_Bar_Torque instead.")
  (Torsion_Bar_Torque m))

(cl:ensure-generic-function 'SteeringAngle-val :lambda-list '(m))
(cl:defmethod SteeringAngle-val ((m <VehicleMsg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:SteeringAngle-val is deprecated.  Use av_msgs-msg:SteeringAngle instead.")
  (SteeringAngle m))

(cl:ensure-generic-function 'Steering_Angle_Speed-val :lambda-list '(m))
(cl:defmethod Steering_Angle_Speed-val ((m <VehicleMsg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader av_msgs-msg:Steering_Angle_Speed-val is deprecated.  Use av_msgs-msg:Steering_Angle_Speed instead.")
  (Steering_Angle_Speed m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <VehicleMsg>) ostream)
  "Serializes a message object of type '<VehicleMsg>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 32) (cl:slot-value msg 'id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 40) (cl:slot-value msg 'id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 48) (cl:slot-value msg 'id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 56) (cl:slot-value msg 'id)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'VehicleSpeedValid))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'Wheelspeed_RL))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'Wheelspeed_RR))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'Wheelspeed_RL_Valid))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'Wheelspeed_RR_Valid))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'VehicleSpeed))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'VehicleSpeed_stp))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'YawRate))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'LatAcceleration))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'LongAcceleration))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'EngineSpeed))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'EngineIdleSpeed))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'STAT_AcceleratorpedalPosition))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'STAT_AcceleratorPosRaw))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'Torsion_Bar_Torque))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'SteeringAngle))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'Steering_Angle_Speed))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <VehicleMsg>) istream)
  "Deserializes a message object of type '<VehicleMsg>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 32) (cl:slot-value msg 'id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 40) (cl:slot-value msg 'id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 48) (cl:slot-value msg 'id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 56) (cl:slot-value msg 'id)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'VehicleSpeedValid) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'Wheelspeed_RL) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'Wheelspeed_RR) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'Wheelspeed_RL_Valid) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'Wheelspeed_RR_Valid) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'VehicleSpeed) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'VehicleSpeed_stp) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'YawRate) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'LatAcceleration) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'LongAcceleration) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'EngineSpeed) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'EngineIdleSpeed) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'STAT_AcceleratorpedalPosition) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'STAT_AcceleratorPosRaw) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'Torsion_Bar_Torque) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'SteeringAngle) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'Steering_Angle_Speed) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<VehicleMsg>)))
  "Returns string type for a message object of type '<VehicleMsg>"
  "av_msgs/VehicleMsg")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'VehicleMsg)))
  "Returns string type for a message object of type 'VehicleMsg"
  "av_msgs/VehicleMsg")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<VehicleMsg>)))
  "Returns md5sum for a message object of type '<VehicleMsg>"
  "9809de6ec8139008921380dd7bb5146d")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'VehicleMsg)))
  "Returns md5sum for a message object of type 'VehicleMsg"
  "9809de6ec8139008921380dd7bb5146d")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<VehicleMsg>)))
  "Returns full string definition for message of type '<VehicleMsg>"
  (cl:format cl:nil "uint64     id~%float32    VehicleSpeedValid~%float32    Wheelspeed_RL~%float32    Wheelspeed_RR~%float32    Wheelspeed_RL_Valid~%float32    Wheelspeed_RR_Valid~%float32    VehicleSpeed~%float32    VehicleSpeed_stp~%float32    YawRate~%float32    LatAcceleration~%float32    LongAcceleration~%float32    EngineSpeed~%float32    EngineIdleSpeed~%float32    STAT_AcceleratorpedalPosition~%float32    STAT_AcceleratorPosRaw~%float32    Torsion_Bar_Torque~%float32    SteeringAngle~%float32    Steering_Angle_Speed~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'VehicleMsg)))
  "Returns full string definition for message of type 'VehicleMsg"
  (cl:format cl:nil "uint64     id~%float32    VehicleSpeedValid~%float32    Wheelspeed_RL~%float32    Wheelspeed_RR~%float32    Wheelspeed_RL_Valid~%float32    Wheelspeed_RR_Valid~%float32    VehicleSpeed~%float32    VehicleSpeed_stp~%float32    YawRate~%float32    LatAcceleration~%float32    LongAcceleration~%float32    EngineSpeed~%float32    EngineIdleSpeed~%float32    STAT_AcceleratorpedalPosition~%float32    STAT_AcceleratorPosRaw~%float32    Torsion_Bar_Torque~%float32    SteeringAngle~%float32    Steering_Angle_Speed~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <VehicleMsg>))
  (cl:+ 0
     8
     4
     4
     4
     4
     4
     4
     4
     4
     4
     4
     4
     4
     4
     4
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <VehicleMsg>))
  "Converts a ROS message object to a list"
  (cl:list 'VehicleMsg
    (cl:cons ':id (id msg))
    (cl:cons ':VehicleSpeedValid (VehicleSpeedValid msg))
    (cl:cons ':Wheelspeed_RL (Wheelspeed_RL msg))
    (cl:cons ':Wheelspeed_RR (Wheelspeed_RR msg))
    (cl:cons ':Wheelspeed_RL_Valid (Wheelspeed_RL_Valid msg))
    (cl:cons ':Wheelspeed_RR_Valid (Wheelspeed_RR_Valid msg))
    (cl:cons ':VehicleSpeed (VehicleSpeed msg))
    (cl:cons ':VehicleSpeed_stp (VehicleSpeed_stp msg))
    (cl:cons ':YawRate (YawRate msg))
    (cl:cons ':LatAcceleration (LatAcceleration msg))
    (cl:cons ':LongAcceleration (LongAcceleration msg))
    (cl:cons ':EngineSpeed (EngineSpeed msg))
    (cl:cons ':EngineIdleSpeed (EngineIdleSpeed msg))
    (cl:cons ':STAT_AcceleratorpedalPosition (STAT_AcceleratorpedalPosition msg))
    (cl:cons ':STAT_AcceleratorPosRaw (STAT_AcceleratorPosRaw msg))
    (cl:cons ':Torsion_Bar_Torque (Torsion_Bar_Torque msg))
    (cl:cons ':SteeringAngle (SteeringAngle msg))
    (cl:cons ':Steering_Angle_Speed (Steering_Angle_Speed msg))
))
