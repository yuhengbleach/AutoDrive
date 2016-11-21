#include <av_planning/gpu_calculator.h>
#include <av_planning/planning_comm.h>
#include <vector>
#include <iostream>
/*#include <boost/serialization/vector.hpp>*/
/*#include <boost/archive/text_oarchive.hpp>*/
/*#include <boost/archive/text_iarchive.hpp>*/

using namespace std;
using namespace av_planning;
using namespace av_msgs;

namespace{
    const DTYPE eps = 1e-6;
    const int C_LEN = 6;
    const int CDOT_LEN = 5;
    const int CDDOT_LEN = 4;
    const int CURVE_OFFSET = C_LEN+CDOT_LEN+CDDOT_LEN+1;
    const int SPLINE_FIXLEN = 7;
    const int SPLINE_OFFSET = 5;
    const int POSE_OFFSET = 7; //x, y, timestamp
    const int RANGE_OFFSET = 2;
}

void getTrajectoryCost(const std::vector<av_msgs::Pose>& poses, const std::vector<double>& d_list, const Range& d_range, const std::vector<double>& accelerations, const std::vector<double>& jerks, const ManeuverState& maneuver_state, Cost& cost, double acceleration_normalization_, double jerk_normalization_, double curvature_normalization_) {
    double velocity_cost_sum=0, acceleration_cost_sum=0, jerk_cost_sum=0, curvature_cost_sum=0, position_cost_sum=0;
    int size = poses.size();
    for(int i=0; i<size; i++) {
        Pose pose = poses[i];
        velocity_cost_sum += abs(pose.velocity-maneuver_state.v);
        acceleration_cost_sum += abs(accelerations[i]);
        jerk_cost_sum += abs(jerks[i]);
        curvature_cost_sum += abs(pose.curvature);
        position_cost_sum += abs(d_list[i]);
    }
    double velocity_cost = velocity_cost_sum/size;
    double acceleration_cost = acceleration_cost_sum/size;
    double jerk_cost = jerk_cost_sum/size;
    double curvature_cost = curvature_cost_sum/size;
    double position_cost = position_cost_sum/size;
    double similarity_cost = 0; // the similarity cost will be computed in trajectory selection

    // Normalize the costs
    if(maneuver_state.v > eps) {
        velocity_cost = velocity_cost / abs(maneuver_state.v);
    } else{
        ; // occurs in stop mode
    }
    cost.velocity_cost = velocity_cost;
    cost.acceleration_cost = acceleration_cost / acceleration_normalization_;
    cost.jerk_cost = jerk_cost / jerk_normalization_;
    cost.curvature_cost = curvature_cost / curvature_normalization_;
    cost.position_cost = position_cost / fabs(d_range.max_value - d_range.min_value);
    cost.similarity_cost = similarity_cost;
}

static void HandleError( cudaError_t err, const char *file, int line){
    if (err != cudaSuccess){
        printf( "%s in %s at line %d\n", cudaGetErrorString( err ), file, line);
        exit( EXIT_FAILURE);
    }
}
#define HANDLE_ERROR( err ) (HandleError(err, __FILE__, __LINE__))

void toArrayCurves(const std::vector<Curve>& s_curves, DTYPE* s_curves_list){
    int tmp_index = 0;
    for (vector<Curve>::const_iterator iter = s_curves.begin(); iter != s_curves.end(); iter++){
        /*assert(iter->c.size() == C_LEN);*/
        /*assert(iter->c_dot.size() == CDOT_LEN);*/
        /*assert(iter->c_ddot.size() == CDDOT_LEN);*/
        for (int i = 0; i < C_LEN - iter->c.size(); i++){
            s_curves_list[tmp_index++] = 0;
        }
        for (vector<double>::const_iterator son_iter = iter->c.begin(); son_iter != iter->c.end(); son_iter++){
            s_curves_list[tmp_index++] = *son_iter;
        }
        for (int i = 0; i < CDOT_LEN - iter->c_dot.size(); i++){
            s_curves_list[tmp_index++] = 0;
        }
        for (vector<double>::const_iterator son_iter = iter->c_dot.begin(); son_iter != iter->c_dot.end(); son_iter++){
            s_curves_list[tmp_index++] = *son_iter;
        }
        for (int i = 0; i < CDDOT_LEN - iter->c_ddot.size(); i++){
            s_curves_list[tmp_index++] = 0;
        }
        for (vector<double>::const_iterator son_iter = iter->c_ddot.begin(); son_iter != iter->c_ddot.end(); son_iter++){
            s_curves_list[tmp_index++] = *son_iter;
        }
        s_curves_list[tmp_index++] = iter->terminal;
    }
}

