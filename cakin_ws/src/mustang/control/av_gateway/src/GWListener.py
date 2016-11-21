#!/usr/bin/env python
import json
import rospy
from std_msgs.msg import String
from av_msgs.msg import VehicleMsg
from av_msgs.msg import StateMsg
from gateway_code import canio

class GWListener:
    state_list = [266, 416]
    vehicle_msg = VehicleMsg()
    comm_pub = rospy.Publisher('gateway_common', VehicleMsg, queue_size=10)
    state_pub = rospy.Publisher('gateway_state', StateMsg, queue_size=10)
    rospy.init_node('GWListener', anonymous=True)
    rate = rospy.Rate(50) # 10hz
    io = canio.canio()
    #set default value for vehicle_msg
    #todo
    def _init_(self):
        self.vehicle_msg.VehicleSpeed = 0

    def build_control_msg(self, decoded_msg):
        msg_id = decoded_msg["id"]
        for k in decoded_msg["signals"]:
            if k["name"].find("CHKSM") >=0 or k["name"].find("ALIVE") >= 0:
                print "%s invalid,continue" %k["name"]
                continue
            if hasattr(self.vehicle_msg, k["name"]):
                print "set attr " + k["name"] + "with value" + str(k["value"])
                setattr(self.vehicle_msg, k["name"], k["value"])

    def start(self):
        while not rospy.is_shutdown():
            decoded_msg = self.io.receive_once()
            if not decoded_msg:
                rospy.logwarn("empty msg")
                continue
            msg_id = decoded_msg["id"]
            msg_name = decoded_msg["name"]
            s_msg = "name:%s" %decoded_msg["name"]
            for k in decoded_msg["signals"]:
                s_msg += "%s=%d\t" %(k["name"],k["value"])
            s_msg += "%s" % rospy.get_time()
            rospy.loginfo(s_msg)

            #if a control msg
            if msg_id not in self.state_list:
                self.build_control_msg(decoded_msg)
                rospy.loginfo(str(self.vehicle_msg))
                self.comm_pub.publish(self.vehicle_msg)
            #if a state msg
            else:
                state_msg = None
                if msg_id == 416:
                    GModeTrans = -1
                    for item in decoded_msg["signals"]:
                        if item["name"] == "GModeTrans":
                            GModeTrans = item["value"]
                            break
                    if GModeTrans < 0 or GModeTrans >= 8:
                        rospy.logwarn("GModeTrans overflow")
                    else:
                        state_msg = StateMsg()
                        state_msg.id = msg_id
                        state_msg.name = item["name"]
                        state_msg.state = GModeTrans
                elif msg_id == 266:
                    GModeInfo = -1
                    for item in decoded_msg["signals"]:
                        if item["name"] == "GModeInfo":
                            GModeInfo = item["value"]
                            break
                    if GModeInfo < 0 or GModeInfo >= 8:
                        rospy.logwarn("GModeInfo overflow")
                    else:
                        state_msg = StateMsg()
                        state_msg.id = msg_id
                        state_msg.name = item["name"]
                        state_msg.state = GModeInfo
                rospy.loginfo(str(state_msg))
                self.state_pub.publish(state_msg)
            self.rate.sleep()

if __name__ == '__main__':
    try:
        gw = GWListener()
        gw.start()
    except rospy.ROSInterruptException:
        pass

