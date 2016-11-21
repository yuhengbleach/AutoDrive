#ifndef MUSTANG_AV_PLANNING_PLANNING_COMM_H
#define MUSTANG_AV_PLANNING_PLANNING_COMM_H

namespace av_planning {

enum ErrorCode {
    SUCCESS,
    WARNNING,
    ERROR
};

enum ManeuverCode {
    KEEP_LANE,
    LANE_CHANGE,
    FOLLOW_VEHICLE,
    STOP,
    EXIT
};

} // namespace av_planning

#endif //MUSTANG_AV_PLANNING_PLANNING_COMM_H
