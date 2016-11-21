#ifndef MUSTANG_AV_CONTROL_STATE_FILTER_H
#define MUSTANG_AV_CONTROL_STATE_FILTER_H
#include <av_control/controller_comm.h>

namespace av_control {

class StateFilter {
public:
	StateFilter() {};

	virtual void Process(VehicleState& vehicle_state, bool clear_filter = false) = 0;
    virtual void SignalProcess(double &acc_pedal, double &brake_pedal, double &steering_angle, bool clear_filter = false) = 0;
};

} // namespace av_control

#endif
