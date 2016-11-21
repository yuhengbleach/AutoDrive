#include <ros/ros.h>
#include "av_planning/global_planning/Path.h"

namespace av_planning{

	std::pair<int, int> Path::GetSectionIndex(double x, double y){
		// 0 means connection , 1 means section
		int i, polyon_type;

		for(int j=0; j<edges.size(); j++){
			//printf("current j in PATH::currentPolyon: %d\n", j);
			if( Euclidean::point_in_ployon(Euclidean::make_ployon(edges[j]), x, y) ){
				i = j;
				polyon_type = 1; //1 if section
				//printf("path: section %d, %d\n", i, polyon_type);
				return std::make_pair(i, polyon_type);
			}
		}//for
		double tmp_dis = -1;
		double dis = 0.0;
		for(int j=0; j<nodes.size(); j++){
			dis = sqrt((x - nodes[j].center.lat) * (x - nodes[j].center.lat) +  (y - nodes[j].center.lon) * (y - nodes[j].center.lon));
			if( tmp_dis > dis || tmp_dis < 0){
				tmp_dis = dis;
				//printf("path: section %d, %d\n", i, polyon_type);
				i = j;
				polyon_type = 0; //1 if connection
				return std::make_pair(i, polyon_type);
			}
		}//for
        ROS_ERROR("cal section id error!");
	}// currentPloyon

	double Path::GetDistInLastSection(const LatLong start, const LatLong dest){
		std::pair<int, int> start_id = GetSectionIndex(start.lat, start.lon);
		//std::cout << "start k" << start_id.second << std::endl;
		//std::pair<int, int> dest_id = GetSectionIndex(dest, path);
		//std::cout << "dest k" << dest_id.second << std::endl;
		double dis = -1;
		if(start_id.first != edges.size() -1){
		    return dis;
		}

		auto wps = (edges.back().lanemarkers).back() -> waypoints;

		std::vector<double> xs;
	    std::vector<double> ys;
        for(int i=0; i<wps.size(); i++){
       	    xs.push_back(wps[i].first);
            ys.push_back(wps[i].second);
        }
	    spline curve_x, curve_y;
	    double length;
	    spline::fitCurve(xs, ys, curve_x, curve_y, length);
		double s_start=0.0, s_dest=0.0, dist=0.0;
		spline::getClosestPointOnCurve(curve_x, curve_y, start.lat,  start.lon, s_start, dist);
		spline::getClosestPointOnCurve(curve_x, curve_y, dest.lat,  dest.lon, s_dest, dist);
		return (s_dest - s_start);
	}
    
	double Path::GetDistInSection(const double start_x, const double start_y){
		std::pair<int, int> start_id = GetSectionIndex(start_x, start_y);
        if (start_id.second == 0) {
            return -1.0;
        }
		
        auto wps = edges[start_id.first].lanemarkers.back() -> waypoints;
		std::vector<double> xs;
	    std::vector<double> ys;
        for(int i=0; i<wps.size(); i++){
       	    xs.push_back(wps[i].first);
            ys.push_back(wps[i].second);
        }
	    spline curve_x, curve_y;
	    double length;
	    spline::fitCurve(xs, ys, curve_x, curve_y, length);
		double s_start=0.0, dist=0.0;
		spline::getClosestPointOnCurve(curve_x, curve_y, start_x,  start_y, s_start, dist);
		return (length - s_start);
	}

}// av_hdmap