void toArrayTlist(const std::vector<double>& t_list, DTYPE* t_array){
    int tmp_index = 0;
    for (vector<double>::const_iterator iter = t_list.begin(); iter != t_list.end(); iter++){
        t_array[tmp_index++] = *iter;
    }
}

void toArraySpline(const spline& ref_curve, DTYPE* spline_array, int spline_size){
    int tmp_index = 0;
    spline_array[tmp_index++] = ref_curve.m_b0;
    spline_array[tmp_index++] = ref_curve.m_c0;
    spline_array[tmp_index++] = ref_curve.m_left;
    spline_array[tmp_index++] = ref_curve.m_right;
    spline_array[tmp_index++] = ref_curve.m_left_value;
    spline_array[tmp_index++] = ref_curve.m_right_value;
    spline_array[tmp_index++] = ref_curve.m_force_linear_extrapolation;
    for(int i = 0; i < spline_size; i++){
        spline_array[tmp_index++] = ref_curve.m_x[i];
        spline_array[tmp_index++] = ref_curve.m_y[i];
        spline_array[tmp_index++] = ref_curve.m_a[i];
        spline_array[tmp_index++] = ref_curve.m_b[i];
        spline_array[tmp_index++] = ref_curve.m_c[i];
    }
}

__device__ DTYPE polyVal(DTYPE x, DTYPE* coefficients, int coef_index, int coef_len){
	DTYPE y = 0;
	for(int i=0; i<coef_len; i++) {
		y += (coefficients[coef_index+i]*powf(x,(coef_len-i-1)));
	}
	return y;
}


__device__ int lower_bound(DTYPE *array, int size, DTYPE key, int index){
    int first = 0, middle;
    int half, len;
    len = size;
    while(len > 0) {
        half = len >> 1;
        middle = first + half;
        if(array[middle*SPLINE_OFFSET+SPLINE_FIXLEN+index] < key) {     
            first = middle + 1;          
            len = len-half-1;       
        }
        else
            len = half;           
    }
    return first;
}

__device__ DTYPE splineCurveVal(DTYPE x, DTYPE* spline, int spline_size){
    int match_id = lower_bound(spline, spline_size, x, 0) - 1;
    if (match_id < 0) match_id = 0;
    if (match_id >= spline_size) match_id = spline_size-1;
    DTYPE h = x - spline[match_id*SPLINE_OFFSET+SPLINE_FIXLEN];
    DTYPE interpol;
    if(x < spline[0*SPLINE_OFFSET+SPLINE_FIXLEN])
        interpol = (spline[0]*h + spline[1])*h + spline[0*SPLINE_OFFSET+SPLINE_FIXLEN+1];
    else if(x > spline[(spline_size-1)*SPLINE_OFFSET+SPLINE_FIXLEN])
        interpol = (spline[(spline_size-1)*SPLINE_OFFSET+SPLINE_FIXLEN+3]*h + spline[(spline_size-1)*SPLINE_OFFSET+SPLINE_FIXLEN+4])*h 
            + spline[(spline_size-1)*SPLINE_OFFSET+SPLINE_FIXLEN+1];
    else
        interpol = ((spline[match_id*SPLINE_OFFSET+SPLINE_FIXLEN+2]*h+spline[match_id*SPLINE_OFFSET+SPLINE_FIXLEN+3])*h
            + spline[match_id*SPLINE_OFFSET+SPLINE_FIXLEN+4])*h + spline[match_id*SPLINE_OFFSET+SPLINE_FIXLEN+1];
    return interpol;
}

__device__ DTYPE splineCurveDeriv1(DTYPE x, DTYPE* spline, int spline_size){
    int match_id = lower_bound(spline, spline_size, x, 0) - 1;
    if (match_id < 0) match_id = 0;
    if (match_id >= spline_size) match_id = spline_size-1;
    DTYPE h = x - spline[match_id*SPLINE_OFFSET+SPLINE_FIXLEN];
    DTYPE interpol;
    if(x < spline[0*SPLINE_OFFSET+SPLINE_FIXLEN])
        interpol = 2*spline[0]*h + spline[1];
    else if(x > spline[(spline_size-1)*SPLINE_OFFSET+SPLINE_FIXLEN])
        interpol = 2*spline[(spline_size-1)*SPLINE_OFFSET+SPLINE_FIXLEN+3]*h + spline[(spline_size-1)*SPLINE_OFFSET+SPLINE_FIXLEN+4];
    else
        interpol = (3*spline[match_id*SPLINE_OFFSET+SPLINE_FIXLEN+2]*h+2*spline[match_id*SPLINE_OFFSET+SPLINE_FIXLEN+3])*h +
            spline[match_id*SPLINE_OFFSET+SPLINE_FIXLEN+4];
    return interpol;
}

