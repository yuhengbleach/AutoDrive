#include <av_planning/prepare.h>
#include <algorithm>
#include <cmath>
#include <sys/time.h>

namespace av_planning {

Prepare::Prepare() {
    ros::param::get("~/prepare/threshold_lane_confidence", threshold_lane_confidence_);
    ros::param::get("~/traffic_propogation_resolution", traffic_propogation_resolution_);
    ros::param::get("~/prepare/threshold_line_combination", threshold_line_combination_);
    ros::param::get("~/prepare/interp_delta_length", interp_delta_length_);
    ros::param::get("~/prepare/interp_delta_angle", interp_delta_angle_);
    ros::param::get("~/prepare/localize_timedelta", localize_timedelta_);
    ros::param::get("~/prepare/traffic_light_timedelta", traffic_light_timedelta_);
}

void Prepare::SetFusionMapTimestamp(const av_msgs::FusionMap &fusion_map) {
    fusion_map_timestamp_ = fusion_map.timestamp;
}

void Prepare::SetDestTimestamp(av_msgs::Dest &dest) {
    dest_timestamp_ = 0;
    dest.x = 0;
    dest.y = 0;
}

void Prepare::SetLocalizeTimestamp(const av_msgs::Localize &localize) {
    localize_timestamp_ = localize.timestamp;
}

void Prepare::SetTrafficLightTimestamp(const av_msgs::TrafficLightDetect &traffic_light) {
    traffic_light_timestamp_ = traffic_light.timestamp;
}

enum ErrorCode Prepare::CheckFusionMapMsgs(const av_msgs::FusionMap &fusion_map) {
    if (fusion_map_timestamp_ == fusion_map.timestamp) {
        return ERROR;
    }
    fusion_map_timestamp_ = fusion_map.timestamp;
    return SUCCESS;
}

enum ErrorCode Prepare::CheckDestMsgs(const av_msgs::Dest &dest) {
    if (dest.timestamp == 0 && dest.x == 0 && dest.y == 0) {
        return ERROR;
    }
    return SUCCESS;
}

enum ErrorCode Prepare::CheckLocalizeMsgs(const av_msgs::Localize &localize) {
    long long current_time_span = std::abs(fusion_map_timestamp_ - localize_timestamp_);
    if (localize_timestamp_ == localize.timestamp && current_time_span > localize_timedelta_) {
        return ERROR;       
    }
    localize_timestamp_ = localize.timestamp;
    return SUCCESS;
}

enum ErrorCode Prepare::CheckTrafficLightMsgs(av_msgs::TrafficLightDetect &traffic_light) {
    long long current_time_span = std::abs(fusion_map_timestamp_ - traffic_light_timestamp_);
    if (traffic_light.tl_det_list.size() != 0 && traffic_light.timestamp == traffic_light_timestamp_ && current_time_span > traffic_light_timedelta_){
        traffic_light.tl_det_list.clear();
        return ERROR;
    }
    traffic_light_timestamp_ = traffic_light.timestamp;
    return SUCCESS;
}

// coordinate system conversion
void Prepare::TranslateFusionMap(av_msgs::FusionMap &fusion_map) {
    // ego theta
    double x_ego = fusion_map.pose.x;
    double y_ego = fusion_map.pose.y;
    double theta_ego = fusion_map.pose.theta;
    TranslatePose(x_ego, y_ego, theta_ego);
    fusion_map.pose.theta = theta_ego;
    //std::cout << "x_ego:" << x_ego << " y_ego:" << y_ego << " theta_ego:" << theta_ego << std::endl;
    // translate lane
    for(auto iter_section = fusion_map.section_list.begin(); iter_section != fusion_map.section_list.end(); ++iter_section) {
        for(auto iter_lane_marker = iter_section->lane_marker_list.begin(); iter_lane_marker != iter_section->lane_marker_list.end(); ++iter_lane_marker) {
            for(auto iter_waypoint = iter_lane_marker->waypoints.begin(); iter_waypoint != iter_lane_marker->waypoints.end(); ++iter_waypoint) {
                //TranslatePose(iter_waypoint->x, iter_waypoint->y);
                TranslateEgo(x_ego, y_ego, theta_ego, iter_waypoint->x, iter_waypoint->y);
                // std::cout << "lane x:" << iter_waypoint->x << " y:" << iter_waypoint->y << std::endl;
            }
            // std::cout << "section end" << std::endl;
        }
    }
    // translate obstacle map
    fusion_map.obstacle_map.length = fusion_map.obstacle_map.length / 10;
    fusion_map.obstacle_map.width = fusion_map.obstacle_map.width / 10;
    // translate dynamic obstacle coordinate
    //std::cout << "total " << fusion_map.dynamic_object_list.size() << " dynamic object" << std::endl;
    for(auto dynamic_object_iter = fusion_map.dynamic_object_list.begin(); dynamic_object_iter != fusion_map.dynamic_object_list.end(); ++dynamic_object_iter) {
        double center_x = dynamic_object_iter->center_x;
        double center_y = dynamic_object_iter->center_y;
        TranslateEgo(x_ego, y_ego, theta_ego, center_x, center_y);
        dynamic_object_iter->center_x = center_x;
        dynamic_object_iter->center_y = center_y;
        dynamic_object_iter->heading = dynamic_object_iter->heading - theta_ego; 
    }
}

// for prescan simulation
// TODO coordinate system conversion
void Prepare::TranslateFusionMapPrescan(av_msgs::FusionMap &fusion_map) {
    // ego theta
    double x_ego = fusion_map.pose.x;
    double y_ego = fusion_map.pose.y;
    double theta_ego = fusion_map.pose.theta;
    //TranslatePose(x_ego, y_ego, theta_ego);
    fusion_map.pose.theta = theta_ego;
    // std::cout << "x_ego:" << x_ego << " y_ego:" << y_ego << " theta_ego:" << theta_ego << std::endl;
    // translate lane
    for(auto iter_section = fusion_map.section_list.begin(); iter_section != fusion_map.section_list.end(); ++iter_section) {
        // std::cout << "section_type is:(" << int(iter_section->section_type)  << ")..." << std::endl;
        for(auto iter_lane_marker = iter_section->lane_marker_list.begin(); iter_lane_marker != iter_section->lane_marker_list.end(); ++iter_lane_marker) {
            // std::cout << "paint type is:(" << int(iter_lane_marker->paint_type) << ")..." << std::endl;
            for(auto iter_waypoint = iter_lane_marker->waypoints.begin(); iter_waypoint != iter_lane_marker->waypoints.end(); ++iter_waypoint) {
                TranslateEgo(x_ego, y_ego, theta_ego, iter_waypoint->x, iter_waypoint->y);
                // std::cout << "lane x:" << iter_waypoint->x << " y:" << iter_waypoint->y << std::endl;
            }
            // std::cout << "lane marker end" << std::endl;
        }
    }
}

void Prepare::TranslatePose(double &x, double &y, double &theta) {
    //double tmp = x;
    //x = y;
    //y = tmp;
    theta = (3.1415926 / 2 -theta );
}

void Prepare::TranslatePose(double &x, double &y) {
    return;
    //double tmp = x;
    //x = y;
    //y = -tmp;
}

void Prepare::TranslateEgo(double x_ego, double y_ego, double theta_ego, double &x, double &y) {
    double x_ori = x - x_ego;
    double y_ori = y - y_ego;
    x = x_ori * std::cos(theta_ego) + y_ori * std::sin(theta_ego);
    y = - x_ori * std::sin(theta_ego) + y_ori * std::cos(theta_ego);
}

void Prepare::PreprocessFusionMap(const av_msgs::FusionMap &fusion_map, Path &path, PlanningFusionMap &planning_fusion_map) {
    //preprocess lane list to get parameter form
        
    struct timeval tv1,tv2;
    struct timezone tz1, tz2;
    double timeuse;
    gettimeofday(&tv1, &tz1);
    int current_section_id = path.GetSectionIndex(fusion_map.pose.x , fusion_map.pose.y).first;
    PrepareLaneList(fusion_map.section_list, current_section_id, planning_fusion_map.lane_group_list);
    gettimeofday(&tv2, &tz2);
    timeuse = tv2.tv_sec - tv1.tv_sec + (tv2.tv_usec - tv1.tv_usec)/1000000.0;
    ROS_INFO("lane use time:%f", timeuse);
    
    
    gettimeofday(&tv1, &tz1);
    //preprocess static obstacle to get 2 dim form
    PrepareStaticObstacleMap(fusion_map.obstacle_map, planning_fusion_map.static_obstacle_map);
    gettimeofday(&tv2, &tz2);
    timeuse = tv2.tv_sec - tv1.tv_sec + (tv2.tv_usec - tv1.tv_usec)/1000000.0;
    ROS_INFO("static map use time:%f", timeuse);
    
    
    gettimeofday(&tv1, &tz1);
    PrepareLowResolutionStaticObstacleMap(planning_fusion_map.static_obstacle_map, planning_fusion_map.low_resolution_static_obstacle_map);
    planning_fusion_map.dynamic_object_list = fusion_map.dynamic_object_list;    
    gettimeofday(&tv2, &tz2);
    timeuse = tv2.tv_sec - tv1.tv_sec + (tv2.tv_usec - tv1.tv_usec)/1000000.0;
    ROS_INFO("static map use time:%f", timeuse);
}

void Prepare::PrepareLaneList(const std::vector<av_msgs::SectionList>& section_list, const int current_section_id, std::vector<LaneGroup>& lane_group_list) {
	lane_group_list.clear();
    ROS_INFO("preparing lane list, section list size: %d", int(section_list.size()));
     
    struct timeval tv1,tv2;
    struct timezone tz1, tz2;
    double timeuse;
    gettimeofday(&tv1, &tz1);
    
    std::vector<av_msgs::SectionList>::const_iterator iter_section = section_list.begin();
	std::vector<std::vector<Lane> > lane_list;
	while(iter_section < section_list.end()) {
		std::vector<Lane> local_lane_list;
		if (iter_section->section_type == 0) {
            continue;
        }
        PrepareLocalLaneList(iter_section, section_list.end(), local_lane_list);
		lane_list.push_back(local_lane_list);
		++iter_section;
	}
    
    gettimeofday(&tv2, &tz2);
    timeuse = tv2.tv_sec - tv1.tv_sec + (tv2.tv_usec - tv1.tv_usec)/1000000.0;
    ROS_INFO("lane param use time:%f", timeuse);
    ROS_INFO("current section id:%d", current_section_id);   
    gettimeofday(&tv1, &tz1);
    
    int lane_label = 0;
    int current_lane_label = 0;
    double min_dist = 1e6, min_lane_label = 0;
    for (int cur_lane_index = 0; cur_lane_index < lane_list[current_section_id].size(); ++ cur_lane_index) {
        LaneGroup lane_group;
		lane_group.label = lane_label++;
        double temp_s = 0, temp_dist = 0;
        spline::getClosestPointOnCurve(lane_list[current_section_id][cur_lane_index].ref_line.curve_x, lane_list[current_section_id][cur_lane_index].ref_line.curve_y, 0, 0, temp_s, temp_dist);
        if(temp_dist < min_dist) {
            min_dist = temp_dist;
            min_lane_label = lane_group.label;
        }
        
        std::vector<Lane>group_lanes;
        if (current_section_id == 0) {
            group_lanes.push_back(lane_list[0][cur_lane_index]);
        } else {
            group_lanes = lane_list[0];
        }
        for (int section_index = 1; section_index < lane_list.size(); ++ section_index) {
            std::vector<Lane> temp_lanes;
            for (int group_lane_index = 0; group_lane_index < group_lanes.size(); ++ group_lane_index) {
                if (section_index != current_section_id) {
                    for (int section_lane_index = 0; section_lane_index < lane_list[section_index].size(); ++ section_lane_index) {
                        Lane lane;
    	    		    PrepareLocalLaneCombination(group_lanes[group_lane_index], lane_list[section_index][section_lane_index], lane);
                        temp_lanes.push_back(std::move(lane));
                    }
                } else {
                    Lane lane;
    	            PrepareLocalLaneCombination(group_lanes[group_lane_index], lane_list[current_section_id][cur_lane_index], lane);
                    temp_lanes.push_back(std::move(lane));
                }
            }
            //group_lanes.swap(temp_lanes);
            group_lanes = std::move(temp_lanes);
        }
        lane_group.lanes = std::move(group_lanes);
        lane_group_list.push_back(std::move(lane_group));
    } 
     
    gettimeofday(&tv2, &tz2);
    timeuse = tv2.tv_sec - tv1.tv_sec + (tv2.tv_usec - tv1.tv_usec)/1000000.0;
    ROS_INFO("lane combine  use time:%f", timeuse);
    
    ROS_INFO("lane group list size: %d, minimum distance: %f", int(lane_group_list.size()), min_dist);
    for (int index = 0; index < lane_group_list.size(); ++ index) {
        lane_group_list[index].label -= min_lane_label;
    }
    
}

void Prepare::PrepareLocalLaneList(std::vector<av_msgs::SectionList>::const_iterator& iter_section, const std::vector<av_msgs::SectionList>::const_iterator& iter_section_end, std::vector<Lane>& lane_list) {
	lane_list.clear();
	std::vector<av_msgs::SectionList>::const_iterator iter_section_begin = iter_section;
	std::vector<av_msgs::LaneMarker>::const_iterator iter_lane_marker, iter_lane_marker_right;
	for(iter_lane_marker = iter_section_begin->lane_marker_list.begin(); iter_lane_marker != iter_section_begin->lane_marker_list.end()-1; ++iter_lane_marker) {
		std::vector<double> left_xs, left_ys, right_xs, right_ys;
		iter_lane_marker_right = iter_lane_marker + 1;
		std::vector<av_msgs::WayPoint>::const_iterator iter_way_points;
		for(iter_way_points = iter_lane_marker->waypoints.begin(); iter_way_points != iter_lane_marker->waypoints.end(); ++iter_way_points) {
			left_xs.push_back(static_cast<double>(iter_way_points->x));	
			left_ys.push_back(static_cast<double>(iter_way_points->y));	
		}
		for(iter_way_points = iter_lane_marker_right->waypoints.begin(); iter_way_points != iter_lane_marker_right->waypoints.end(); ++iter_way_points) {
			right_xs.push_back(static_cast<double>(iter_way_points->x));
			right_ys.push_back(static_cast<double>(iter_way_points->y));
		}
		av_msgs::WayPoint left_last_way_point = *(iter_lane_marker->waypoints.end()-1);
		av_msgs::WayPoint right_last_way_point = *(iter_lane_marker_right->waypoints.end()-1);
		iter_section = iter_section_begin + 1;
		while(iter_section != iter_section_end) {
			if(iter_section->section_type == 1) { // road
				std::vector<av_msgs::LaneMarker>::const_iterator iter_lane_marker_temp = iter_section->lane_marker_list.begin();
				for(iter_lane_marker_temp = iter_section->lane_marker_list.begin(); iter_lane_marker_temp != iter_section->lane_marker_list.end(); iter_lane_marker_temp++) {
					std::vector<av_msgs::WayPoint>::const_iterator iter_way_points_temp = iter_lane_marker_temp->waypoints.begin();
					if(fabs(left_last_way_point.x - iter_way_points_temp->x)+fabs(left_last_way_point.y - iter_way_points_temp->y) < threshold_line_combination_) {
						for(;iter_way_points_temp != iter_lane_marker_temp->waypoints.end(); ++iter_way_points_temp) {
							left_xs.push_back(static_cast<double>(iter_way_points_temp->x));
							left_ys.push_back(static_cast<double>(iter_way_points_temp->y));
						}
						left_last_way_point = *(iter_lane_marker_temp->waypoints.end()-1);
					} else if(fabs(right_last_way_point.x - iter_way_points_temp->x)+fabs(right_last_way_point.y - iter_way_points_temp->y) < threshold_line_combination_) {
						for(;iter_way_points_temp != iter_lane_marker_temp->waypoints.end(); ++iter_way_points_temp) {
							right_xs.push_back(static_cast<double>(iter_way_points_temp->x));
							right_ys.push_back(static_cast<double>(iter_way_points_temp->y));
						}
						right_last_way_point = *(iter_lane_marker_temp->waypoints.end()-1);
					}
				}
				++iter_section;
			} else { // connection
				break;
			}
		}
		
        ParameterLane left_line, right_line;
		spline left_line_curve_x, left_line_curve_y, right_line_curve_x, right_line_curve_y;
		double left_length, right_length;
		spline::fitCurve(left_xs, left_ys, left_line_curve_x, left_line_curve_y, left_length);
		spline::fitCurve(right_xs, right_ys, right_line_curve_x, right_line_curve_y, right_length);
		left_line.curve_x = left_line_curve_x;
		left_line.curve_y = left_line_curve_y;
		left_line.length = left_length;
		left_line.paint_type = iter_lane_marker->paint_type;
		right_line.curve_x = right_line_curve_x;
		right_line.curve_y = right_line_curve_y;
		right_line.length = right_length;
		right_line.paint_type = iter_lane_marker_right->paint_type;
		Lane lane;
		lane.left_line = left_line;
		lane.right_line = right_line;

		// get reference path
		int point_num = left_xs.size();
		double s = 0, dist = 0;
		double left_x, left_y, right_x, right_y;
		std::vector<double> ref_xs, ref_ys;
		for(int i=0; i<point_num; i++) {
			left_x = left_xs[i], left_y = left_ys[i];
			spline::getClosestPointOnCurve(right_line_curve_x, right_line_curve_y, left_x, left_y, s, dist);
			right_x = right_line_curve_x(s);
			right_y = right_line_curve_y(s);
			ref_xs.push_back((left_x + right_x) / 2);
			ref_ys.push_back((left_y + right_y) / 2);
		}
		spline ref_line_curve_x, ref_line_curve_y;
		double ref_length = 0;
		spline::fitCurve(ref_xs, ref_ys, ref_line_curve_x, ref_line_curve_y, ref_length);
		ParameterLane ref_line;
		ref_line.curve_x = ref_line_curve_x;
		ref_line.curve_y = ref_line_curve_y;
		ref_line.length = ref_length;
		lane.ref_line = ref_line;
		lane.length = ref_length;
		
		// get lane width
		s = 0;
		double left_dist = 0, width = 0;
		spline::getClosestPointOnCurve(left_line_curve_x, left_line_curve_y, 0, 0, s, left_dist);
		left_x = left_line_curve_x(s);
		left_y = left_line_curve_y(s);
		spline::getClosestPointOnCurve(right_line_curve_x, right_line_curve_y, left_x, left_y, s, width);
		lane.width = width;

		lane_list.push_back(lane);
	}
}

void Prepare::PrepareLocalLaneCombination(const Lane& lane_1, const Lane& lane_2, Lane& lane) {
	ParameterLane left_line, right_line, ref_line;
	PrepareLocalLineCombination(lane_1.left_line, lane_2.left_line, left_line);
	PrepareLocalLineCombination(lane_1.right_line, lane_2.right_line, right_line);
	PrepareLocalLineCombination(lane_1.ref_line, lane_2.ref_line, ref_line);
	lane.left_line = left_line;
	lane.right_line = right_line;
	lane.ref_line = ref_line;
	lane.length = (left_line.length + right_line.length)/2;
    lane.width = lane_1.width;
}

void Prepare::PrepareLocalLineCombination(const ParameterLane& line_1, const ParameterLane& line_2, ParameterLane& line) {
	std::vector<double> xs, ys;
	double delta_s = 1;
	for(double s=0; s<line_1.length; s+=delta_s) {
		double x = line_1.curve_x(s);
		double y = line_1.curve_y(s);
		xs.push_back(x);
		ys.push_back(y);
	}
	double x_1 = line_1.curve_x(line_1.length);
	double y_1 = line_1.curve_y(line_1.length);
	double x_2 = line_2.curve_x(0);
	double y_2 = line_2.curve_y(0);
	double dx_ds_1 = line_1.curve_x.deriv1(line_1.length);
	double dy_ds_1 = line_1.curve_y.deriv1(line_1.length);
	double dx_ds_2 = line_2.curve_x.deriv1(0);
	double dy_ds_2 = line_2.curve_y.deriv1(0);

    double a0_x, a1_x, a2_x, a0_y, a1_y, a2_y, a3_y, s0;

    a0_x = x_1;
    a0_y = y_1;
    a1_x = dx_ds_1;
    a1_y = dy_ds_1;
    s0 = 2 * (x_2 - x_1) / (dx_ds_2 + dx_ds_1);
    a2_x = (dx_ds_2 - dx_ds_1) / (2 * s0);
    a3_y = -(2 * s0 * (y_2 - a1_y * s0 - a0_y) - pow(s0, 2) * (dy_ds_2 - a1_y)) / pow(s0, 4);
    a2_y = -(-3 * pow(s0, 2) * (y_2 - a1_y * s0 - a0_y) + pow(s0, 3) * (dy_ds_2 - a1_y)) / pow(s0, 4);

    for(double s = 0; s <= s0; s+= 0.1) {
        double x = a2_x * pow(s, 2) + a1_x * s + a0_x;
        double y = a3_y * pow(s, 3) + a2_y * pow(s, 2) + a1_y * s + a0_y;
        xs.push_back(x);
        ys.push_back(y);
    }

	for(double s=0; s<line_2.length; s+=delta_s) {
		double x = line_2.curve_x(s);
		double y = line_2.curve_y(s);
		xs.push_back(x);
		ys.push_back(y);
	}
    
    spline curve_x, curve_y;
	double length;
	spline::fitCurve(xs, ys, curve_x, curve_y, length);
	line.curve_x = curve_x;
	line.curve_y = curve_y;
	line.length = length;
	line.paint_type = line_1.paint_type;
}

void Prepare::PrepareStaticObstacleMap(const av_msgs::GridMap& obstacle_map, std::vector< std::vector<double> >& static_obstacle_map) {
    int length = obstacle_map.length * 10;
    int width = obstacle_map.width * 10;
    for (int index = 0; index < width; ++ index) {
        std::vector<double>row(length);
        static_obstacle_map.push_back(row);
    }
    
    for (int i = length - 1; i >= 0; --i) {
        for (int j = 0; j < width; ++j) {
            if (0 != obstacle_map.grid_map[(length - i - 1) * width + j]) {
                static_obstacle_map[j][i] = obstacle_map.grid_map[ (length - i  - 1) * width + j];
            }
        }
    }
}

void Prepare::PrepareLowResolutionStaticObstacleMap(std::vector<std::vector<double> >& static_obstacle_map, 
                                                    std::vector<std::vector<double> >& low_resolution_static_obstacle_map) {
    double low_resolution = traffic_propogation_resolution_;
    double original_resolution = 0.1;
    int step = low_resolution / original_resolution;
    int length = int(static_obstacle_map[0].size()) / step;
    int width = int(static_obstacle_map.size()) / step;
    //std::cout << "low resolution width:" << width << " length:" << length << std::endl;
    for (int i = 0; i < width; ++i) {
        std::vector<double>row(length);
        low_resolution_static_obstacle_map.push_back(row);
        for (int j = 0; j < length; ++j) {
            // 0 0       0 1
            // 0 0 -> 0  0 0 -> 1
            for(int k = 0; k < step; ++k) {
                for(int t = 0; t < step; ++t) {
                    int x = step * i + k;
                    int y = step * j + t;
                    if(0 != static_obstacle_map[x][y]) {
                        low_resolution_static_obstacle_map[i][j] = 1;
                    }
                }
            }
        }
    }
}

}
