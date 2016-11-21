#ifndef MUSTANG_AV_CONTROL_STATE_FIR_FILTER_H
#define MUSTANG_AV_CONTROL_STATE_FIR_FILTER_H
#include <av_control/controller_comm.h>
#include <av_control/fir_filter.h>
#include <av_control/state_filter.h>

namespace av_control {

class StateFirFilter : public StateFilter {
public:
	StateFirFilter();

	void Process(VehicleState& vehicle_state, bool clear_filter = false);
    void SignalProcess(double &acc_pedal, double &brake_pedal, double &steering_angle, bool clear_filter = false);
private:
    std::unique_ptr<FIRFilter> x_filter_ptr_, y_filter_ptr_, ang_filter_ptr_, vel_x_filter_ptr_, vel_y_filter_ptr_, vel_ang_filter_ptr_, acc_x_filter_ptr_, acc_y_filter_ptr_, acc_ang_filter_ptr_;
    std::unique_ptr<FIRFilter> acc_pedal_filter_ptr_, brake_pedal_filter_ptr_, steering_angle_filter_ptr_;

};

} // namespace av_control

#endif