__device__ DTYPE splineCurveDeriv2(DTYPE x, DTYPE* spline, int spline_size){
    int match_id = lower_bound(spline, spline_size, x, 0) - 1;
    if (match_id < 0) match_id = 0;
    if (match_id >= spline_size) match_id = spline_size-1;
    DTYPE h = x - spline[match_id*SPLINE_OFFSET+SPLINE_FIXLEN];
    DTYPE interpol;
    if(x < spline[0*SPLINE_OFFSET+SPLINE_FIXLEN])
        interpol = 2*spline[0];
    else if(x > spline[(spline_size-1)*SPLINE_OFFSET+SPLINE_FIXLEN])
        interpol = 2*spline[(spline_size-1)*SPLINE_OFFSET+SPLINE_FIXLEN+3];
    else
        interpol = 6*spline[match_id*SPLINE_OFFSET+SPLINE_FIXLEN+2]*h+2*spline[match_id*SPLINE_OFFSET+SPLINE_FIXLEN+3];
    return interpol;
}

__device__ DTYPE polyCurveVal(DTYPE cur_t, DTYPE* curves, int index, bool is_extend){
    DTYPE endx = curves[index*CURVE_OFFSET+CURVE_OFFSET-1];
    DTYPE res = 0;
    if( cur_t <= endx ){
        res = polyVal(cur_t, curves, index*CURVE_OFFSET, C_LEN);
    }else if(is_extend){
        DTYPE v = polyVal(endx, curves, index*CURVE_OFFSET+C_LEN, CDOT_LEN);
        DTYPE t = cur_t - endx;
        res = polyVal(endx, curves, index*CURVE_OFFSET, C_LEN) + v * t;
    }else{
        res = polyVal(endx, curves, index*CURVE_OFFSET, C_LEN);
    }
    return res;
}

__device__ DTYPE polyCurveDeriv1(DTYPE cur_t, DTYPE* curves, int index){
    DTYPE endx = curves[index*CURVE_OFFSET+CURVE_OFFSET-1];
    DTYPE res = 0;
    if( cur_t <= endx ){
        res = polyVal(cur_t, curves, index*CURVE_OFFSET+C_LEN, CDOT_LEN);
    }else{
        res = polyVal(endx, curves, index*CURVE_OFFSET+C_LEN, CDOT_LEN);
    }
    return res;
}

__device__ DTYPE polyCurveDeriv2(DTYPE cur_t, DTYPE* curves, int index){
    DTYPE endx = curves[index*CURVE_OFFSET+CURVE_OFFSET-1];
    DTYPE res = 0;
    if( cur_t <= endx ){
        res = polyVal(cur_t, curves, index*CURVE_OFFSET+C_LEN+CDOT_LEN, CDDOT_LEN);
    }else{
        res = polyVal(endx, curves, index*CURVE_OFFSET+C_LEN+CDOT_LEN, CDDOT_LEN);
    }
    return res;
}

