
#include "av_planning/global_planning/Graph.h"

namespace av_planning{

//--------------------------- A*  realization ------------------------------
SectionEdgeList Graph::edges_from(connection_index_t index) {
  SectionEdgeList new_edges;
  for(uint i=0; i<edges.size(); i++){
    if(edges[i].from == index){
      new_edges.push_back(edges[i]);
    }
  }
  return new_edges;
}

ConnectionNode* Graph::get_node_by_index(connection_index_t index) {
  for(uint i=0; i<nodes.size(); i++){
    if(nodes[i].connectionNode_id == index){
      return &nodes[i];
    }
  }
  return NULL;
}

section_index_t Graph::get_section_index_by_xy(double x, double y){
  //std::map< int, section_ptr_t>::iterator section_i;
  //std::vector<lanemarker_ptr_t> lanemarkers;
  //std::map< int, connection_ptr_t> connection_i;

  //double dis = -1;
  //int tmp_point_id = 0;
  //int tmp_lanemarker_id = 0;
  //int tmp_section_id;
  //int tmp_connection_id = 0;
  //printf("%.8lf, %.8lf\n", x, y);
      for(int j=0; j<edges.size(); j++){
                //std::cout << "curr edges: " << edges[j].sectionEdge_id << std::endl;
                if( Euclidean::point_in_ployon(Euclidean::make_ployon(edges[j]), x, y) ){
                  //std::cout << "find point in edge" << edges[j].sectionEdge_id << std::endl;
                      return j;
                  //return edges[j].sectionEdge_id;
            }
      }//for
      //printf("POINT NO SECTION\n");
// for(int j=0; j<nodes.size(); j++){
          //   int in = edges[j].sectionEdge_id;
          //   int out = edges[j+1].sectionEdge_id;
          //   if( Euclidean::point_in_ployon(make_ployon(nodes[j].turn_info_[in][out]), x, y) ){
          //     i = j;
          //     polyon_type = 0; //1 if connection
          //     return;
          //   }
          // }//for


  // for(int i = 0; i < edges.size(); i++){
  //   for(int j=0; j < edges[i].lanemarkers.size(); j++){
  //     for(int k=0; k < edges[i].lanemarkers[j]->waypoints.size(); k++){
  //       point_with_id_t curr_point =  (edges[i].lanemarkers[j])->waypoints[k];
  //       double tmp_dis = Euclidean::distance_between_points(curr_point, x, y);
  //       if (dis < 0 || dis > tmp_dis){
  //           dis = tmp_dis;
  //           tmp_section_id = edges[i].sectionEdge_id;
  //           //tmp_section_id = i;
  //       }//if
  //     }//for
  //   }//for
  // }//for
  //return tmp_section_id;
}//get_seciton_index_by_xy

