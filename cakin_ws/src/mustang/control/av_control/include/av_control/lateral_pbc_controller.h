#ifndef MUSTANG_AV_CONTROL_LATERAL_PBC_CONTROLLER_H
#define MUSTANG_AV_CONTROL_LATERAL_PBC_CONTROLLER_H
#include <av_msgs/Trajectory.h>
#include <av_control/controller_comm.h>
#include <av_control/lateral_controller.h>

namespace av_control{

class LateralPBCController : public LateralController{
public:
    LateralPBCController(ros::NodeHandle &nh);

    enum ErrorCode GenerateControlSignal(const av_msgs::Trajectory &trajectory, const VehicleState &vehicle_state, const uint64_t &time, double &steer_signal, double &ref_curvature, bool replanning_flag = false);

private:
    int rate_;
    ros::Publisher pub_pbc;

    double pbc_k0_, pbc_emax_, pbc_lambda_, pbc_ki_, pbc_kp_, steer_ratio_;
    double e_p_temp, z_temp;
    double PI_output_;

    void GetNonLinearGain(const double &e, double &ke);
    void GetPIOutput(const double &e_p, double &PI_output, bool &replanning_flag);
    void GetFeedForwardOutput(const double &ref_curvature, const double &vel_x, double &ff_output,bool &replanning_flag);
    void GetSteeringAngle(const double &e_p, double &ref_curvature, const VehicleState &vehicle_state, double &steering_signal, bool &replanning_flag);

};
} //namespace av_control

#endif
