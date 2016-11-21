#!/usr/bin/env python
import json
import rospy
import sys
from std_msgs.msg import String
from gateway_code import canio


def GWtoAV(spd):
    #pub = rospy.Publisher('gateway_', EMS_3, queue_size=10)
    pub = rospy.Publisher('gateway_ag', String, queue_size=10)
    rospy.init_node('GWtoAV', anonymous=True)
    rate = rospy.Rate(10) # 10hz
    #spd = 0
    while not rospy.is_shutdown():
        #spd = (spd + 5)% 50
        json_msg = {"id":267,"signals":
              [{"name":"CHKSM_ACU_4","value":0},
              {"name":"ALIVE_ACU_4","value":0},
              {"name":"ACU_TurnIndication","value":0},
              {"name":"ACU_STAT_AccPedalPos","value":spd}
              ]
              }
        #json_msg = {"id":417,
        #            "signals":[
        #                #{"name":"CHKSM_ACU_3","value":0},
        #                #{"name":"ALIVE_ACU_3","value":0},
        #                {"name":"AutoDriving_ACU","value":1},
        #                {"name":"TMode_ACK","value":0},
        #                {"name":"FMode_ACK","value":0}
        #                ]
        #            }
        print "speed:%d" %spd
        js = json.dumps(json_msg, ensure_ascii=False)
        pub.publish(js)
        rate.sleep()

if __name__ == '__main__':
    try:
        speed = int(sys.argv[1])
        GWtoAV(speed)
    except rospy.ROSInterruptException:
        pass