  void Graph::cal_UTMXY(void)
  {
    // if (nodes_size < 1)
    //   {
    //     ROS_INFO("No graph nodes available for conversion to MapXY");
    //     return;
    //   }

    // Compute the MapXY value corresponding to the first way-point in
    // the graph.  Use temporaries because MapXY is defined in floats,
    // while the UTM function returns doubles.
    double tX;
    double tY;  
    UTM::UTM(graph_center_.lat, graph_center_.lon, &tX, &tY);

    // Round UTM origin of map to nearest UTM grid intersection.  All
    // odometry is reported relative to that location.
    // double grid_x = 300000;

    //double grid_y = 3500000;
    double grid_x = (rint(tX/UTM::grid_size) * UTM::grid_size);
    double grid_y = (rint(tY/UTM::grid_size) * UTM::grid_size);
    //ROS_INFO("UTM grid of first graph center: (%.f, %.f)", grid_x, grid_y);

    // Relocate all other way-points relative to (grid_x, grid_y),
    // instead of individually relocating each way-point.  This may
    // avoid some discontinuities if the map happens to span a grid
    // boundary.

  for(uint i = 0; i < nodes.size(); i++){
        // printf("----------------------------------node id: %d\n", nodes[i].connectionNode_id);
        UTM::UTM(nodes[i].center.lat, nodes[i].center.lon, &tX, &tY);
        nodes[i].center = LatLong(tX - grid_x, tY - grid_y);
        // printf("%.10lf, %.10lf\n", tX, tY);
        // printf("%.10lf, %.10lf\n", grid_x, grid_y);
        // printf("nodes[i].center: %.10lf, %.10lf\n", nodes[i].center.lat, nodes[i].center.lon);
        // //std::cout<< "nodes[i].center" << tX - grid_x << ", " << tY - grid_y << std::endl;

          if(nodes[i].turn_info_.size() != 0){
              //std::cout << "node virt size" << nodes[i].turn_info_.size() << std::endl;
              for(TurnInfo::iterator it1_ = nodes[i].turn_info_.begin(); it1_!=nodes[i].turn_info_.end(); it1_++){
                        //printf("it1->first: %d\n", it1_->first);
                      //std::cout<< "it1_->first" << int(it1_->first) << std::endl;
                        for(std::map<int, virtual_lane_ptr_t>::iterator it2_ = it1_->second.begin(); it2_!=it1_->second.end(); it2_++){
                              //printf("it2->first: %d\n", it2_->first);
                              //std::cout<< "it1_->first" << int(it1_->first) << std::endl;
                              //printf("lanemarker_id: %d\n", it2_ -> second -> lm_left_ -> lanemarker_id);
                              //printf("UTM lanemarker_id: %d\n",  it2_->second-> lm_left_ -> lanemarker_id);
                              for(int j=0; j<it2_->second-> lm_left_ ->waypoints.size(); j++){
                                      //std::cout<< "it1_->first" << int(it1_->first) << std::endl;
                                      //std::cout<< "it2_->first" << int(it2_->first) << std::endl;
                                      //std::cout << it2_->second-> lm_left_->waypoints[j].first << "," << it2_->second-> lm_left_->waypoints[j].second << std::endl;
                                      //printf("virtual lanemarker UTM-------------------------------%d\n", j);
                                      if (it2_->second-> lm_left_->waypoints[j].first < 35 && it2_->second-> lm_left_->waypoints[j].second < 123){
                                              // printf("%.10lf, %.10lf\n", it2_->second-> lm_left_->waypoints[j].first, it2_->second-> lm_left_->waypoints[j].second);
                                              // UTM::UTM(it2_->second-> lm_left_->waypoints[j].first, it2_->second-> lm_left_->waypoints[j].second, &tX, &tY);
                                              
                                              // printf("%.10lf, %.10lf\n", tX - grid_x, tY - grid_y);
                                              it2_->second-> lm_left_->waypoints[j] = std::make_pair(tX - grid_x, tY - grid_y);
                                              // printf("%.10lf, %.10lf\n", it2_->second-> lm_left_->waypoints[j].first, it2_->second-> lm_left_->waypoints[j].second);
                                      }
                                      else{
                                              // printf("this is a UTM XY\n");
                                      }
                                      //std::cout<< "waypoints[i]" << tX - grid_x << ", " << tY - grid_y << std::endl;

                            }//for
                                for(int j=0; j<it2_->second-> lm_right_ ->waypoints.size(); j++){
                                      if (it2_->second-> lm_right_->waypoints[j].first < 35 && it2_->second-> lm_right_->waypoints[j].second < 123){
                                              
                                              UTM::UTM(it2_->second-> lm_right_->waypoints[j].first, it2_->second-> lm_right_->waypoints[j].second, &tX, &tY);
                                              it2_->second-> lm_right_->waypoints[j] = std::make_pair(tX - grid_x, tY - grid_y);
                                      }

                                }//for
                      }//for
        }//if

        }//if
  }// nodes for

    // sectionedge concert
  //std::cout << "size of edges: " << edges.size() << std::endl;
  for(uint i = 0; i < edges.size(); i++){
      //lanemarker convert
        //std::cout << "edge id: " << edges[i].sectionEdge_id << std::endl;
        for(int j=0; j<edges[i].lanemarkers.size(); j++){
              for(int h=0; h<edges[i].lanemarkers[j]->waypoints.size(); h++){
                      UTM::UTM(edges[i].lanemarkers[j]->waypoints[h].first, edges[i].lanemarkers[j]->waypoints[h].second, &tX, &tY);
                      edges[i].lanemarkers[j]->waypoints[h] = std::make_pair(tX - grid_x, tY - grid_y);
                      //std::cout<< "edges waypoints:" << tX - grid_x << ", " << tY - grid_y << std::endl;
                }//for
        }
        //traffic light convert
        UTM::UTM(std::get<0>(edges[i].trafficlight), std::get<1>(edges[i].trafficlight), &tX, &tY);
        double tmp_h = std::get<2>(edges[i].trafficlight);
        edges[i].trafficlight = std::make_tuple(tX - grid_x, tY - grid_y, tmp_h);
        //std::cout << "UTM trafficlight: " << i << " " << std::get<0>(edges[i].trafficlight) << std::endl;
        //enter convert

        UTM::UTM(edges[i].enter.first.lat, edges[i].enter.first.lon, &tX, &tY);
        edges[i].enter.first = LatLong(tX - grid_x, tY - grid_y);
        UTM::UTM(edges[i].enter.second.lat, edges[i].enter.second.lon, &tX, &tY);
        edges[i].enter.second = LatLong(tX - grid_x, tY - grid_y);
        //std::cout << "UTM section enter: " << i << std::endl;
        // exits convert

        for(std::map<TurnType, Exit>::iterator it3_=edges[i].exits.begin(); it3_!=edges[i].exits.end(); it3_++){
                UTM::UTM(it3_->second.first.lat, it3_->second.first.lon, &tX, &tY);
                it3_->second.first = LatLong(tX - grid_x, tY - grid_y);
                UTM::UTM(it3_->second.second.lat, it3_->second.second.lon, &tX, &tY);
                it3_->second.second = LatLong(tX - grid_x, tY - grid_y);
        }
        //std::cout << "UTM section exits: " << i << std::endl;
      // distance convert
        edges[i].distance = Euclidean::len_of_point_series(edges[i].lanemarkers[0]->waypoints);
        //std::cout << "UTM len of dist: " << i << std::endl;
      //    std::cerr << "Edge "<<i<<" "<<start->id.name().str<<" "<<
      //      end->id.name().str<<" "<<edges[i].distance<<std::endl;
  }// edge for
  }// cal_UTMXY
}//av_hdmap
