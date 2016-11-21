#ifndef MUSTANG_AV_CONTROL_FIR_FILTER_H
#define MUSTANG_AV_CONTROL_FIR_FILTER_H

#include <vector>
#include <deque>

namespace av_control{

class FIRFilter {
public:
	FIRFilter(double gain, std::vector<double> coefs);

	double process(double in);

	void clear();

private:
	std::deque<double> values_;
	
	std::vector<double> coefs_;

	int filter_size_;

	//declare gain coefficient to scale the output back to normal
	double gain_; // set to 1 and input unity to see what this needs to be
};

}
#endif

