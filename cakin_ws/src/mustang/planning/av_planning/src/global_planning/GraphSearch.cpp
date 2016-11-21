
#include "av_planning/global_planning/GraphSearch.h"

namespace av_planning{

//--------------------------- A*  realization ------------------------------

typedef std::pair<std::pair<double,double>, SectionEdgeList> PossiblePath;

class PossiblePathComparision
{
    public:
    PossiblePathComparision() {}
    bool operator() (const PossiblePath& lhs, const PossiblePath& rhs) const 
    {
      return (lhs.first.first > rhs.first.first);
    }
};

typedef std::priority_queue<PossiblePath, std::vector<PossiblePath>, PossiblePathComparision> PathPriorityQueue;
  
double cost(Graph& graph, SectionEdge& edge, double default_cross_time) {
    double time;
    time = edge.distance / edge.speedlimit;
    time += default_cross_time;
    return time;
}

double time_between_nodes(ConnectionNode* start, ConnectionNode* end, double default_speedlimit) {
    double distance = 0;
    distance = Euclidean::distanceTo(start->center, end->center);

    double time = distance / default_speedlimit;// TODO

    return time;

}
// TODO 
double heuristic(Graph& graph, connection_index_t start_id, connection_index_t goal_id, double default_speedlimit)
{
  //printf("START: %d END: %d\n", start_id, goal_id);
  ConnectionNode* start = graph.get_node_by_index(start_id);
  ConnectionNode* end = graph.get_node_by_index(goal_id);
  return time_between_nodes(start, end, default_speedlimit);
}

void add_to_queue(Graph& graph, PathPriorityQueue* q, connection_index_t from_index, 
    PossiblePath& old_possible_path, connection_index_t goal_id, double default_speedlimit, double default_cross_time) {
    //std:: cout << "add_to_queue: " << std::endl;
    SectionEdgeList edges;
 
    edges = graph.edges_from(from_index);
    //std:: cout << "edges from: " << from_index << std::endl;
    //for(SectionEdgeList::iterator i = edges.begin(); i != edges.end(); i++) {
    //                    std:: cout << (*i).sectionEdge_id << std::endl;
    //}
    for(SectionEdgeList::iterator i = edges.begin(); i != edges.end(); i++) {
    //                     std:: cout << (*i).sectionEdge_id << std::endl;
		SectionEdgeList new_path(old_possible_path.second);
		new_path.push_back(*i);
		PossiblePath pp;
		pp.first.second = old_possible_path.first.second + cost(graph, *i, default_cross_time); 
		pp.first.first = pp.first.second + heuristic(graph, i->to, goal_id, default_speedlimit);
		pp.second = new_path;
		q->push(pp);
		
    }// for
}// add_to_queue 


SectionEdgeList GraphSearch::astar_search(Graph& graph, connection_index_t start_id, connection_index_t goal_id, double default_speedlimit, double default_cross_time) {

    //std:: cout << " astar_search " << start_id << " : " << goal_id <<  std::endl;
    //std:: cout << graph.nodes.size() << std::endl;
    std::map<connection_index_t, bool> closed;
    closed[start_id] = true;
    //std:: cout << "new PathPriorityQueue " << std::endl;
    PathPriorityQueue* q = new PathPriorityQueue(PossiblePathComparision());
    
    PossiblePath empty;
    empty.first.first = empty.first.second = 0;
    SectionEdgeList empty_list;

    if (start_id == goal_id) {
		delete q;
		return empty_list;
    }

    empty.second = empty_list;
    //std:: cout << "add to queue 1 " << std::endl;
    add_to_queue(graph, q, start_id, empty, goal_id, default_speedlimit, default_cross_time);
    
    // Main searching loop
    while(!q->empty()) {
		PossiblePath path = q->top();
		q->pop();
		SectionEdge final_edge = path.second.back();
		if(closed[final_edge.to])
			continue;

		if(final_edge.to == goal_id) {
			delete q;
			return path.second;
		}
		closed[final_edge.to] = true;
		add_to_queue(graph, q, final_edge.to, path, goal_id, default_speedlimit, default_cross_time);
    }
    delete q;
    return empty_list;
}

}// av_hdmap
