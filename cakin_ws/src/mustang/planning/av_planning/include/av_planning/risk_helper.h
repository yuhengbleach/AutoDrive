#ifndef MUSTANG_AV_PLANNING_RISK_HELPER_H
#define MUSTANG_AV_PLANNING_RISK_HELPER_H

#include <vector>

namespace av_planning {

struct RiskIndex {
    bool is_collision;
    double collision_probability;
    double collision_x;
    double collision_y;
    double collision_theta;
    int collision_time; // ms
};

struct BoxModelPose {
    double x;
    double y;
    double theta;
    int propagation_time; 
    double width;
    double length;
};

struct RectangleCorner {
    double x_max;
    double x_min;
    double y_max;
    double y_min;
};

class RiskHelper {
public:
    RiskHelper();

public:
    // return the corner matrix represent vehicle shape at time T  
    int BoxCorner(const BoxModelPose &pose, 
                  double resolution,
                  std::vector<RectangleCorner> &rectangle_corner_list);

private:
    void LoadConfiguration();   

    // Decomposition of disks into axis aligned rectangles
    void GetRectanglesOffside(int r, std::vector<std::vector<int> > &offside_list);
    void TranslateCoordinate(double x, double y, double resolution, double &trans_x, double &trans_y);

    double sind(double x);
    double cosd(double x);
    
    int BoundDigital(int ori_num, int lhs, int rhs);

private:
    // for coordinate translation
    double ori_x_;
    double ori_y_;

    // static map bound
    int x_lhs_bound_;
    int x_rhs_bound_;
    int y_lhs_bound_;
    int y_rhs_bound_;

};

} // namespace av_planning

#endif // MUSTANG_AV_PLANNING_RISK_HELPER_H
