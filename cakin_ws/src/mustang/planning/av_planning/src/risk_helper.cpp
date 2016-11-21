#include <ros/ros.h>

#include <av_planning/risk_helper.h>

#include <vector>
#include <utility>
#include <cmath>
#include <algorithm>

using namespace av_planning;

RiskHelper::RiskHelper() {
    LoadConfiguration();
}

int RiskHelper::BoxCorner(const BoxModelPose &pose,
                          double resolution,
                          std::vector<RectangleCorner> &rectangle_corner_list) {
    const double PI = 3.1416;
    
    double x = pose.x;
    double y = pose.y;   
    double theta = 90 - pose.theta * 180.0 / PI;
    double a = pose.length;
    double b = pose.width;
    
    x = x / resolution;
    y = y / resolution;
    a = a / resolution;
    b = b / resolution;

    double d = std::sqrt(a * a + b * b);
    double alpha = std::atan(b / a) / PI * 180.0;
    double beta = alpha - theta;
    double gama = 90 - (alpha + theta);

    double x1 = x + d / 2 * sind(beta);
    double y1 = y - d / 2 * cosd(beta);
    double x3 = x - d / 2 * sind(beta);
    double y3 = y + d / 2 * cosd(beta);
    double x2 = x - d / 2 * cosd(gama);
    double y2 = y - d / 2 * sind(gama);
    double x4 = x + d / 2 * cosd(gama);
    double y4 = y + d / 2 * sind(gama);

    // TODO draw box in python to check 

    // Decomposition of vehicle shape into disks
    double n = std::ceil(a / b);
    double r = std::sqrt(2.0) * b / 2;
    
    std::vector<std::pair<double, double> > center_list(n, std::make_pair(0.0, 0.0));
    
    if(n >= 1) {
        double r2_x = x3 + r * sind(45 - theta);
        double r2_y = y3 - r * cosd(45 - theta);
        center_list[n - 1].first = r2_x;
        center_list[n - 1].second = r2_y;
    }
    if(n >= 2) {
        double r1_x = x1 - r * sind(45 - theta);
        double r1_y = y1 + r * cosd(45 - theta);
        center_list[0].first = r1_x;
        center_list[0].second = r1_y;
    }
    if(n >= 3) {
        double tmp_d = (a - b) / (n - 1);
        for(int k = 1; k <= n - 2; ++k) {
            center_list[k].first = center_list[n - 1].first - k * tmp_d * sind(theta);
            center_list[k].second = center_list[n - 1].second - k * tmp_d * cosd(theta); 
        }
    }
    std::vector<std::vector<int> > offside_list;
    GetRectanglesOffside(std::ceil(r), offside_list);
    
    for(int i = 0; i < n; ++i) {
        double x = center_list[i].first;
        double y = center_list[i].second;
        for(auto iter = offside_list.begin(); iter != offside_list.end(); ++iter) {
            double x2 = x + iter->at(0);
            double y2 = y + iter->at(1);
            double x4 = x + iter->at(2);
            double y4 = y + iter->at(3);
            double x1 = x4;
            double y1 = y2;
            double x3 = x2;
            double y3 = y4;

            double trans_x1, trans_x2, trans_x3, trans_x4;
            double trans_y1, trans_y2, trans_y3, trans_y4;
            TranslateCoordinate(x1, y1, resolution, trans_x1, trans_y1);
            TranslateCoordinate(x2, y2, resolution, trans_x2, trans_y2);
            TranslateCoordinate(x3, y3, resolution, trans_x3, trans_y3);
            TranslateCoordinate(x4, y4, resolution, trans_x4, trans_y4);
            
            RectangleCorner rectangle_corner;
            rectangle_corner.x_max = std::max(trans_x1, std::max(trans_x2, std::max(trans_x3, trans_x4)));
            rectangle_corner.x_max = BoundDigital(int(rectangle_corner.x_max), x_lhs_bound_, x_rhs_bound_);

            rectangle_corner.x_min = std::min(trans_x1, std::min(trans_x2, std::min(trans_x3, trans_x4)));
            rectangle_corner.x_min = BoundDigital(int(rectangle_corner.x_min), x_lhs_bound_, x_rhs_bound_);
            
            rectangle_corner.y_max = std::max(trans_y1, std::max(trans_y2, std::max(trans_y3, trans_y4)));
            rectangle_corner.y_max = BoundDigital(int(rectangle_corner.y_max), y_lhs_bound_, y_rhs_bound_);
            
            rectangle_corner.y_min = std::min(trans_y1, std::min(trans_y2, std::min(trans_y3, trans_y4)));
            rectangle_corner.y_min = BoundDigital(int(rectangle_corner.y_min), y_lhs_bound_, y_rhs_bound_);
            
            rectangle_corner_list.push_back(rectangle_corner);
        }
    }

    return 0;
}

int RiskHelper::BoundDigital(int ori_num, int lhs, int rhs) {
    if(ori_num < lhs) {
        ori_num = lhs;
    }
    if(ori_num > rhs) {
        ori_num = rhs;
    }
    return ori_num;
}

void RiskHelper::TranslateCoordinate(double x, double y, double resolution, double &trans_x, double &trans_y) {
    trans_x = -y + ori_y_ / resolution;
    trans_y = x + ori_x_ / resolution; 
}

void RiskHelper::GetRectanglesOffside(int r, std::vector<std::vector<int> > &offside_list) {
    int F = 1-r;
    int x = r;
    int y = 0;
    int delta_up_left = -2 * r;
    int delta_up = 1;
    while(y <= x) {
        if(F >= 0) {
            x = x - 1;
            offside_list.push_back({-x, -y, x, y});
            offside_list.push_back({-y, -x, y, x});
            delta_up_left = delta_up_left + 2;
            F = F + delta_up_left;
        }
        y = y + 1;
        delta_up = delta_up + 2;
        F = F + delta_up;
    }
}

double RiskHelper::sind(double x) {
    return std::sin((x) * 3.1416 / 180);
}

double RiskHelper::cosd(double x) {
    return std::cos((x) * 3.1416 / 180);
}

void RiskHelper::LoadConfiguration() { 
    ros::param::get("~/risk_helper/ori_x", ori_x_);
    ros::param::get("~/risk_helper/ori_y", ori_y_);
    ros::param::get("~/risk_helper/x_lhs_bound", x_lhs_bound_);
    ros::param::get("~/risk_helper/x_rhs_bound", x_rhs_bound_);
    ros::param::get("~/risk_helper/y_lhs_bound", y_lhs_bound_);
    ros::param::get("~/risk_helper/y_rhs_bound", y_rhs_bound_);
}
