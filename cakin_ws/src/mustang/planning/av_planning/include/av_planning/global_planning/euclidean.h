
// tools in euclidean space
#ifndef _EUCLIDEAN_H__
#define _EUCLIDEAN_H__

#include "av_planning/global_planning/types.h"

namespace Euclidean{

	double inline distance_between_points(point_with_id_t wp, double x, double y){
	double p1_x = std::get<0>(wp);
	double p1_y = std::get<1>(wp);
	return sqrt((p1_x - x) * (p1_x - x) + (p1_y - y) * (p1_y - y));
	}//

	double inline distance_between_points(point_with_id_t wp, LatLong ll){
	double p1_x = std::get<0>(wp);
	double p1_y = std::get<1>(wp);
	return sqrt((p1_x - ll.lat) * (p1_x - ll.lat) + (p1_y - ll.lon) * (p1_y - ll.lon));
}//
	double inline distanceTo(LatLong center1, LatLong center2){
	  	return sqrt((center1.lat - center2.lat) * (center1.lat - center2.lat) + 
	    	(center1.lon - center2.lon) * (center1.lon - center2.lon));

	}

	double inline distance_between_waypoints(point_with_id_t& p1, point_with_id_t& p2){
		double p1_x = std::get<0>(p1);
		double p1_y = std::get<1>(p1);
		double p2_x = std::get<0>(p2);
		double p2_y = std::get<1>(p2);
		return sqrtf((p1_x - p2_x) * (p1_x - p2_x) + (p1_y - p2_y) * (p1_y - p2_y));
	}


	double inline len_of_point_series(std::vector<point_with_id_t>& waypoints){
  		double len = 0;
  		for(int i=0; i<waypoints.size()-1; i++){
	    len += distance_between_waypoints(waypoints[i], waypoints[i+1]);
	  }//for
	  return len;
	}//len_of_lanemarker

	// struct Polygon
	// {
	//  
	//     std::vector< std::pait<double, double>> waypoints;
	//     int n; 
	// }Polygon;
	typedef std::vector< std::pair<double, double>> Polygon;

	Polygon inline make_ployon(SectionEdge sec){
		auto v1 = sec.lanemarkers[0] -> waypoints;
		auto v2 = sec.lanemarkers.back() -> waypoints;
		std::reverse(v2.begin(), v2.end());
		v1.insert(v1.end(), v2.begin(), v2.end());
		//std::cout << "size of section ployon: " <<sec.sectionEdge_id << ", " << v1.size() << std::endl;
		// printf("points  in ployon, size of points %d\n", v1.size());
		// for(int i=0; i<v1.size(); i++){
		// 	printf("%.10lf, %.10lf\n", v1[i].first, v1[i].second);
		// }
		return v1;
		

	}
	Polygon  inline make_ployon(virtual_lane_ptr_t vl){
		auto v1 = vl -> lm_left_ -> waypoints;
		auto v2 = vl -> lm_right_ -> waypoints;
		std::reverse(v2.begin(), v2.end());
		v1.insert(v1.end(), v2.begin(), v2.end());
		return v1;
	}
	bool inline point_in_ployon(Polygon p, double x, double y){
		//printf("point to be detected X: %.10lf, Y:%.10lf\n", x, y);
		int      i, j = p.size()-1 ;
		int cnt = 0;
  		bool  oddNodes = false;
 		for (i=0; i < p.size(); i++) {
 			//printf("i p%d: %.8lf, %.8lf\n", i,  p[i].first, p[i].second);
 			//printf("j p%d: %.8lf, %.8lf\n", j,  p[j].first, p[j].second);
 			//std::cout << "p" << i << ": " << p[i].first << ", " << p[i].second << std::endl;
    			if ( (p[i].second < y && p[j].second >= y ||  p[j].second < y && p[i].second >= y)
			    &&  (p[i].first <= x || p[j].first <= x) ) {
			    	//int tmp = (p[i].first + (y-p[i].second) / (p[j].second-p[i].second) * (p[j].first-p[i].first) < x );
			    	//printf("res %d", tmp);

			    	auto tmp_odd = p[i].first + (y-p[i].second) / (p[j].second-p[i].second) * (p[j].first-p[i].first) ;
			    	//printf("tmp_odd: %.20lf\n", tmp_odd);
			    	//printf("%.20lf\n", x);
				oddNodes ^= (tmp_odd < x );
				if(tmp_odd < x) {
					//printf("I: %.10lf, %.10lf\n", p[i].first, p[i].second);
					//printf("j: %.10lf, %.10lf\n", p[j].first, p[j].second);
					cnt++;
				}
			}//if
			j=i; 
		}//for
	
		//std::cout << "cnt: " << cnt << std::endl;
  		return oddNodes;

  		//oddNodes^=(polyX[i]+(y-polyY[i])/(polyY[j]-polyY[i])*(polyX[j]-polyX[i])<x); }
	}// point_in_ployon

} 
#endif