time=$(date +"%Y%m%d%H%M%S")
#echo ${time}
#rosbag record -O gps_msg_${time}.bag /gps_data &
rosbag record -O all_msgs_${time}.bag -a -b 0 

#rosbag record -O ibeo_msg_${time}.bag /ibeo_object_list &
#rosbag record -O camera_tel_msg_${time}.bag /camera_telescopic &
#rosbag record -O camera_tel_msg_${time}.bag /camera_binocular &
#rosbag record -O gps_msg_${time}.bag /gps_data &
#rosbag record -O esr_msg_${time}.bag /esr_driver &
#rosbag record -O rsds_msg_${time}.bag /rsds_objlist &
