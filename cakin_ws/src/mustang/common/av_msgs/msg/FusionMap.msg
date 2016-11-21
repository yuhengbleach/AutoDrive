# Fusion map.

uint64 timestamp                        # 当前时间戳

DynamicObstacle[] dynamic_object_list   # 动态障碍物列表

GridMap obstacle_map                    # 静态障碍物矩阵，150*100m(前100，后50，左50，右50)，
                                        # 粒度10cm*10cm, 可行驶区域为0，障碍物为1，不可见区域－1
SectionList[] section_list           	# 车道线列表

Pose pose
