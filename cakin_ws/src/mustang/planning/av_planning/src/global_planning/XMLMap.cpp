

#include "av_planning/global_planning/XMLMap.h"

//-------------------------- xml parse relization ---------------------

namespace av_planning{

struct LanemarkerTreeWalker : public pugi::xml_tree_walker
{
    LanemarkerTreeWalker(std::map< point_index_t, point_with_id_t >& p_b_i, Lanemarker& l_m) : points_by_id(p_b_i), lm(l_m)
    {
    }

    std::map< point_index_t, point_with_id_t >& points_by_id;
    Lanemarker& lm;

    virtual bool for_each(pugi::xml_node& node)
    {
        if(  node.name() == pugi::string_t("nd") )
        {
            point_index_t node_id = node.attribute("ref").as_int();
            lm.waypoints.push_back( points_by_id[node_id] );
        }
        return true;
    }
};

struct SectionTreeWalker : public pugi::xml_tree_walker
{
    SectionTreeWalker(std::map< point_index_t, point_with_id_t >& p_b_i, std::map< lanemarker_index_t, 
                lanemarker_ptr_t >& l_m_t, Section& s) : points_by_id(p_b_i), lanemarkers_by_id(l_m_t), sec(s)
    {

    }
    std::map< point_index_t, point_with_id_t >& points_by_id;
    std::map< lanemarker_index_t, lanemarker_ptr_t >& lanemarkers_by_id;
    Section& sec;

    virtual bool for_each(pugi::xml_node& node)
    {

        if(  node.name() == pugi::string_t("mem") )
        {
            lanemarker_index_t lm_id = node.attribute("ref").as_int();
            //std::cout << "lm:" << lm_id << std::endl;
            sec.lanemarkers.push_back( lanemarkers_by_id[lm_id] );
        }
        if(  node.name() == pugi::string_t("speedlimit") )
        {
            double sp = node.attribute("val").as_double();
            sec.speedlimit = sp;
            //std::cout << "sp:" << sp << std::endl;
        }
        if(  node.name() == pugi::string_t("traffic_light") )
        {
            sec.traffic_light_flag = 1;
            double tmp_lat_ = node.attribute("lat").as_double();
            double tmp_lon_ = node.attribute("lon").as_double();
            double tmp_h_ = node.attribute("h").as_double();
            sec.trafficlight = std::make_tuple(tmp_lat_, tmp_lon_, tmp_h_);
            //TODO 
            //std::cout << "sp:" << sp << std::endl;
        }

        if(  node.name() == pugi::string_t("exit") )
        {
                    TurnType turn_type = node.attribute("role").as_int();
                    point_with_id_t p1 = points_by_id[node.attribute("left").as_int()];
                    point_with_id_t p2 = points_by_id[node.attribute("right").as_int()];
                    LatLong tmp_latlong1 = LatLong(std::get<0>(p1), std::get<1>(p1));
                    LatLong tmp_latlong2 = LatLong(std::get<0>(p2), std::get<1>(p2));
                    sec.exits.insert(std::make_pair(turn_type, std::make_pair(tmp_latlong1, tmp_latlong2)) );
        }
        if(  node.name() == pugi::string_t("enter") )
        {
            point_with_id_t p1 = points_by_id[node.attribute("left").as_int()];
            point_with_id_t p2 = points_by_id[node.attribute("right").as_int()]; 
            LatLong tmp_latlong1 = LatLong(std::get<0>(p1), std::get<1>(p1));
            LatLong tmp_latlong2 = LatLong(std::get<0>(p2), std::get<1>(p2));
            sec.enter = std::make_pair(tmp_latlong1, tmp_latlong2);
        }

        return true;
    }
};

struct SegmentTreeWalker : public pugi::xml_tree_walker
{
    SegmentTreeWalker(std::map< section_index_t, section_ptr_t >& s_p_t, Segment& seg) : sections_by_id(s_p_t), segment(seg)
    {

    }

    std::map< section_index_t, section_ptr_t >& sections_by_id;
    Segment& segment;

    virtual bool for_each(pugi::xml_node& node)
    {

        if(  node.name() == pugi::string_t("sec") )
        {
            section_index_t node_id = node.attribute("ref").as_int();
            segment.sections.push_back( sections_by_id[node_id] );
        }

        return true;
    }
};

struct ConnectionWalker : public pugi::xml_tree_walker
{

