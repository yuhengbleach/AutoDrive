#include<ros/ros.h>
#include<av_control/state_fir_filter.h>

using namespace std;
using namespace av_control;

StateFirFilter::StateFirFilter(){
        double x_filter_gain, y_filter_gain, ang_filter_gain, vel_x_filter_gain, vel_y_filter_gain, vel_ang_filter_gain, acc_x_filter_gain, acc_y_filter_gain, acc_ang_filter_gain;
        double acc_pedal_filter_gain, brake_pedal_filter_gain, steering_angle_filter_gain;

        std::vector<double> x_filter_coef, y_filter_coef, ang_filter_coef, vel_x_filter_coef, vel_y_filter_coef, vel_ang_filter_coef, acc_x_filter_coef, acc_y_filter_coef, acc_ang_filter_coef;
        std::vector<double> acc_pedal_filter_coef, brake_pedal_filter_coef, steering_angle_filter_coef;

        XmlRpc::XmlRpcValue x_filter_coef_value, y_filter_coef_value, ang_filter_coef_value, vel_x_filter_coef_value, vel_y_filter_coef_value, vel_ang_filter_coef_value, acc_x_filter_coef_value, acc_y_filter_coef_value, acc_ang_filter_coef_value;
        XmlRpc::XmlRpcValue acc_pedal_filter_coef_value, brake_pedal_filter_coef_value, steering_angle_filter_coef_value;

        ros::param::get("~state_fir_filter/x_filter_gain", x_filter_gain);
        ros::param::get("~state_fir_filter/y_filter_gain", y_filter_gain);
        ros::param::get("~state_fir_filter/ang_filter_gain", ang_filter_gain);
        ros::param::get("~state_fir_filter/vel_x_filter_gain", vel_x_filter_gain);
        ros::param::get("~state_fir_filter/vel_y_filter_gain", vel_y_filter_gain);
        ros::param::get("~state_fir_filter/vel_ang_filter_gain", vel_ang_filter_gain);
        ros::param::get("~state_fir_filter/acc_x_filter_gain", acc_x_filter_gain);
        ros::param::get("~state_fir_filter/acc_y_filter_gain", acc_y_filter_gain);
        ros::param::get("~state_fir_filter/acc_ang_filter_gain", acc_ang_filter_gain);
        ros::param::get("~state_fir_filter/x_filter_coef", x_filter_coef_value);
        ros::param::get("~state_fir_filter/y_filter_coef", y_filter_coef_value);
        ros::param::get("~state_fir_filter/ang_filter_coef", ang_filter_coef_value);
        ros::param::get("~state_fir_filter/vel_x_filter_coef", vel_x_filter_coef_value);
        ros::param::get("~state_fir_filter/vel_y_filter_coef", vel_y_filter_coef_value);
        ros::param::get("~state_fir_filter/vel_ang_filter_coef", vel_ang_filter_coef_value);
        ros::param::get("~state_fir_filter/acc_x_filter_coef", acc_x_filter_coef_value);
        ros::param::get("~state_fir_filter/acc_y_filter_coef", acc_y_filter_coef_value);
        ros::param::get("~state_fir_filter/acc_ang_filter_coef", acc_ang_filter_coef_value);


        ros::param::get("~state_fir_filter/acc_pedal_filter_gain", acc_pedal_filter_gain);
        ros::param::get("~state_fir_filter/acc_pedal_filter_coef", acc_pedal_filter_coef_value);
        ros::param::get("~state_fir_filter/brake_pedal_filter_gain", brake_pedal_filter_gain);
        ros::param::get("~state_fir_filter/brake_pedal_filter_coef", brake_pedal_filter_coef_value);
        ros::param::get("~state_fir_filter/steering_angle_filter_gain", steering_angle_filter_gain);
        ros::param::get("~state_fir_filter/steering_angle_filter_coef", steering_angle_filter_coef_value);

        
        for(int i = 0; i < x_filter_coef_value.size(); i++) { 
                ROS_ASSERT(x_filter_coef_value[i].getType() == XmlRpc::XmlRpcValue::TypeDouble);
                x_filter_coef.push_back(static_cast<double>(x_filter_coef_value[i]));
        }     
         for(int i = 0; i < y_filter_coef_value.size(); i++) { 
                ROS_ASSERT(y_filter_coef_value[i].getType() == XmlRpc::XmlRpcValue::TypeDouble);
                y_filter_coef.push_back(static_cast<double>(y_filter_coef_value[i]));
        }       
         for(int i = 0; i < ang_filter_coef_value.size(); i++) { 
                ROS_ASSERT(ang_filter_coef_value[i].getType() == XmlRpc::XmlRpcValue::TypeDouble);
                ang_filter_coef.push_back(static_cast<double>(ang_filter_coef_value[i]));
        }       
         for(int i = 0; i < vel_x_filter_coef_value.size(); i++) { 
                ROS_ASSERT(vel_x_filter_coef_value[i].getType() == XmlRpc::XmlRpcValue::TypeDouble);
                vel_x_filter_coef.push_back(static_cast<double>(vel_x_filter_coef_value[i]));
        }       
         for(int i = 0; i < vel_y_filter_coef_value.size(); i++) { 
                ROS_ASSERT(vel_y_filter_coef_value[i].getType() == XmlRpc::XmlRpcValue::TypeDouble);
                vel_y_filter_coef.push_back(static_cast<double>(vel_y_filter_coef_value[i]));
        }       
         for(int i = 0; i < vel_ang_filter_coef_value.size(); i++) { 
                ROS_ASSERT(vel_ang_filter_coef_value[i].getType() == XmlRpc::XmlRpcValue::TypeDouble);
                vel_ang_filter_coef.push_back(static_cast<double>(vel_ang_filter_coef_value[i]));
        }       
         for(int i = 0; i < acc_x_filter_coef_value.size(); i++) { 
                ROS_ASSERT(acc_x_filter_coef_value[i].getType() == XmlRpc::XmlRpcValue::TypeDouble);
                acc_x_filter_coef.push_back(static_cast<double>(acc_x_filter_coef_value[i]));
        }       
         for(int i = 0; i < acc_y_filter_coef_value.size(); i++) { 
                ROS_ASSERT(acc_y_filter_coef_value[i].getType() == XmlRpc::XmlRpcValue::TypeDouble);
                acc_y_filter_coef.push_back(static_cast<double>(acc_y_filter_coef_value[i]));
        }       
         for(int i = 0; i < acc_ang_filter_coef_value.size(); i++) { 
                ROS_ASSERT(acc_ang_filter_coef_value[i].getType() == XmlRpc::XmlRpcValue::TypeDouble);
                acc_ang_filter_coef.push_back(static_cast<double>(acc_ang_filter_coef_value[i]));
        }    

         for(int i = 0; i < acc_pedal_filter_coef_value.size(); i++) {
                ROS_ASSERT(acc_pedal_filter_coef_value[i].getType() == XmlRpc::XmlRpcValue::TypeDouble);
                acc_pedal_filter_coef.push_back(static_cast<double>(acc_pedal_filter_coef_value[i]));
        }
         for(int i = 0; i < brake_pedal_filter_coef_value.size(); i++) {
                ROS_ASSERT(brake_pedal_filter_coef_value[i].getType() == XmlRpc::XmlRpcValue::TypeDouble);
                brake_pedal_filter_coef.push_back(static_cast<double>(brake_pedal_filter_coef_value[i]));
        }
         for(int i = 0; i < steering_angle_filter_coef_value.size(); i++) {
                ROS_ASSERT(steering_angle_filter_coef_value[i].getType() == XmlRpc::XmlRpcValue::TypeDouble);
                steering_angle_filter_coef.push_back(static_cast<double>(steering_angle_filter_coef_value[i]));
        }

        x_filter_ptr_ = std::move(std::unique_ptr<FIRFilter> (new FIRFilter(x_filter_gain, x_filter_coef)));
        y_filter_ptr_ = std::move(std::unique_ptr<FIRFilter> (new FIRFilter(y_filter_gain, y_filter_coef)));
        ang_filter_ptr_ = std::move(std::unique_ptr<FIRFilter> (new FIRFilter(ang_filter_gain, ang_filter_coef)));
        vel_x_filter_ptr_ = std::move(std::unique_ptr<FIRFilter> (new FIRFilter(vel_x_filter_gain, vel_x_filter_coef)));
        vel_y_filter_ptr_ = std::move(std::unique_ptr<FIRFilter> (new FIRFilter(vel_y_filter_gain, vel_y_filter_coef)));
        vel_ang_filter_ptr_ = std::move(std::unique_ptr<FIRFilter> (new FIRFilter(vel_ang_filter_gain, vel_ang_filter_coef)));
        acc_x_filter_ptr_ = std::move(std::unique_ptr<FIRFilter> (new FIRFilter(acc_x_filter_gain, acc_x_filter_coef)));
        acc_y_filter_ptr_ = std::move(std::unique_ptr<FIRFilter> (new FIRFilter(acc_y_filter_gain, acc_y_filter_coef)));
        acc_ang_filter_ptr_ = std::move(std::unique_ptr<FIRFilter> (new FIRFilter(acc_ang_filter_gain, acc_ang_filter_coef)));    

        acc_pedal_filter_ptr_ = std::move(std::unique_ptr<FIRFilter> (new FIRFilter(acc_pedal_filter_gain, acc_pedal_filter_coef)));
        brake_pedal_filter_ptr_ = std::move(std::unique_ptr<FIRFilter> (new FIRFilter(brake_pedal_filter_gain, brake_pedal_filter_coef)));
        steering_angle_filter_ptr_ = std::move(std::unique_ptr<FIRFilter> (new FIRFilter(steering_angle_filter_gain, steering_angle_filter_coef)));
}

