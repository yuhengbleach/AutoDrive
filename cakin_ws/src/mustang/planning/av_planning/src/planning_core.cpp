#include <av_planning/planning_core.h>
#include <sstream>
#include <string>

#include <sys/time.h>

namespace av_planning{
    
PlanningCore::PlanningCore(const ros::NodeHandle& nh)
    :nh_(nh), 
    rate_(10),
    fusion_map_queue_size_(10),
    dest_queue_size_(10),
    traffic_light_queue_size_(10),
    localize_queue_size_(10){
    LoadConfiguration();

    // TODO for prescan simulation
    section_list_client_ = nh_.serviceClient<av_msgs::getLocalLanemarkers>("getLocalLanemarkers");
}

void PlanningCore::LoadConfiguration() {
    ros::param::get("~path_planning_rate", rate_);
    ros::param::get("~fusion_map_queue_size", fusion_map_queue_size_);
    ros::param::get("~dest_queue_size", dest_queue_size_);
    ros::param::get("~traffic_light_queue_size", traffic_light_queue_size_);
    ros::param::get("~localize_queue_size", localize_queue_size_);
    ros::param::get("~dest_x", dest_.x);
    ros::param::get("~dest_y", dest_.y);
}

void PlanningCore::Init() {
    //init
    prepare_ptr_ = std::move(std::unique_ptr<Prepare> (new Prepare));
    global_planning_ptr_ = std::move(std::unique_ptr<GlobalPlanning> (new GlobalPlanning));
    feature_extraction_ptr_ = std::move(std::unique_ptr<FeatureExtraction> (new FeatureExtraction));
    maneuver_ptr_ = std::move(std::unique_ptr<Maneuver> (new Maneuver));
    candidate_trajectory_ptr_ = std::move(std::unique_ptr<CandidateTrajectory> (new CandidateTrajectory));
    traffic_propagation_ptr_ = std::move(std::unique_ptr<TrafficPropagation> (new TrafficPropagation)); 
    risk_assessment_ptr_ = std::move(std::unique_ptr<RiskAssessment> (new RiskAssessment));
    trajectory_selection_ptr_ = std::move(std::unique_ptr<TrajectorySelection> (new TrajectorySelection));
}

void PlanningCore::Start() {
    Init();
    //subscribe perception information
    ros::Subscriber sub_fusion_map =
        nh_.subscribe("/av_perception/sensor_fusion/fusion_map", fusion_map_queue_size_, &PlanningCore::SubscribeFusionMapCallback, this);
    
    ros::Subscriber sub_dest =
        nh_.subscribe("/av_localization/localization/dest", dest_queue_size_, &PlanningCore::SubscribeDestCallback, this);
   
    ros::Subscriber sub_traffic_light =
        nh_.subscribe("/av_perception/traffic_light_perception/traffic_light_detect", traffic_light_queue_size_, &PlanningCore::SubscribeTrafficLightCallback, this);
    
    ros::Subscriber sub_localize =
        nh_.subscribe("/av_localization/localization/localize", localize_queue_size_, &PlanningCore::SubscribeLocalizeCallback, this);
    
    //trajectory topic
    ros::Publisher pub =
        nh_.advertise <av_msgs::Trajectory> ("/av_planning/planning/trajectory", rate_);
    
    //set path planing excute frequency
    ros::Rate loop_rate(rate_);
    
    ROS_INFO("start planning node...");
    bool first = true;
    Path path;

    prepare_ptr_->SetFusionMapTimestamp(fusion_map_);
    //prepare_ptr_->SetDestTimestamp(dest_);
    prepare_ptr_->SetLocalizeTimestamp(localize_);
    prepare_ptr_->SetTrafficLightTimestamp(traffic_light_);
    while (ros::ok()) {
        
        ros::spinOnce();
        
        // record time consuming
        struct timeval tv1,tv2, last_tv2;
        struct timeval start, end;
        struct timezone tz1, tz2;
        double timeuse;

        gettimeofday(&start, NULL);

        //check msgs
        gettimeofday(&tv1, &tz1);
        if (prepare_ptr_ -> CheckFusionMapMsgs(fusion_map_) == ERROR || 
            prepare_ptr_ -> CheckLocalizeMsgs(localize_) == ERROR ||
            prepare_ptr_ -> CheckTrafficLightMsgs(traffic_light_) == ERROR) {
            continue;
        }
        
        gettimeofday(&tv2, &tz2);
        timeuse = tv2.tv_sec - tv1.tv_sec + (tv2.tv_usec - tv1.tv_usec)/1000000.0;
        ROS_INFO("check msgs use time:%f", timeuse);
        
        // TODO for prescan simulation
       
	/* 
        gettimeofday(&tv1, &tz1);
        double x_prescan = fusion_map_.pose.x;
        double y_prescan = fusion_map_.pose.y;
        CallLocalLanemarkers(x_prescan, y_prescan, fusion_map_.section_list);
        gettimeofday(&tv2, &tz2);
        timeuse = tv2.tv_sec - tv1.tv_sec + (tv2.tv_usec - tv1.tv_usec)/1000000.0;
        ROS_INFO("call lane mark service use time:%f", timeuse);
        */

        //std::cout << "fusion map timestamp:" << fusion_map_.timestamp << std::endl;
        //std::cout << "localize timestamp:" << localize_.timestamp << std::endl;
        //global planning
        gettimeofday(&tv1, &tz1);
        if (first) {
            if (global_planning_ptr_ -> PlanningGlobalPath(dest_, localize_, path) == SUCCESS) {
                ROS_INFO("global planning is ok!");
            } else {
                ROS_ERROR("global planning is failed!");
                continue;
            }
            first = false;
        }
        ROS_INFO("path section size: %d, path connection size: %d", (int)path.edges.size(), (int)path.nodes.size());
        for (int i = 0; i < path.edges.size(); ++i) {
            ROS_INFO("section id: %d, speed limit: %f", (int)path.edges[i].sectionEdge_id, path.edges[i].speedlimit);
        }
        gettimeofday(&tv2, &tz2);
        timeuse = tv2.tv_sec - tv1.tv_sec + (tv2.tv_usec - tv1.tv_usec)/1000000.0;
        ROS_INFO("global planning use time:%f", timeuse);

        //preprocessing data
        //prepare_ptr_ -> TranslateFusionMap(fusion_map_);
        prepare_ptr_ -> TranslateFusionMapPrescan(fusion_map_);
        
        gettimeofday(&tv1, &tz1);
        PlanningFusionMap planning_fusion_map;   
        prepare_ptr_ -> PreprocessFusionMap(fusion_map_, path, planning_fusion_map);
         
        ROS_INFO("prepare data!");
        ROS_INFO("planning fusion map: dynami_object_list size: %d, static_obstacle_map size: %d %d, parameter_lane_list size: %d ", (int)planning_fusion_map.dynamic_object_list.size(), (int)planning_fusion_map.static_obstacle_map.size(), (int)planning_fusion_map.static_obstacle_map[0].size(), (int)planning_fusion_map.lane_group_list.size());
        ROS_INFO("fusion map origin x: %f y: %f", fusion_map_.pose.x, fusion_map_.pose.y);
        ROS_INFO("localize x: %f y: %f", localize_.pose_x, localize_.pose_y);
        ROS_INFO("dest x: %f y: %f", dest_.x, dest_.y);
         
        gettimeofday(&tv2, &tz2);
        timeuse = tv2.tv_sec - tv1.tv_sec + (tv2.tv_usec - tv1.tv_usec)/1000000.0;
        ROS_INFO("preprocessing data use time:%f", timeuse);
        
        //traffic propagation
        gettimeofday(&tv1, &tz1);

        ROS_INFO("traffic propagation...");
        std::vector<RiskMap> certain_risk_maps;
        std::vector<RiskMap> uncertain_risk_maps;
        traffic_propagation_ptr_ -> InferRiskMap(planning_fusion_map, certain_risk_maps, uncertain_risk_maps); 
        ROS_INFO("traffic propagation is ok!"); 
        
        gettimeofday(&tv2, &tz2);
        timeuse = tv2.tv_sec - tv1.tv_sec + (tv2.tv_usec - tv1.tv_usec)/1000000.0;
        ROS_INFO("traffic propagation use time:%f", timeuse);
        
        // dump lane
        /*        
        long int now_time = av_comm::Now();
        std::stringstream lane_ss;
        std::string lane_file_name;
        lane_ss << "log/lane-" << now_time << ".log";
        lane_ss >> lane_file_name;
        DumpLaneGroup(lane_file_name, planning_fusion_map.lane_group_list);
        */
        
        //feature extraction
        gettimeofday(&tv1, &tz1);

        ROS_INFO("extract feature...");
        std::vector<int>feature_list;
        BasicManeuver basic_maneuver;
        if (ErrorCode::ERROR == feature_extraction_ptr_ -> ExtractManeuverFeature(planning_fusion_map, path, traffic_light_, dest_, localize_, feature_list, basic_maneuver)){
            ROS_ERROR("Extract feature is failed!");
            continue;
        };
        ROS_INFO("extract feature is ok!");
        
        gettimeofday(&tv2, &tz2);
        timeuse = tv2.tv_sec - tv1.tv_sec + (tv2.tv_usec - tv1.tv_usec)/1000000.0;
        ROS_INFO("feature extraction use time:%f", timeuse);

        //maneuve selection
        int feedback_flag = 0;
        double first_point_x = 0, first_point_y = 0;
	    std::vector<av_msgs::Trajectory> trajectories;
	    std::vector<Cost> costs;
        std::vector<RiskIndex> risk_indexes;
        int feedback_count = 0;
        
        do {
            gettimeofday(&tv1, &tz1);
            ROS_INFO("maneuver selection...");
            ManeuverState maneuver_state;
              
            if (ErrorCode::ERROR == maneuver_ptr_ -> ReasoningManeuver(feature_list, basic_maneuver, feedback_flag, maneuver_state)) {
                continue;
            }
            maneuver_ptr_ -> CalFeedbackStopDistance(first_point_x, first_point_y, risk_indexes, feedback_flag, maneuver_state);
            ROS_INFO("maneuver state: %d, v: %f, keep_distance: %f, stop_distance: %f", maneuver_state.next_state, maneuver_state.v, maneuver_state.keep_distance, maneuver_state.stop_distance);
            ROS_INFO("maneuver selection is ok!");
             
            gettimeofday(&tv2, &tz2);
            timeuse = tv2.tv_sec - tv1.tv_sec + (tv2.tv_usec - tv1.tv_usec)/1000000.0;
            ROS_INFO("maneuve selection use time:%f", timeuse);
        
            //canditate trajectory generation
            gettimeofday(&tv1, &tz1);

            //init traj
            ROS_INFO("candidate generation..."); 
            trajectories.clear();
	        candidate_trajectory_ptr_ -> GenerateCandidateTrajectories(maneuver_state, localize_, trajectory_history_, trajectories, costs);
		    ROS_INFO("%d trajectories generated!", static_cast<int>(trajectories.size()));
	        ROS_INFO("candidate generation is ok!");

            gettimeofday(&tv2, &tz2);
            timeuse = tv2.tv_sec - tv1.tv_sec + (tv2.tv_usec - tv1.tv_usec)/1000000.0;
            ROS_INFO("canditate trajectory use time:%f", timeuse);

            // risk assessment
            gettimeofday(&tv1, &tz1);

            ROS_INFO("risk assessment...");
            risk_indexes.clear();
            risk_assessment_ptr_ -> AssignTrajectoryRisk(trajectories, costs, certain_risk_maps, uncertain_risk_maps, risk_indexes); 
         
            ROS_INFO("risk assessment is ok!");

            gettimeofday(&tv2, &tz2);
            timeuse = tv2.tv_sec - tv1.tv_sec + (tv2.tv_usec - tv1.tv_usec)/1000000.0;
            ROS_INFO("risk assessment use time:%f", timeuse);

            // debug risk assessment info
            int total_collision_traj = 0;
            for(auto iter = risk_indexes.begin(); iter != risk_indexes.end(); ++iter) {
                if(iter->is_collision) {
                    ++total_collision_traj;
                    //std::cout << "collision x:" << iter->collision_x << " y:" << iter->collision_y 
                    //          << " theta:" << iter->collision_theta << " time:" << iter->collision_time << std::endl;
                }
            }

            std::cout << "total " << total_collision_traj << " collision traj" << std::endl;
            if(0 == trajectories.size()) {
                ROS_ERROR("trajectory is empty!");
            }
            else {
                // first point
                first_point_x = trajectories[0].poses[0].x;
                first_point_y = trajectories[0].poses[0].y;
                std::cout << "first point is x:" << first_point_x << " y:" << first_point_y << std::endl;
           }

            //opt trajectory selection
            gettimeofday(&tv1, &tz1);

		    ROS_INFO("trajectory selection...");
		    trajectory_selection_ptr_ -> SelectTrajectory(trajectories, localize_, costs, risk_indexes, maneuver_state, trajectory_, trajectory_history_, available_trajectory_);
            gettimeofday(&tv2, &tz2);
            timeuse = tv2.tv_sec - tv1.tv_sec + (tv2.tv_usec - tv1.tv_usec)/1000000.0;
            ROS_INFO("trajectory selection use time:%f", timeuse);
            
            feedback_flag = 1;
            feedback_count ++;
        } while(!available_trajectory_&&feedback_count <= 4);
        
        if(available_trajectory_) {
			ROS_INFO("trajectory selection is ok!");
	        pub.publish(trajectory_);
		} else {
             ROS_INFO("no feasible trajectory");
		}

        gettimeofday(&end, NULL);
        ROS_INFO("total time: %f \n", (double)(end.tv_sec - start.tv_sec + (end.tv_usec - start.tv_usec) / 1000000.0));

        bool simple_dump = false;
        if(simple_dump) {
        ROS_INFO("start simple dump log.");
        long int now_time = av_comm::Now();

        std::stringstream best_trajectory_ss;
        std::string best_trajectory_file_name;
        best_trajectory_ss << "log/best_trajectory-" << now_time << ".log";
        best_trajectory_ss >> best_trajectory_file_name;
        DumpBestTrajectory(best_trajectory_file_name, trajectory_); 

        std::stringstream lane_ss;
        std::string lane_file_name;
        lane_ss << "log/lane-" << now_time << ".log";
        lane_ss >> lane_file_name;
        DumpLaneGroup(lane_file_name, planning_fusion_map.lane_group_list);

        std::stringstream simple_certain_risk_map_ss;
        std::string simple_certain_risk_map_file_name;
        simple_certain_risk_map_ss << "log/simple_certain_risk_map-" << now_time << ".log"; 
        simple_certain_risk_map_ss >> simple_certain_risk_map_file_name;
        DumpSimpleRiskMap(simple_certain_risk_map_file_name, certain_risk_maps);

        std::stringstream risk_index_ss;
        std::string risk_index_file_name;
        risk_index_ss << "log/risk_index-" << now_time << ".log";
        risk_index_ss >> risk_index_file_name;
        DumpRiskIndex(risk_index_file_name, risk_indexes);

        ROS_INFO("finish simple dump log.");
        }

        bool dump = false;
        if(dump) {
        // dump intermediate result for visulization
        ROS_INFO("start dump log."); 
        long int now_time = av_comm::Now();
        
        std::stringstream traj_ss;
        std::string traj_file_name;
        traj_ss << "log/traj-" << now_time << ".log";
        traj_ss >> traj_file_name;
        DumpTrajectory(traj_file_name, trajectories);
        
        std::stringstream map_ss;
        std::string map_file_name;
        map_ss << "log/static_map-" << now_time << ".log";
        map_ss >> map_file_name;
        DumpStaticObstacleMap(map_file_name, planning_fusion_map.static_obstacle_map);

        std::stringstream low_map_ss;
        std::string low_map_file_name;
        low_map_ss << "log/low_resolution_static_map-" << now_time << ".log";
        low_map_ss >> low_map_file_name;
        DumpStaticObstacleMap(low_map_file_name, planning_fusion_map.low_resolution_static_obstacle_map);

        std::stringstream certain_risk_map_ss;
        std::string certain_risk_map_file_name;
        certain_risk_map_ss << "log/certain_risk_map-" << now_time << ".log"; 
        certain_risk_map_ss >> certain_risk_map_file_name;
        DumpRiskMap(certain_risk_map_file_name, certain_risk_maps);

        std::stringstream lane_ss;
        std::string lane_file_name;
        lane_ss << "log/lane-" << now_time << ".log";
        lane_ss >> lane_file_name;
        DumpLaneGroup(lane_file_name, planning_fusion_map.lane_group_list);

        std::stringstream risk_index_ss;
        std::string risk_index_file_name;
        risk_index_ss << "log/risk_index-" << now_time << ".log";
        risk_index_ss >> risk_index_file_name;
        DumpRiskIndex(risk_index_file_name, risk_indexes);

        std::stringstream best_trajectory_ss;
        std::string best_trajectory_file_name;
        best_trajectory_ss << "log/best_trajectory-" << now_time << ".log";
        best_trajectory_ss >> best_trajectory_file_name;
        DumpBestTrajectory(best_trajectory_file_name, trajectory_); 

        ROS_INFO("finish dump log.");
        // finish dump
        }
        loop_rate.sleep();
    }
}

void PlanningCore::SubscribeFusionMapCallback(const av_msgs::FusionMap &fm) {
    fusion_map_ = fm;
}

void PlanningCore::SubscribeDestCallback(const av_msgs::Dest &dest){
    dest_ = dest;
}

void PlanningCore::SubscribeTrafficLightCallback(const av_msgs::TrafficLightDetect &traffic_light){
    traffic_light_ = traffic_light;
}

void PlanningCore::SubscribeLocalizeCallback(const av_msgs::Localize &localize){
    localize_ = localize;
}

void PlanningCore::DumpBestTrajectory(std::string file_name, const av_msgs::Trajectory &trajectory) {
    std::ofstream file(file_name);
    for(auto iter_pose = trajectory.poses.begin(); iter_pose != trajectory.poses.end(); ++iter_pose) {
        file << iter_pose->x << " " << iter_pose->y << " " << iter_pose->theta
             << " " << iter_pose->curvature << " " << iter_pose->velocity << " " << iter_pose->acceleration << "\n";
    }
    file.close();
}

void PlanningCore::DumpRiskIndex(std::string file_name, const std::vector<RiskIndex> &risk_indexes) {
    std::ofstream file(file_name);
    for(auto iter = risk_indexes.begin(); iter != risk_indexes.end(); ++iter) {
        file << iter->is_collision << " " << iter->collision_probability << std::endl;
    }
    file.close();
}

void PlanningCore::DumpLaneGroup(std::string file_name, const std::vector<LaneGroup> &lane_group_list) {
    std::ofstream file(file_name);
    for(auto iter_lane_group = lane_group_list.begin(); iter_lane_group != lane_group_list.end(); ++iter_lane_group) {
        file << "# " << iter_lane_group->label << std::endl;
        // for each lane in one lane group
        for(auto iter_lane = iter_lane_group->lanes.begin(); iter_lane != iter_lane_group->lanes.end(); ++iter_lane) {
            // each lane info
            file << "@ " << iter_lane->length << " " << iter_lane->width << std::endl;
            // left lane
            file << "L" << std::endl;
            for(int s = 0; s <= iter_lane->left_line.length; ++s) {
                file << iter_lane->left_line.curve_x(s) << " " << iter_lane->left_line.curve_y(s) << std::endl;
            }
            file << "R" << std::endl;
            for(int s = 0; s <= iter_lane->right_line.length; ++s) {
                file << iter_lane->right_line.curve_x(s) << " " << iter_lane->right_line.curve_y(s) << std::endl;
            }
        }
    }
    file.close();
}

void PlanningCore::DumpStaticObstacleMap(std::string file_name, const std::vector<std::vector<double> > &map) {
    std::ofstream file(file_name);
    for(auto iter_row = map.begin(); iter_row != map.end(); ++iter_row) {
        std::copy(iter_row->begin(), iter_row->end(), std::ostream_iterator<double>(file, " "));
        file << std::endl; 
    }
    file.close();
}

void PlanningCore::DumpTrajectory(std::string file_name, const std::vector<av_msgs::Trajectory> &trajectories) {
    std::ofstream file(file_name); 
    for(auto iter = trajectories.begin(); iter != trajectories.end(); ++iter) {
        for(auto iter_pose = iter->poses.begin(); iter_pose != iter->poses.end(); ++iter_pose) {
            file << iter_pose->x << " " << iter_pose->y << " " << iter_pose->theta 
                 << " " << iter_pose->curvature << " " << iter_pose->velocity << " " << iter_pose->acceleration << "\n";
        }
        file << std::endl;
    }
    file.close();
}

void PlanningCore::DumpRiskMap(std::string file_name, const std::vector<RiskMap> &risk_maps) {
    std::ofstream file(file_name);
    for(auto iter_map = risk_maps.begin(); iter_map != risk_maps.end(); ++iter_map) {
        for(auto iter_row = iter_map->risk_map.begin(); iter_row != iter_map->risk_map.end(); ++iter_row) {
            std::copy(iter_row->begin(), iter_row->end(), std::ostream_iterator<double>(file, " "));
            file << std::endl;
        }
        file << std::endl;
    }
    file.close();
}

void PlanningCore::DumpSimpleRiskMap(std::string file_name, const std::vector<RiskMap> &risk_maps) {
    std::ofstream file(file_name);
    auto iter_map = risk_maps.begin();
    for(auto iter_row = iter_map->risk_map.begin(); iter_row != iter_map->risk_map.end(); ++iter_row) {
        std::copy(iter_row->begin(), iter_row->end(), std::ostream_iterator<double>(file, " "));
        file << std::endl;
    }
    file << std::endl;
    iter_map = risk_maps.end() - 1;
    for(auto iter_row = iter_map->risk_map.begin(); iter_row != iter_map->risk_map.end(); ++iter_row) {
        std::copy(iter_row->begin(), iter_row->end(), std::ostream_iterator<double>(file, " "));
        file << std::endl;
    }
    file.close();
}

bool PlanningCore::CallLocalLanemarkers(const double x_prescan, const double y_prescan, std::vector<av_msgs::SectionList>& section_list) {
    av_msgs::getLocalLanemarkers srv;
    srv.request.x = x_prescan;
    srv.request.y = y_prescan;
    if (!section_list_client_.call(srv)) {
        ROS_ERROR("Failed to call service local lanemarkers.");
        return false;
    }
    section_list = srv.response.section_list;
    return true;
}

}

int main(int argc, char** argv) {
    ros::init(argc, argv, "av_planning_node");
    ros::NodeHandle nh;
    av_planning::PlanningCore planning(nh);
    planning.Start();
    return 0;
}


