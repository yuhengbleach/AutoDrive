* EPS shall not check for validity of ACU_2:ACU_Steering_Angle signal until   ACU_2:ACU_Engage signal value set to 0x01.
* EPS fault shall be cleared after receiving 10 consecutive messages with  ACU_2:ACU_Steering_Angle matching EPS_2:SteeringAngle without value changed and ACU_2:ACU engage signal set to 0x00
 
