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

