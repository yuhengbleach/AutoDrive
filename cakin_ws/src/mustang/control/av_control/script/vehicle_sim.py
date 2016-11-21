import socket, traceback
import rospy
from av_msgs.msg import ControlSignal
from av_msgs.msg import Localize
from std_msgs.msg import Float64
import numpy
import time
from collections import deque

try: 
    import xml.etree.cElementTree as ET
except ImportError:
    import xml.etree.ElementTree as ET

t0 = time.time()
x = 0
y = 0
vx = 0
vy = 0
ax = 0
ay = 0
heading = 0
w = 0
gear = 0

acc_pedal = 0
brake_pedal = 0
steer_angle = 0

control_valid = False

noise_pos_scale = 0
noise_vel_scale = 0
noise_w_scale = 0
noise_acc_scale = 0
noise_ang_scale = 0

delay_acc_pedal = 0
delay_brake_pedal = 0
delay_steer_angle = 0

delay_index_acc_pedal = 0
delay_index_brake_pedal = 0
delay_index_steer_angle = 0

acc_pedal_deque = deque()
brake_pedal_deque = deque()
steer_angle_deque = deque()

rate = 2000

host = ''
port = 54321

address = ''

s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
s.bind((host, port))

print "server started"

def read_config() :
    global noise_pos_scale, noise_vel_scale, noise_w_scale, noise_acc_scale, noise_ang_scale
    global delay_acc_pedal, delay_brake_pedal, delay_steer_angle
    global delay_index_acc_pedal, delay_index_brake_pedal, delay_index_steer_angle
    global acc_pedal_deque, brake_pedal_deque, steer_angle_deque
    try:
        tree = ET.parse("params_sim.xml")
        root = tree.getroot()
        rate = float(root.find("rate").text)
        noise_pos_scale = float(root.find("noise_pos_scale").text)
        noise_vel_scale = float(root.find("noise_vel_scale").text)
        noise_w_scale = float(root.find("noise_w_scale").text)
        noise_acc_scale = float(root.find("noise_acc_scale").text)
        noise_ang_scale = float(root.find("noise_ang_scale").text)
        delay_acc_pedal = float(root.find("delay_acc_pedal").text)
        delay_brake_pedal = float(root.find("delay_brake_pedal").text)
        delay_steer_angle = float(root.find("delay_steer_angle").text)
        delay_index_acc_pedal = delay_acc_pedal * rate
        delay_index_brake_pedal = delay_brake_pedal * rate
        delay_index_steer_angle = delay_steer_angle * rate
        if delay_index_acc_pedal < 1:
            delay_index_acc_pedal = 1
        if delay_index_brake_pedal < 1:
            delay_index_brake_pedal = 1
        if delay_index_steer_angle < 1:
            delay_index_steer_angle = 1
        acc_pedal_deque = deque(maxlen = delay_index_acc_pedal)
        brake_pedal_deque = deque(maxlen = delay_index_brake_pedal)
        steer_angle_deque = deque(maxlen = delay_index_steer_angle)
        
    except Exception, e:
        print e
        print "Error to parse params_sim.xml"


def parse_data(msg):
    global x, y, vx, vy, ax, ay, heading, w, gear
    global noise_pos_scale, noise_vel_scale, noise_w_scale, noise_acc_scale, noise_ang_scale
    msg_list = msg.split(",")
    x = float(msg_list[0])
    y = float(msg_list[1])
    vx = float(msg_list[2])
    vy = float(msg_list[3])
    ax = float(msg_list[4])
    ay = float(msg_list[5])
    heading = float(msg_list[6])
    w = float(msg_list[7])
    gear = float(msg_list[8])
    if(noise_pos_scale > 0):
        x += numpy.random.normal(0, noise_pos_scale, None)
        y += numpy.random.normal(0, noise_pos_scale, None)
    if(noise_ang_scale > 0):
        heading += numpy.random.normal(0, noise_ang_scale, None)
    if(noise_vel_scale > 0):
        vx += numpy.random.normal(0, noise_vel_scale, None)
        vy += numpy.random.normal(0, noise_vel_scale, None)
    if(noise_acc_scale > 0):
        ax += numpy.random.normal(0, noise_acc_scale, None)
        ay += numpy.random.normal(0, noise_acc_scale, None)
    if(noise_w_scale > 0):
        w += numpy.random.normal(0, noise_w_scale, None)

    localize = Localize()
    localize.pose_x = x
    localize.pose_y = y
    localize.vel_x = vx
    localize.vel_y = vy
    localize.acc_x = ax
    localize.acc_y = ay
    localize.angular_vel_z = w
    localize.heading = heading
    localize.timestamp = (time.time() - t0) * 10000
    return localize

def send_input():
    global acc_pedal, brake_pedal, steer_angle
    global delay_index_acc_pedal, delay_index_brake_pedal, delay_index_steer_angle
    global acc_pedal_deque, brake_pedal_deque, steer_angle_deque
    acc_pedal_deque.append(acc_pedal)
    brake_pedal_deque.append(brake_pedal)
    steer_angle_deque.append(steer_angle)
    
    acc_pedal_t = acc_pedal
    brake_pedal_t = brake_pedal
    steer_angle_t = steer_angle
    if len(acc_pedal_deque) < delay_index_acc_pedal:
       acc_pedal_t = 0
    else:
        acc_pedal_t = acc_pedal_deque[0]
    if len(brake_pedal_deque) < delay_index_brake_pedal:
       brake_pedal_t = 0
    else:
       brake_pedal_t = brake_pedal_deque[0]
    if len(steer_angle_deque) < delay_index_steer_angle:
       steer_angle_t = 0
    else:
       steer_angle_t = steer_angle_deque[0]
    msg = "acc_pedal=%f;brake_pedal=%f;steer_angle=%f" % (acc_pedal_t, brake_pedal_t, steer_angle_t)
    s.sendto(msg, address)

def recv_output() :
	global address
	msg, address = s.recvfrom(8192)
	return parse_data(msg)

def callback_controller(msg) :
	global acc_pedal, brake_pedal, steer_angle, control_valid
	acc_pedal = msg.acc_pedal_pos
	brake_pedal = msg.brake_pedal_pos
	steer_angle = msg.steering_angle
	control_valid = True

def run() :
    global acc_pedal, brake_pedal, steer_angle
    global gear
    read_config()
    rospy.init_node('vehicle_sim', anonymous = True)
    pub = rospy.Publisher('/av_localization/localization/localize', Localize, queue_size=10)
    pub_gear = rospy.Publisher('/av_control/gear_state', Float64, queue_size=10)
    rospy.Subscriber("/av_control/control_signal",ControlSignal, callback_controller)
    r = rospy.Rate(2000)
    # rospy.spin()
    while not rospy.is_shutdown():
        localize = recv_output()
        send_input()
        pub.publish(localize)
        pub_gear.publish(gear)
        r.sleep()

if __name__=='__main__':
	run()  