void StateFirFilter::Process(VehicleState& vehicle_state, bool clear_filter){
   if(clear_filter){
        x_filter_ptr_ -> clear();
        y_filter_ptr_ -> clear();
        ang_filter_ptr_ -> clear();
        vel_x_filter_ptr_ -> clear();
        vel_y_filter_ptr_ -> clear();
        vel_ang_filter_ptr_ -> clear();
        acc_x_filter_ptr_ -> clear();
        acc_y_filter_ptr_ -> clear();
        acc_ang_filter_ptr_ -> clear();
    } 
    vehicle_state.x = x_filter_ptr_ -> process(vehicle_state.x);
    vehicle_state.y = y_filter_ptr_ -> process(vehicle_state.y);
    vehicle_state.ang = ang_filter_ptr_ -> process(vehicle_state.ang);
    
    vehicle_state.vel_x = vel_x_filter_ptr_ -> process(vehicle_state.vel_x);    
    vehicle_state.vel_y = vel_y_filter_ptr_ -> process(vehicle_state.vel_y);    
    vehicle_state.vel_ang = vel_ang_filter_ptr_ -> process(vehicle_state.vel_ang);    

    vehicle_state.acc_x = acc_x_filter_ptr_ -> process(vehicle_state.acc_x);    
    vehicle_state.acc_y = acc_y_filter_ptr_ -> process(vehicle_state.acc_y);    
    vehicle_state.acc_ang = acc_ang_filter_ptr_ -> process(vehicle_state.acc_ang);    
}




void StateFirFilter::SignalProcess(double &acc_pedal, double &brake_pedal, double &steering_angle, bool clear_filter){
   if(clear_filter){
        acc_pedal_filter_ptr_ -> clear();
        brake_pedal_filter_ptr_  -> clear();
        steering_angle_filter_ptr_ -> clear();
    }

    acc_pedal = acc_pedal_filter_ptr_ -> process(acc_pedal);
    brake_pedal = brake_pedal_filter_ptr_ -> process(brake_pedal);
    steering_angle = steering_angle_filter_ptr_ -> process(steering_angle);
}


       
