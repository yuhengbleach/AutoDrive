#ifndef MUSTANG_AV_PLANNING_GLOBAL_PLANNING_H
#define MUSTANG_AV_PLANNING_GLOBAL_PLANNING_H

#include <ros/ros.h>
#include <ros/package.h>
#include <vector>
#include <string>
#include <iterator>
#include <map>
#include <tuple>
#include <iostream>
#include <memory>

#include <av_msgs/Dest.h>
#include <av_msgs/Localize.h>
#include <av_planning/planning_comm.h>
#include <av_planning/global_planning/types.h>
#include <av_planning/global_planning/Graph.h>
#include <av_planning/global_planning/Path.h>
#include <av_planning/global_planning/XMLMap.h>
#include <av_planning/global_planning/GraphSearch.h>
#include <av_planning/global_planning/UTM.h>
#include <av_planning/global_planning/libpugi/pugixml.hpp>

namespace av_planning {

class GlobalPlanning {
public:
    GlobalPlanning();
    enum ErrorCode PlanningGlobalPath(const av_msgs::Dest &dest, 
        const av_msgs::Localize &localize, Path &global_path);
    //utils
    //static std::pair<section_index_t, int> GetSectionIndex(const LatLong ll, const Path &path);
    //static double GetDistInLastSection(const LatLong start,const LatLong dest, const Path &path);
private:
    void LoadConfiguration();

private:
    std::string map_file;
    double default_speedlimit;
    double default_cross_time;
    XMLMap* xmlmap;
    Graph graph;
    GraphSearch gs;
};

} // namespace av_planning 

#endif // MUSTANG_AV_PLANNING_GLOBAL_PLANNING_H