__global__ void kernel(DTYPE* s_curves, DTYPE* d_curves, DTYPE* t_list, DTYPE* ref_x_curve, DTYPE* ref_y_curve, DTYPE* ref_theta_curve, DTYPE* s0, DTYPE* range, int* t_list_len, int* spline_xy_size, int* spline_theta_size, DTYPE* sample_t, 
        DTYPE* s_dot_list, DTYPE* s_ddot_list, DTYPE* d_list, DTYPE* pose_list, bool* is_valid){
    __shared__ DTYPE d0;
    if(threadIdx.x == 0){
        DTYPE s_real = polyCurveVal(t_list[0], s_curves, blockIdx.x, true);
        d0 = polyCurveVal(s_real-*s0, d_curves, blockIdx.y, false);
    }
    is_valid[blockIdx.x*gridDim.y+blockIdx.y] = 1;
    __syncthreads();
    //s
    DTYPE cur_t = t_list[threadIdx.x];
    DTYPE s_real = polyCurveVal(cur_t, s_curves, blockIdx.x, true);
    //s_real
    DTYPE s = s_real - *s0;
    //s_dot
    DTYPE s_dot = polyCurveDeriv1(cur_t, s_curves, blockIdx.x);
    //s_ddot
    DTYPE s_ddot = polyCurveDeriv2(cur_t, s_curves, blockIdx.x);
    //d
    DTYPE d = polyCurveVal(s, d_curves, blockIdx.y, false);
    //d_dot
    DTYPE d_dot = polyCurveDeriv1(s, d_curves, blockIdx.y);
    //d_ddot
    DTYPE d_ddot = polyCurveDeriv2(s, d_curves, blockIdx.y);

    DTYPE d_min = (d0 < range[0] ? d0 : range[0]);
    DTYPE d_max = (d0 > range[1] ? d0 : range[1]);
    if(d < d_min || d > d_max){
        is_valid[blockIdx.x*gridDim.y+blockIdx.y] = 0;
    }

    DTYPE ref_x = splineCurveVal(s_real, ref_x_curve, *spline_xy_size);
    DTYPE ref_y = splineCurveVal(s_real, ref_y_curve, *spline_xy_size);
    DTYPE ref_theta = splineCurveVal(s_real, ref_theta_curve, *spline_theta_size);
    DTYPE ref_x_dot = splineCurveDeriv1(s_real, ref_x_curve, *spline_xy_size);
    DTYPE ref_y_dot = splineCurveDeriv1(s_real, ref_y_curve, *spline_xy_size);
    DTYPE ref_theta_dot = splineCurveDeriv1(s_real, ref_theta_curve, *spline_theta_size);
    DTYPE ref_x_ddot = splineCurveDeriv2(s_real, ref_x_curve, *spline_xy_size);
    DTYPE ref_y_ddot = splineCurveDeriv2(s_real, ref_y_curve, *spline_xy_size);
    DTYPE ref_theta_ddot = splineCurveDeriv2(s_real, ref_theta_curve, *spline_theta_size);
    DTYPE sin_ref_theta = sinf(ref_theta);
    DTYPE cos_ref_theta = cosf(ref_theta);
    DTYPE x = ref_x + d*sin_ref_theta;
    DTYPE y = ref_y - d*cos_ref_theta;
    DTYPE x_dot = ref_x_dot + d_dot * sin_ref_theta + d * cos_ref_theta * ref_theta_dot;
    DTYPE y_dot = ref_y_dot - d_dot * cos_ref_theta + d * sin_ref_theta * ref_theta_dot;
    DTYPE x_ddot = ref_x_ddot + d_ddot * sin_ref_theta + d_dot * cos_ref_theta * ref_theta_dot + d_dot * cos_ref_theta * ref_theta_dot - d * sin_ref_theta * ref_theta_dot * ref_theta_dot + d * cos_ref_theta * ref_theta_ddot;
    DTYPE y_ddot = ref_y_ddot - d_ddot * cos_ref_theta + d_dot * sin_ref_theta * ref_theta_dot + d_dot * sin_ref_theta * ref_theta_dot + d * cos_ref_theta * ref_theta_dot * ref_theta_dot + d * sin_ref_theta * ref_theta_ddot;
    DTYPE theta = atan2f(y_dot, x_dot);
    DTYPE vel = s_dot;
    DTYPE acc = s_ddot;
    DTYPE curvature = (x_dot * y_ddot - y_dot * x_ddot) / powf(x_dot * x_dot + y_dot * y_dot, 1.5);
    int pos_save_index = ((blockIdx.x*gridDim.y+blockIdx.y)*(*t_list_len)+threadIdx.x)*POSE_OFFSET;
    int dot_save_index = ((blockIdx.x*gridDim.y+blockIdx.y)*(*t_list_len)+threadIdx.x);
    pose_list[pos_save_index+0] = *sample_t*threadIdx.x;
    pose_list[pos_save_index+1] = x;
    pose_list[pos_save_index+2] = y;
    pose_list[pos_save_index+3] = theta;
    pose_list[pos_save_index+4] = vel;
    pose_list[pos_save_index+5] = acc;
    pose_list[pos_save_index+6] = curvature;
    s_dot_list[dot_save_index] = s_dot;
    s_ddot_list[dot_save_index] = s_ddot;
    d_list[dot_save_index] = d;
}

