 /*
 C++ interface for the Graph data structure
 */


#ifndef __GRAPH_h__
#define __GRAPH_h__

#include <ros/ros.h>
#include "av_planning/global_planning/types.h"
#include "av_planning/global_planning/euclidean.h"
#include "av_planning/global_planning/UTM.h"
#include "av_msgs/Localize.h"

// typedef std::vector<WayPointEdge> WayPointEdgeList;
// typedef std::vector<WayPointNode> WayPointNodeList;

//typedef std::vector<WayPointNodeList> ZoneList;
//typedef std::vector<int> intList;



typedef std::vector<ConnectionNode> ConnectionNodeList;
typedef std::vector<SectionEdge> SectionEdgeList;


namespace av_planning{
class Graph{

// private:
//   LatLong graph_center_;
  
public:
  SectionEdgeList edges;
  ConnectionNodeList nodes;
  int nodes_size;
  int edges_size;
  LatLong graph_center_;

  Graph(){
      //<node id='-174' action='modify' visible='true' lat='31.71959173561' lon='121.02463336472' />
    //graph_center_.lat = 31.71959173561;
    //graph_center_.lon = 121.02463336472;
    nodes_size = 0;
    edges_size = 0;
    
  };

  ~Graph(){
    // if (this->nodes !=NULL)
    //   delete[] this->nodes;
    // edges.clear();
  };

  void cal_UTMXY();
  section_index_t get_section_index_by_xy(double x, double y);
  SectionEdgeList edges_from(connection_index_t index);
  ConnectionNode* get_node_by_index(connection_index_t index);

};//Graph
}// av_hdmap

#endif
