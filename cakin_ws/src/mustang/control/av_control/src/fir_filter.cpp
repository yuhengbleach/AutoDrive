#include <av_control/fir_filter.h>
#include <iostream>

namespace av_control{

FIRFilter::FIRFilter(double gain, std::vector<double> coefs) : gain_(gain), coefs_(coefs){
	filter_size_ = coefs.size();
}

void FIRFilter::clear() {
	values_.clear();
}

double FIRFilter::process(double in) {
	double out = 0;
	values_.push_back(in);
    while(values_.size() > filter_size_) {
    	values_.pop_front();
    }
    double sum_coef = 0;
	for(int i = 0; i < values_.size(); i++) {
		out += coefs_[filter_size_ - i - 1] * values_[i];  // symmetric coefficient
        sum_coef += coefs_[i];
	}
    out /= sum_coef;
	out /= gain_;
	return out;
}
}
