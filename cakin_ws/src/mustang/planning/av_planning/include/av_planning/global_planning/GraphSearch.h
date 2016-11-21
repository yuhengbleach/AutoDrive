

#ifndef _GRAPHSEARCH_H__
#define _GRAPHSEARCH_H__

#include <queue>

#include "av_planning/global_planning/euclidean.h"
#include "av_planning/global_planning/types.h"
#include "av_planning/global_planning/Graph.h"

namespace av_planning{
	
	class GraphSearch{

	public:
		SectionEdgeList astar_search(Graph& graph, connection_index_t start_id, connection_index_t goal_id, double default_speedlimit, double default_cross_time) ;
	};
}// av_hdmap

#endif