    Connection& conn_;
    std::map< lanemarker_index_t, lanemarker_ptr_t >& lanemarkers_by_id;
    //LatLong center;
    //std::vector< std::map<section_index_t, TurnType> >& exit_pairs;
    std::map<int, std::map<int, virtual_lane_ptr_t> >::iterator it_;
    ConnectionWalker(std::map< lanemarker_index_t, lanemarker_ptr_t >& l_m_t, Connection& c) 
        : lanemarkers_by_id(l_m_t), conn_(c)
    {
    }
    virtual bool for_each(pugi::xml_node& node)
    {

        if( node.name() == pugi::string_t("center") )
        {
        	// TODO
            double lat = node.attribute("lat").as_double();
            double lon = node.attribute("lon").as_double();
            conn_.center.lat = lat;
            conn_.center.lon = lon;
        }
        if( node.name() == pugi::string_t("exit_pair") )
        {
          // TODO
            connection_index_t from_ = node.attribute("from").as_int();
            connection_index_t to_ = node.attribute("to").as_int();
            TurnType t = node.attribute("type").as_int();

            // lanemarker_index_t lm_left_ = -1001;
            // lanemarker_index_t lm_right_ = -1002;
            lanemarker_index_t lm_left_ = -9;
            lanemarker_index_t lm_right_ = -10;
            //printf("get virtual lanemarker_id\n");
            //lanemarker_index_t lm_left_ = node.attribute("left").as_int();
            //lanemarker_index_t lm_right_ = node.attribute("right").as_int();
            //printf("PARSE CONNNECTION\n");
            //printf("lanemarkers_by_id[lm_left_] -> lanemarker_id: %d\n", lanemarkers_by_id[lm_left_] -> lanemarker_id);
            virtual_lane_ptr_t vl_ = virtual_lane_ptr_t(new VirtualLane(t, lanemarkers_by_id[lm_left_], lanemarkers_by_id[lm_right_]));
            it_ = conn_.turn_info_.find(from_);
            
            //tmp_map_[to_] = vl_;
            if(it_ != conn_.turn_info_.end()){
                conn_.turn_info_[from_].insert(std::make_pair(to_, vl_));
            }
            else{
                std::map<int, virtual_lane_ptr_t> tmp_map_;
                tmp_map_.insert(std::make_pair(to_, vl_));
                conn_.turn_info_.insert(std::make_pair(from_, tmp_map_));
            }
            //printf("[from_][to_] -> lm_left_ -> lanemarker_id: %d\n", conn_.turn_info_[from_][to_] -> lm_left_ -> lanemarker_id);
            //auto tm_wp =  conn_.turn_info_[from_][to_] -> lm_left_ -> waypoints;
            // for(int i=0; i<tm_wp.size(); i++){
            //     //printf("%.10lf, %.10lf\n",  tm_wp[i].first, tm_wp[i].second);
            // }
            //exit_pairs[from].insert(std::make_pair(to, t));
        }

        return true;
    }
};

void XMLMap::parse_waypoints()
{
    //std::cout << "parse_waypoints : "<< std::endl;
    for ( pugi::xpath_node node : doc.select_nodes("//node[@lat and @lon and @id]") )
    {

        double lat =  node.node().attribute("lat").as_double();
        double lon = node.node().attribute("lon").as_double();
        point_index_t id = node.node().attribute("id").as_int();
        //printf("curr point: %d\n", id);
        points_by_id[id] = std::make_pair(lat, lon);
    }
}

void XMLMap::parse_lanemarkers()
{
    //std::cout << "parse_lanemarkers : "<< std::endl;
    for( pugi::xpath_node lanemarker : doc.select_nodes("//lanemarker[@id]") )
    {
        //printf("parse_lanemarkers_for\n");
        lanemarker_index_t lm_id = lanemarker.node().attribute("id").as_int();
        //printf("parse lanemarker: %d\n", lm_id);
        lanemarker_ptr_t new_lanemarker = lanemarker_ptr_t(new Lanemarker(lm_id));
        LanemarkerTreeWalker walker(points_by_id, *new_lanemarker);
        lanemarker.node().traverse(walker);
        lanemarkers_by_id[lm_id] = new_lanemarker;
    }
}

void XMLMap::parse_sections()
{
    //std::cout << "parse_sections : "<< std::endl;
    for( pugi::xpath_node section : doc.select_nodes("//section[@id]") )
    {
        section_index_t st_id = section.node().attribute("id").as_int();
        connection_index_t from = section.node().attribute("from").as_int();
        connection_index_t to = section.node().attribute("to").as_int();
        section_ptr_t new_section = section_ptr_t(new Section(st_id, default_speedlimit, from, to));
       //std::cout << "st_id : "<< st_id << " " << from << " " << to << std::endl;
        SectionTreeWalker sectionWalker(points_by_id, lanemarkers_by_id, *new_section);
        section.node().traverse(sectionWalker);
        //std::cout << "sec traff" << std::endl;
        new_section -> trafficlight = std::make_tuple(0.0, 0.0, 0.0);
        //new_section->distance = len_of_lanemarker((new_section->lanemarkers[0])->waypoints);
        //std::cout << "dis:" << new_section->distance << std::endl;
        sections_by_id[st_id] = new_section;
    }
}//parse_sections

void XMLMap::parse_segments(){
    //std::cout << "parse_segments : "<< std::endl;
    for(pugi::xpath_node segment : doc.select_nodes("//segment[@id]"))
    {
    segment_index_t seg_id = segment.node().attribute("id").as_int();
    //std::cout << seg_id << std::endl;
    segment_ptr_t new_segment = segment_ptr_t(new Segment(seg_id));
		SegmentTreeWalker segmentWalker(sections_by_id, *new_segment);
		segment.node().traverse(segmentWalker);
		segments_by_id[seg_id] = new_segment;
    }//for
}//parse_segments

void XMLMap::parse_connections(){
//exit_pairs.resize( sections_by_id.size()+1 );
     //       std::cout << "parse_connections : "<< std::endl;
	for(pugi::xpath_node conn : doc.select_nodes("//connection[@id]")){
	connection_index_t conn_id = conn.node().attribute("id").as_int();
	//std::cout << "conn_id:" << conn_id << std::endl;
	connection_ptr_t new_conn = connection_ptr_t( new Connection(conn_id));
	//ConnectionWalker connectionWalker(exit_pairs);
	ConnectionWalker connectionWalker(lanemarkers_by_id, *new_conn);
                     conn.node().traverse(connectionWalker);
	//new_conn -> exit_pairs = connectionWalker.exit_pairs;
	//new_conn->center.lat = connectionWalker.center.lat;
	             //new_conn->center.lon = connectionWalker.center.lon;
	connections_by_id[conn.node().attribute("id").as_int()] = new_conn;
    //std::cout << new_conn -> connection_id << std::endl;
	}//for

}//parse_connections


void XMLMap::populate_graph(Graph& graph)
{
    //        std::cout << "populate_graph : "<< std::endl;
	//XMLParser xmlparser(doc);
	graph.nodes_size = connections_by_id.size();
	//graph.nodes.resize(graph.nodes_size);

	std::map<connection_index_t, connection_ptr_t>::iterator node_itr;
	for(node_itr = connections_by_id.begin(); node_itr != connections_by_id.end(); node_itr++){
                            //printf("%d\n", node_itr -> first);
		graph.nodes.push_back(ConnectionNode(node_itr->second));
                        //std::cout<< "curr read conn: " << graph.nodes.back().connectionNode_id << std::endl;
                        //graph.nodes[node_itr->first] = ConnectionNode(node_itr->second);// TODO
	}
    //printf("edges\n");
	graph.edges_size = sections_by_id.size();
	//graph.edges.resize(graph.edges_size);
	std::map<section_index_t, section_ptr_t>::iterator edge_itr;
	for(edge_itr = sections_by_id.begin(); edge_itr != sections_by_id.end(); edge_itr++){
                        //printf("%d\n",  edge_itr -> first);
                        graph.edges.push_back(SectionEdge(edge_itr->second));
                        // std::cout<< "curr read section: " << graph.edges.back().sectionEdge_id << std::endl;
                        // std::cout<< "curr read section from: " << graph.edges.back().from << std::endl;
                        //  std::cout<< "curr read section to: " << graph.edges.back().to << std::endl;
		//graph.edges[edge_itr->first] = SectionEdge(edge_itr->second);
	}//for
	//save_gobal_map();
    //         printf("finish pop\n");
}//populate_graph

}// namespace av_hdmap
