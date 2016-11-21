
#ifndef _PATH_H__
#define _PATH_H__

#include "av_planning/global_planning/types.h"
#include "av_planning/global_planning/euclidean.h"
#include <av_planning/spline.h>
#include <vector>

namespace av_planning{
	class Path
	{
	public:
		SectionEdgeList edges;
		ConnectionNodeList nodes;
	
    public:
		Path(){};
		~Path(){};
		
        std::pair<int, int> GetSectionIndex(double x, double y);
		
        double GetDistInLastSection(const LatLong start, const LatLong dest);
		
        double GetDistInSection(const double start_x, const double start_y);
        //void currentPolyon(int& i, int& polyon_type, double x, double y);
		//Euclidean::Polygon make_ployon(SectionEdge sec);
		//Euclidean::Polygon make_ployon(virtual_lane_ptr_t vl);
    };



}//av_hdmap

#endif
