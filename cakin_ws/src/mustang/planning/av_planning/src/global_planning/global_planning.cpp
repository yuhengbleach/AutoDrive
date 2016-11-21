
#include <cmath>
#include <queue>

#include <av_planning/global_planning/global_planning.h>

namespace av_planning{

//----------------------- Global Planning ---------------------------
// std::pair<section_index_t, int> GlobalPlanning::GetSectionIndex(const LatLong ll, const SectionEdgeList &path){
//   std::map< int, section_ptr_t>::iterator section_i;
//   std::vector<lanemarker_ptr_t> lanemarkers;
//   //std::map< int, connection_ptr_t> connection_i;
//   double dis = -1;
//   int tmp_section_id = 0;
//   int wps_id = 0;
//   for(int i=0; i<path.size(); i++){
//     //for(int j=0; j<path[i].lanemarkers.size(); j++){
//         std::vector<point_with_id_t> wps = path[i].lanemarkers[0]->waypoints;
//         for(int k=0; k<wps.size(); k++){ 
//             double tmp_dis = distance_between_points(wps[k], ll);
//             if (dis < 0 || dis > tmp_dis){
//                 dis = tmp_dis;
//                 tmp_section_id = path[i].sectionEdge_id;
//                 wps_id = k;
//             }//if
//         }//for
//     //}//for
//   }//for
//   return std::make_pair(tmp_section_id, wps_id);
// }//get_seciton_index_by_xy


// double GlobalPlanning::GetDistInLastSection(const LatLong start, const LatLong dest, const Path &path){
//     std::pair<section_index_t, int> start_id = GetSectionIndex(start, path);
//     //std::cout << "start k" << start_id.second << std::endl;
//     std::pair<section_index_t, int> dest_id = GetSectionIndex(dest, path);
//     //std::cout << "dest k" << dest_id.second << std::endl;
//     double dis = -1;
//     if(start_id.first != path.back().sectionEdge_id){
//         return dis;
//     }
//     std::vector<point_with_id_t> wps = path.back().lanemarkers[0] -> waypoints;
//     if (start_id.second >= dest_id.second)
//         std::cout << "error in get_dist_in_last_section" << std::endl;
//     for(int h=start_id.second; h<dest_id.second; h++){
//         dis += distance_between_waypoints(wps[h], wps[h+1]);
//     }
//     std::cout << "dis: " << dis << std::endl;
//     return dis;
// }

void GlobalPlanning::LoadConfiguration() {
    std::string path = ros::package::getPath("av_planning");
    ros::param::get("~/global_planning/map_file", map_file);
    map_file = path + "/" +map_file;
    ros::param::get("~/global_planning/default_speedlimit", default_speedlimit);
    ros::param::get("~/global_planning/default_cross_time", default_cross_time);
}

GlobalPlanning::GlobalPlanning(){
	// ros::param::get("~/traffic_propagation/certain_trajectory_start_time",
	//                 certain_trajectory_start_time_);
	LoadConfiguration();
    //std:: cout << filename << std::endl;
	pugi::xml_document doc;
	pugi::xml_parse_result res = doc.load_file(map_file.c_str());
    //std:: cout << "doc load success" << std::endl;
	xmlmap = new XMLMap(doc, default_speedlimit);
    //std:: cout << "new xmlmap" << std::endl;
	graph = Graph();
	xmlmap->populate_graph( graph );
             //graph.cal_UTMXY();
    //std:: cout << "finish Graph build" << std::endl;
}// GlobalPlanning()

enum ErrorCode GlobalPlanning::PlanningGlobalPath(const av_msgs::Dest &dest,
                                        const av_msgs::Localize &localize,
                                        Path &path){

	
        int manual = 0;
        XmlRpc::XmlRpcValue sids_value;
        ros::param::get("~/global_planning/manual", manual);
        if (1 == manual){
              ros::param::get("~/global_planning/section_ids", sids_value);
              for(int i = 0; i < sids_value.size(); i++) { 
                      ROS_ASSERT(sids_value[i].getType() == XmlRpc::XmlRpcValue::TypeInt);
                      auto tmp_id = static_cast<int>(sids_value[i]);
                      path.edges.push_back(graph.edges[tmp_id -1]);
              }  
        }//if
        else{
                section_index_t start_id = graph.get_section_index_by_xy(localize.pose_x, localize.pose_y);
                //section_index_t start_id = 15;
                //std:: cout << "start: " << start_id << std::endl;
                //section_index_t dest_id = 3;
                section_index_t dest_id = graph.get_section_index_by_xy(dest.x, dest.y);
                //std:: cout << "dest: " << dest_id << std::endl;
                //SectionEdgeList path = astar_search(graph, graph.edges[start_id].to, graph.edges[dest_id].from, default_speedlimit, default_cross_time);
                
                SectionEdgeList section_in_path = gs.astar_search(graph, graph.edges[start_id].to, graph.edges[dest_id].from, default_speedlimit, default_cross_time);
            //std:: cout << "astar_search" << std::endl;
                // path.edges.resize(section_in_path.size() + 2);
                // path.nodes.resize(section_in_path.size() + 1);
                //printf("finish astar\n");
                path.edges.push_back(graph.edges[start_id]);
                //printf("push_back start_id\n");
                path.edges.insert(path.edges.end(), section_in_path.begin(), section_in_path.end());
                //printf("insert\n");
                path.edges.push_back(graph.edges[dest_id]);
        }//else

    for(int i=0; i<path.edges.size() -1; i++){
      path.nodes.push_back(graph.nodes[path.edges[i].to - 1]);// warningstore sort
    }
    //printf("finish global_planning\n");
    printf("GlobalPlanning::PlanningGlobalPath\n"); 
    return ErrorCode::SUCCESS;
	//return ErrorCode::SUCCESS;

}//PlanningGlobalPath()
}// namespace av_planning