void GpuCalculator::combineTrajectoriesGpu(const std::vector<double>& t_list_, double sample_t_, const ManeuverState &maneuver_state, const std::vector<Curve>& s_curves, const std::vector<Curve>& d_curves, const spline& ref_x_curve,const spline& ref_y_curve, const spline& ref_theta_curve, const av_msgs::Localize& localize, const double& s0, Range d_range, 
    std::vector<av_msgs::Trajectory >& trajectories, std::vector<Cost>& costs, double acceleration_normalization_, double jerk_normalization_, double curvature_normalization_) {

    trajectories.clear();
    costs.clear();

    uint64_t start = Now<uint64_t, std::nano>();
    const int s_curves_size = s_curves.size();
    const int d_curves_size = d_curves.size();
    const int t_size = t_list_.size();
    assert(ref_x_curve.m_x.size() == ref_x_curve.m_y.size());
    const int ref_xy_size = ref_x_curve.m_x.size();
    const int ref_theta_size = ref_theta_curve.m_x.size();
    const int ref_mem_xy_size = ref_xy_size*SPLINE_OFFSET + SPLINE_FIXLEN;
    const int ref_mem_theta_size = ref_theta_size*SPLINE_OFFSET + SPLINE_FIXLEN;
    const DTYPE sample_t = sample_t_;
    const DTYPE s0_f = s0;
    /*const int traj_num = s_curves_size*d_curves_size;*/
	/*trajectories.resize(traj_num);*/
	/*costs.resize(traj_num);*/
    /*cout << d_curves.size() << " " << d_curves[0].c_ddot.size() << " " << d_curves[40].c[1] << " " << d_curves[90].c_dot.size() <<endl;*/

    DTYPE* s_curves_list = new DTYPE[s_curves_size*(CURVE_OFFSET)];
    DTYPE* d_curves_list = new DTYPE[d_curves_size*(CURVE_OFFSET)];
    DTYPE* t_array = new DTYPE[t_size];
    DTYPE* ref_x_array = new DTYPE[ref_mem_xy_size];
    DTYPE* ref_y_array = new DTYPE[ref_mem_xy_size];
    DTYPE* ref_theta_array = new DTYPE[ref_mem_theta_size];
    DTYPE* d_range_list = new DTYPE[RANGE_OFFSET];

    toArrayCurves(s_curves, s_curves_list);
    toArrayCurves(d_curves, d_curves_list);
    toArrayTlist(t_list_, t_array);
    /*ref_x_curve.toArray(ref_x_array, ref_xy_size); */
    /*ref_y_curve.toArray(ref_y_array, ref_xy_size); */
    /*ref_theta_curve.toArray(ref_theta_array, ref_theta_size); */
    toArraySpline(ref_x_curve, ref_x_array, ref_xy_size);
    toArraySpline(ref_y_curve, ref_y_array, ref_xy_size);
    toArraySpline(ref_theta_curve, ref_theta_array, ref_theta_size);
    d_range_list[0] = d_range.min_value;
    d_range_list[1] = d_range.max_value;

    DTYPE* dev_s_curves;
    DTYPE* dev_d_curves;
    DTYPE* dev_t_array;
    DTYPE* dev_ref_x_curve;
    DTYPE* dev_ref_y_curve;
    DTYPE* dev_ref_theta_curve;
    DTYPE* dev_sample_t;
    DTYPE* dev_s0;
    DTYPE* dev_range;
    int* dev_t_array_len;
    int* dev_spline_xy_size;
    int* dev_spline_theta_size;
    //output
    DTYPE* dev_s_dot_list;
    DTYPE* dev_s_ddot_list;
    DTYPE* dev_d_list;
    DTYPE* dev_pose_list;
    bool* dev_is_valid;

    //input
    cudaMalloc( (void**)&dev_s_curves, s_curves_size*CURVE_OFFSET*sizeof(DTYPE) );
    cudaMalloc( (void**)&dev_d_curves, d_curves_size*CURVE_OFFSET*sizeof(DTYPE) );
    cudaMalloc( (void**)&dev_t_array, t_size*sizeof(DTYPE) );
    cudaMalloc( (void**)&dev_ref_x_curve, ref_mem_xy_size*sizeof(DTYPE) );
    cudaMalloc( (void**)&dev_ref_y_curve, ref_mem_xy_size*sizeof(DTYPE) );
    cudaMalloc( (void**)&dev_ref_theta_curve, ref_mem_theta_size*sizeof(DTYPE) );
    cudaMalloc( (void**)&dev_s0, sizeof(DTYPE));
    cudaMalloc( (void**)&dev_range, RANGE_OFFSET*sizeof(DTYPE));
    cudaMalloc( (void**)&dev_t_array_len, sizeof(int) );
    cudaMalloc( (void**)&dev_spline_xy_size, sizeof(int) );
    cudaMalloc( (void**)&dev_spline_theta_size, sizeof(int) );
    cudaMalloc( (void**)&dev_sample_t, sizeof(DTYPE) );
    //output
    cudaMalloc( (void**)&dev_s_dot_list, t_size*s_curves_size*d_curves_size*sizeof(DTYPE) );
    cudaMalloc( (void**)&dev_s_ddot_list, t_size*s_curves_size*d_curves_size*sizeof(DTYPE) );
    cudaMalloc( (void**)&dev_d_list, t_size*s_curves_size*d_curves_size*sizeof(DTYPE) );
    cudaMalloc( (void**)&dev_pose_list, t_size*s_curves_size*d_curves_size*POSE_OFFSET*sizeof(DTYPE) );
    cudaMalloc( (void**)&dev_is_valid, s_curves_size*d_curves_size*sizeof(bool) );

    cudaMemcpy( dev_s_curves, s_curves_list, s_curves_size*CURVE_OFFSET*sizeof(DTYPE), cudaMemcpyHostToDevice );
    cudaMemcpy( dev_d_curves, d_curves_list, d_curves_size*CURVE_OFFSET*sizeof(DTYPE), cudaMemcpyHostToDevice );
    cudaMemcpy( dev_t_array, t_array, t_size*sizeof(DTYPE), cudaMemcpyHostToDevice );
    cudaMemcpy( dev_ref_x_curve, ref_x_array, ref_mem_xy_size*sizeof(DTYPE), cudaMemcpyHostToDevice );
    cudaMemcpy( dev_ref_y_curve, ref_y_array, ref_mem_xy_size*sizeof(DTYPE), cudaMemcpyHostToDevice );
    cudaMemcpy( dev_ref_theta_curve, ref_theta_array, ref_mem_theta_size*sizeof(DTYPE), cudaMemcpyHostToDevice );
    cudaMemcpy( dev_s0, &s0_f, sizeof(DTYPE), cudaMemcpyHostToDevice );
    cudaMemcpy( dev_range, d_range_list, RANGE_OFFSET*sizeof(DTYPE), cudaMemcpyHostToDevice );
    cudaMemcpy( dev_t_array_len, &t_size, sizeof(int), cudaMemcpyHostToDevice );
    cudaMemcpy( dev_spline_xy_size, &ref_xy_size, sizeof(int), cudaMemcpyHostToDevice );
    cudaMemcpy( dev_spline_theta_size, &ref_theta_size, sizeof(int), cudaMemcpyHostToDevice );
    cudaMemcpy( dev_sample_t, &sample_t, sizeof(DTYPE), cudaMemcpyHostToDevice );

    dim3 grids(s_curves_size, d_curves_size);
    kernel<<<grids, t_size>>>(dev_s_curves, dev_d_curves, dev_t_array, dev_ref_x_curve, dev_ref_y_curve, dev_ref_theta_curve, dev_s0, dev_range, dev_t_array_len, dev_spline_xy_size, dev_spline_theta_size, dev_sample_t, 
            dev_s_dot_list, dev_s_ddot_list, dev_d_list, dev_pose_list, dev_is_valid);

    DTYPE* pos_list = new DTYPE[t_size*s_curves_size*d_curves_size*POSE_OFFSET];
    DTYPE* s_dot_list = new DTYPE[t_size*s_curves_size*d_curves_size];
    DTYPE* s_ddot_list = new DTYPE[t_size*s_curves_size*d_curves_size];
    DTYPE* d_list = new DTYPE[t_size*s_curves_size*d_curves_size];
    bool* is_valid = new bool[s_curves_size*d_curves_size];
    HANDLE_ERROR(cudaMemcpy( pos_list, dev_pose_list, t_size*s_curves_size*d_curves_size*POSE_OFFSET*sizeof(DTYPE), cudaMemcpyDeviceToHost ));
    HANDLE_ERROR(cudaMemcpy( s_dot_list, dev_s_dot_list, t_size*s_curves_size*d_curves_size*sizeof(DTYPE), cudaMemcpyDeviceToHost ));
    HANDLE_ERROR(cudaMemcpy( s_ddot_list, dev_s_ddot_list, t_size*s_curves_size*d_curves_size*sizeof(DTYPE), cudaMemcpyDeviceToHost ));
    HANDLE_ERROR(cudaMemcpy( d_list, dev_d_list, t_size*s_curves_size*d_curves_size*sizeof(DTYPE), cudaMemcpyDeviceToHost ));
    HANDLE_ERROR(cudaMemcpy( is_valid, dev_is_valid, s_curves_size*d_curves_size*sizeof(bool), cudaMemcpyDeviceToHost ));
    /*for (int j = 0; j < POSE_OFFSET; j++)*/
        /*cout << pos_list[POSE_OFFSET*((0*d_curves_size+0)*t_size+5)+j] << " ";*/
    cudaFree(dev_s_curves);
    cudaFree(dev_d_curves);
    cudaFree(dev_t_array);
    cudaFree(dev_ref_x_curve);
    cudaFree(dev_ref_y_curve);
    cudaFree(dev_ref_theta_curve);
    cudaFree(dev_s0);
    cudaFree(dev_range);
    cudaFree(dev_t_array_len);
    cudaFree(dev_spline_xy_size);
    cudaFree(dev_spline_theta_size);
    cudaFree(dev_sample_t);
    cudaFree(dev_s_dot_list);
    cudaFree(dev_s_ddot_list);
    cudaFree(dev_d_list);
    cudaFree(dev_pose_list);
    cudaFree(dev_is_valid);
    uint64_t end = Now<uint64_t, std::nano>();
    cout << end - start << endl;
    for(int i = 0; i < s_curves_size; i++){
        for(int j = 0; j < d_curves_size; j++){
            if(is_valid[i*d_curves_size+j]){
                Trajectory traj;
                vector<Pose> poses;
                vector<double> d_list_vec;
                vector<double> s_dot_list_vec;
                vector<double> s_ddot_list_vec;
                /*DTYPE d0 = d_list[(i*d_curves_size+j)*t_size+0];*/
                /*DTYPE d_min = (d0 < d_range.min_value ? d0 : d_range.min_value);*/
                /*DTYPE d_max = (d0 > d_range.max_value ? d0 : d_range.max_value);*/
                bool insert_flag = true;
                for(int k = 0; k < t_size; k++){
                    Pose pose;
                    int pose_index = ((i*d_curves_size+j)*t_size+k)*POSE_OFFSET;
                    pose.timestamp = pos_list[pose_index+0];
                    pose.x = pos_list[pose_index+1];
                    pose.y = pos_list[pose_index+2];
                    pose.theta = pos_list[pose_index+3];
                    pose.velocity = pos_list[pose_index+4];
                    pose.acceleration = pos_list[pose_index+5];
                    pose.curvature = pos_list[pose_index+6];
                    poses.push_back(pose);
                    int d_index = ((i*d_curves_size+j)*t_size+k);
                    /*if(d_list[d_index] < d_min || d_list[d_index] > d_max){*/
                        /*insert_flag = false;*/
                        /*break;*/
                    /*}*/
                    d_list_vec.push_back(d_list[d_index]);
                    s_dot_list_vec.push_back(s_dot_list[d_index]);
                    s_ddot_list_vec.push_back(s_ddot_list[d_index]);
                }
                if(insert_flag){
                    /*getTrajectoryInformation(poses, localize);*/
                    traj.poses = poses;
                    traj.driving_direction = 0;
                    traj.driving_state = 0;
			        Cost cost;
                    getTrajectoryCost(poses, d_list_vec, d_range, s_dot_list_vec, s_ddot_list_vec, maneuver_state, cost, acceleration_normalization_, jerk_normalization_, curvature_normalization_);
			        cost.time_cost = s_curves[i].terminal;
			        costs.push_back(cost);
			        trajectories.push_back(traj);
                }
            }
        }
    }
    delete[] s_curves_list;
    delete[] d_curves_list;
    delete[] t_array;
    delete[] ref_x_array;
    delete[] ref_y_array;
    delete[] ref_theta_array;
    delete[] d_range_list;

    delete[] pos_list;
    delete[] s_dot_list;
    delete[] s_ddot_list;
    delete[] d_list;
    delete[] is_valid;
}

