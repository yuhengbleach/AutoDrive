// parse XML file into struct
// define waypoint, lanemarker, section, connection
#ifndef __XMLMAP_h__
#define __XMLMAP_h_


#include "av_planning/global_planning/types.h"
#include "av_planning/global_planning/Graph.h"
#include "av_planning/global_planning/libpugi/pugixml.hpp"

//

//waypoints definition

namespace av_planning{
class XMLMap {

public:

    std::map< point_index_t, point_with_id_t > points_by_id;
    std::map< lanemarker_index_t, lanemarker_ptr_t > lanemarkers_by_id;
    std::map< section_index_t, section_ptr_t > sections_by_id;
    std::map< connection_index_t, connection_ptr_t > connections_by_id;
    std::map< segment_index_t, segment_ptr_t > segments_by_id;
    std::vector< std::map<section_index_t, TurnType> > exit_pairs;

    void parse_waypoints();
    void parse_lanemarkers();
    void parse_sections();
    void parse_segments();
    void parse_connections();
    double len_of_lanemarker(std::vector<point_with_id_t>& waypoints);
    std::string filename; 
    pugi::xml_document& doc;
    double default_speedlimit;
    XMLMap(pugi::xml_document& tmp_doc, double dsp):doc(tmp_doc), default_speedlimit(dsp){
        std::cout << "initial XMLMap"  << std::endl;
        parse_waypoints();
        parse_lanemarkers();
        parse_sections();
        parse_segments();
        parse_connections(); 
    }
    ~XMLMap() {};
    void populate_graph(Graph& graph);
    //TurnType get_turn_type(section_index_t s1, section_index_t s2);
    //int get_section_index_by_xy(double x, double y);

};
}// namespace av_hdmap

#endif
