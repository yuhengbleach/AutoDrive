import rospy
import time
import thread
import sys
import json
from av_msgs.msg import VehicleState
from av_msgs.msg import ControlSignal
from av_msgs.msg import Localize

def callback_record_state(msg):
    log_msg = "t:%f; x:%f; y:%f; ang: %f; vel_x:%f; vel_y:%f; vel_ang:%f; acc_x:%f; acc_y:%f; acc_ang:%f" % (msg.timestamp, msg.x, msg.y, msg.ang, msg.vel_x, msg.vel_y, msg.vel_ang, msg.acc_x, msg.acc_y, msg.acc_ang)
    result_state.write(log_msg + "\n")

def callback_record_control(msg):
    log_msg = "t: %f; acc_pedal: %f; brake_pedal: %f; steer_angle: %f" % (msg.timestamp, msg.acc_pedal_pos, msg.brake_pedal_pos, msg.steering_angle)
    result_control.write(log_msg + "\n")

def callback_record_localize(msg):
    log_msg = "%d , %f, %f, %f, %f" % (msg.timestamp, msg.pose_x, msg.pose_y, msg.vel_x, msg.acc_x)
    result_localize.write(log_msg + "\n")

def listen():
    rospy.init_node("record", anonymous=True)
    rospy.Subscriber("/av_control/vehicle_state", VehicleState, callback_record_state)
    rospy.Subscriber("/av_control/control_signal", ControlSignal, callback_record_control)
    rospy.Subscriber("/av_localization/localization/localize", Localize, callback_record_localize)
    rospy.spin()


t0 = time.time()
time_str = time.strftime("%m%d-%H%M%S")
try:
    with open("../logs/vehicle_state-%s.txt" %time_str,"w") as result_state, open("../logs/control_signal-%s.txt" %time_str,"w") as result_control, open("../logs/localize-%s.txt" %time_str,"w") as result_localize:
        print "starting recording..."
        listen()
except Exception,e:
    print e
