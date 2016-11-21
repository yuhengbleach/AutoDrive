#!/usr/bin/env python
import json
import rospy
from std_msgs.msg import String
from gateway_code import canio

#def retrive_msg(msg_name, msg_data):
#    obj = eval(msg_name+"()")
#    for item in msg_data["signals"]:
#        nm = item["name"]
#        val = item["value"]
#        print "%s=%s" %(nm,val)
#        objstr = ".".join(["obj",nm])
#        print objstr
#        subobj = eval(objstr)
#        print subobj
#        subobj = val
#        print subobj
#    print obj    
#    return obj

def retrive_msg(msg_name, msg_data):
    if msg_name == "EMS_3":
        print "name right"
        obj = EMS_3()
        for item in msg_data["signals"]:
            print item["name"]
            if item["name"] == "STAT_AcceleratorpedalPosition":
                print "yes"
                obj.STAT_AcceleratorpedalPosition = item["value"]
    return obj

def GWtoAV():
    #pub = rospy.Publisher('gateway_', EMS_3, queue_size=10)
    pub = rospy.Publisher('gateway_ag', String, queue_size=10)
    rospy.init_node('GWtoAV', anonymous=True)
    rate = rospy.Rate(1) # 10hz
    while not rospy.is_shutdown():
        json_msg = {"id":267,"signals":
              [{"name":"CHKSM_ACU_4","value":0},
              {"name":"ALIVE_ACU_4","value":0},
              {"name":"ACU_TurnIndication","value":0},
              {"name":"ACU_STAT_AccPedalPos","value":20}
              ]
              }
        print "json_msg"
        js = json.dumps(json_msg, ensure_ascii=False)
        pub.publish(js)
        rate.sleep()

if __name__ == '__main__':
    try:
        GWtoAV()
    except rospy.ROSInterruptException:
        pass
