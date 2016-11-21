#ifndef MUSTANG_AV_CONTROL_CONTROL_COMM_H
#define MUSTANG_AV_CONTROL_CONTROL_COMM_H


namespace av_control {

enum ErrorCode {
	SUCCESS,
    INVALID_TRAJECTORY,
    GATEWAY_ERROR
};

struct VehicleState {
	double x, y, ang;
	double vel_x, vel_y, vel_ang;
	double acc_x, acc_y, acc_ang;
};

} // namespace av_control

#endif //MUSTANG_AV_PLANNING_PLANNING_COMM_H
