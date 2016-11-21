

#ifndef _TYPES_HH_
#define _TYPES_HH_

/** @file
    
    type definitions
 */

#include <string>
#include <iterator>
#include <tuple>
#include <iostream>
#include <stdio.h>
#include <vector>
#include <algorithm>
#include <fstream>
#include <cstdlib>
#include <memory>
#include <map>
//#include "av_msgs/TrafficLightLoc.h"
/** @brief global ART types definitions. */

typedef int TurnType;
// some fixed-size types passed in messages
typedef int point_index_t;
typedef int section_index_t;
typedef int connection_index_t;
typedef int lanemarker_index_t;
typedef int segment_index_t;
//elements ID is for map store.

// enum Lane_marking
//   {DOUBLE_YELLOW, SOLID_YELLOW, SOLID_WHITE, BROKEN_WHITE, UNDEFINED};
typedef std::pair< double, double> point_with_id_t;

class LatLong
{
public:
  double lat;
  double lon;

  // void constructor
  LatLong()
  {
    lat = lon = 0.0;
  }

  // initialization constructor
  LatLong(double lat, double lon)
  {
    this->lat = lat;
    this->lon = lon;
  }
};

class Lanemarker{
 public:
  lanemarker_index_t lanemarker_id; //integer > 0
  //int number_of_waypoints; //integer > 0
  std::vector<point_with_id_t> waypoints; //List of waypoints
  //<optional lane header>
  // Lane_marking left_boundary;
  // Lane_marking right_boundary;
  //std::vector<Checkpoint> checkpoints;
  Lanemarker(lanemarker_index_t lm_id){
    lanemarker_id = lm_id;
  }
  Lanemarker(Lanemarker& that){
    this->lanemarker_id = that.lanemarker_id;
    this->waypoints = that.waypoints;
  }
  Lanemarker(){
  }

};

typedef std::shared_ptr<Lanemarker> lanemarker_ptr_t;
typedef std::pair<LatLong, LatLong> Enter;
typedef std::pair<LatLong, LatLong> Exit;

class Section{
public:
  section_index_t section_id;
  int traffic_light_flag;
  connection_index_t from, to;
  //int number_of_lanemarkers;
  std::vector<lanemarker_ptr_t> lanemarkers;
  std::tuple <double, double, double> trafficlight;// init 
  double speedlimit;
  double distance;
  Enter enter;
  std::map<TurnType, Exit> exits;
  
  Section(section_index_t st_id, double default_speedlimit, connection_index_t f, connection_index_t t){
    section_id = st_id;
    from = f;
    to = t;
    speedlimit = default_speedlimit;// 10m/s
    distance = 0;
    this -> trafficlight = std::make_tuple(0.0, 0.0, 0.0);
    this -> traffic_light_flag = 0;
  }
  Section(){
  }
  //Stop stop;
};//Section

typedef std::shared_ptr<Section> section_ptr_t;

class VirtualLane{
public:
  TurnType turn_type_;
  lanemarker_ptr_t lm_left_;
  lanemarker_ptr_t lm_right_;
  VirtualLane(TurnType t, lanemarker_ptr_t l1, lanemarker_ptr_t l2){
    turn_type_ = t;
    lm_left_ = l1;
    lm_right_ = l2;
  }
};
typedef std::shared_ptr<VirtualLane> virtual_lane_ptr_t;
typedef std::map<int, std::map<int, virtual_lane_ptr_t> > TurnInfo;

class Connection{

public:
  connection_index_t connection_id;
  TurnInfo turn_info_;
  //std::map<int, std::map<int, int>> exit_pairs;
  LatLong center;//
  std::map<section_index_t,  std::map<section_index_t, std::vector<lanemarker_ptr_t>> > connection_lanemarkers;

  Connection(connection_index_t conn_id){
    connection_id = conn_id;
  }
  Connection(){}
  
};//connection

typedef std::shared_ptr<Connection> connection_ptr_t;

//<segment>
class Segment{
 public:
  segment_index_t segment_id; // integer > 0
  //int number_of_sections;// 1 or 2
  //<optional segment header>
  //std::string segment_name; // such as "Wisconsin_Ave"
  
  std::vector<section_ptr_t> sections;//list of sections
 
  Segment(segment_index_t seg_id){
    segment_id = seg_id;
  }
  Segment(){
  }
  //METHODS
  // bool isvalid(){return (segment_id > 0 && number_of_sections > 0
    //   && number_of_sections == (int)sections.size());};
};
typedef std::shared_ptr<Segment> segment_ptr_t;

class ConnectionNode{
public:
  connection_index_t connectionNode_id;
  TurnInfo turn_info_;
  LatLong center;
  //std::map<int, std::map<int, int>> exit_pairs;
  ConnectionNode(connection_ptr_t c){// TODO
    connectionNode_id = c -> connection_id;
    this->turn_info_ = c->turn_info_;
    center.lat = c -> center.lat;
    center.lon = c -> center.lon;
  }
  ConnectionNode(){
    center.lat = 0;
    center.lon = 0;
    connectionNode_id = 0;
  }
};//class


typedef std::vector< std::pair<double, double>> Polygon;

class SectionEdge{
  public:
    section_index_t sectionEdge_id;
    int traffic_light_flag;
    connection_index_t from, to;
    std::vector<lanemarker_ptr_t> lanemarkers;
    std::tuple<double, double, double> trafficlight;
    double speedlimit;
    double distance;
    Enter enter;
    std::map<TurnType, Exit> exits;
    Polygon polygon;

    SectionEdge(section_ptr_t s){
      sectionEdge_id = s->section_id;
      traffic_light_flag = s -> traffic_light_flag;
      speedlimit = s->speedlimit;
      distance = s->distance;
      from = s->from;
      to = s->to;
      enter.first = s->enter.first;
      enter.second = s->enter.second;
      this->exits = s->exits;
      lanemarkers = s->lanemarkers;
      this->trafficlight = s->trafficlight;
  }
    SectionEdge(){
      traffic_light_flag = 0;
      sectionEdge_id = 0;
      from = to = 0;
      speedlimit = 0;
      distance = 0;
    }
};// SectionEdge

typedef std::vector<SectionEdge> SectionEdgeList;
typedef std::vector<ConnectionNode> ConnectionNodeList;

#endif // _TYPES_HH_ //
