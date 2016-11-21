#!/usr/bin/env python
import rospy
from std_msgs.msg import String
from std_msgs.msg import Float64
from av_msgs.msg import Trajectory
from av_msgs.msg import Localize
from av_msgs.msg import ControlSignal
from av_msgs.msg import VehicleState

import numpy as np
import matplotlib.pyplot as plt
import time
import json
import thread
import math


try:
        import xml.etree.cElementTree as ET
except ImportError:
        import xml.etree.ElementTree as ET

t0 = time.time()

#control signal
acc_pedal = []
brake_pedal = []
steering_angle = []
timestamp_control_signal = []

#lateral control
e_pose = []
e_angle = []
timestamp_kinematic = []
timestamp_pbc = []
pbc_pi = []
pbc_ff = []
pbc_output = [] 

#longitudinal adrc control
origin_velocity = []
filter_velocity = []
desired_velocity = []
current_acceleration = []
td_v1 = []
td_v2 = []
eso_u = []
eso_z1 = []
eso_z2 = []
eso_z3 = []
eso_z4 = []
sef_u = []
timestamp_adrc = []

#trajectory
traj_xs = []
traj_ys = []

#localize
x = 0
y = 0
x_local = []
y_local = []
vx_local = []
vy_local = []
ax_local = []
timestamp_local = []

#flags
velocity_filter_flag = 0
acceleration_filter_flag = 0
pose_filter_flag = 0
trajectory_flag = 0
control_signal_flag = 0
current_acceleration_flag = 0
desired_velocity_flag = 0
adrc_flag = 0
pid_flag = 0
kinematic_flag = 0
pbc_flag = 0
gear_flag = 0
radius = 40
longitudinal_pid_pos_flag = 0

#PID
timestamp_pid = []
PID_output = []

#vehicle state after filter
timestamp_vehicle = []
vehicle_x = [] 
vehicle_y = []
vehicle_ang = []
vehicle_vel_x = []
vehicle_vel_y = []
vehicle_vel_ang = [] 
vehicle_acc_x = []
vehicle_acc_y = []
vehicle_acc_ang = []

#gear
gear = []
timestamp_gear= []

#longitudinal pos pid
timestamp_pos_pid = []
e_longitudinal_pos = []
pos_loop_output = []
vel_loop_output = []
pos_pid_desired_vel = []
pos_pid_current_vel = []

def read_config():
        global lateral_control_error_flag, velocity_filter_flag, acceleration_filter_flag, pose_filter_flag, eso_flag, trajectory_flag, control_signal_flag, current_acceleration_flag, desired_velocity_flag, adrc_flag, pid_flag, kinematic_flag, pbc_flag, gear_flag, radius, longitudinal_pid_pos_flag
        try:
                tree = ET.parse("param_plot.xml")
                root = tree.getroot()
                velocity_filter_flag = int(root.find("velocity_filter").text)
                trajectory_flag = int(root.find("trajectory").text)
                control_signal_flag = int(root.find("control_signal").text)
                acceleration_filter_flag = int(root.find("acceleration_filter").text)
                pose_filter_flag = int(root.find("pose_filter").text)
                desired_velocity_flag = int(root.find("desired_velocity").text)
                adrc_flag = int(root.find("adrc").text)
                pid_flag = int(root.find("pid").text)
                kinematic_flag = int(root.find("kinematic").text)
                pbc_flag = int(root.find("pbc").text)
                gear_flag = int(root.find("gear").text)
                radius = float(root.find("radius").text)
                longitudinal_pid_pos_flag = int(root.find("longitudinal_pid_pos").text)
        except Exception, e:
                print "Error to parse param_plot.xml"


def callback_adrc(data):
    global origin_velocity, filter_velocity, desired_velocity, current_acceleration, td_v1, td_v2, eso_u, eso_z1, eso_z2, eso_z3, eso_z4, sef_u, timestamp_adrc
    timestamp_adrc.append(time.time() - t0)
    js = json.loads(data.data)
    adrc = js["adrc"]
    for item in adrc:
        if item["name"] == "origin_velocity":
            origin_velocity.append(item["value"])
        if item["name"] == "filter_velocity":
            filter_velocity.append(item["value"])
        if item["name"] == "desired_velocity":
            desired_velocity.append(item["value"])
        if item["name"] == "current_acceleration":
            current_acceleration.append(item["value"])
        if item["name"] == "td_v1":
            td_v1.append(item["value"])
        if item["name"] == "td_v2":
            td_v2.append(item["value"])
        if item["name"] == "eso_u":
            eso_u.append(item["value"])
        if item["name"] == "eso_z1":
            eso_z1.append(item["value"])
        if item["name"] == "eso_z2":
            eso_z2.append(item["value"]) 
        if item["name"] == "eso_z3":
            eso_z3.append(item["value"])
        if item["name"] == "eso_z4":
            eso_z4.append(item["value"])
        if item["name"] == "sef_u":
           	sef_u.append(item["value"])


def callback_kinematic(data):
	global e_pose, e_angle, timestamp_kinematic
	timestamp_kinematic.append(time.time() - t0)
	js = json.loads(data.data)	
	lateral = js["lateral"]
	for item in lateral:
		if item["name"] == "kinematic_e_pose":
                        e_pose.append(item["value"])
                if item["name"] == "kinematic_e_angle":
                        e_angle.append(item["value"])

def plot_figure() :
    global adrc_flag, pid_flag, kinematic_flag, pbc_flag
    global lateral_control_error_flag, velocity_filter_flag, acceleration_filter_flag, pose_filter_flag, eso_flag, trajectory_flag, control_signal_flag, desired_velocity_flag, longitudinal_pid_pos_flag
    global origin_velocity, filter_velocity, desired_velocity, current_acceleration, td_v1, td_v2, eso_u, eso_z1, eso_z2, eso_z3, eso_z4, sef_u, timestamp_adrc
    global e_pose, e_angle, timestamp_kinematic, timestamp_pbc
    global traj_xs, traj_ys, radius
    global acc_pedal, brake_pedal, steering_angle, timestamp_control_signal
    global PID_output
    global timestamp_vehicle, vehicle_x, vehicle_y, vehicle_ang, vehicle_vel_x, vehicle_vel_y, vehicle_vel_ang, vehicle_acc_x, vehicle_acc_y, vehicle_acc_ang
    global x_local, y_local, vx_local, vy_local, ax_local,timestamp_local
    global gear, timestamp_gear
    global pbc_pi, pbc_ff, pbc_output
    global timestamp_pos_pid, e_longitudinal_pos, pos_loop_output, vel_loop_output, pos_pid_desired_vel, pos_pid_current_vel
        
    while(True): 
        if kinematic_flag == 1:
                plt.figure('kinematic lateral control')
                plt.subplot(2,1,1)
                plt.plot(timestamp_kinematic, e_pose, color = 'b', label = 'e_pose')
                plt.draw()
                plt.subplot(2,1,2)
                plt.plot(timestamp_kinematic, e_angle, color = 'b', label = 'e_angle')
                plt.draw()

        if pbc_flag == 1:
                plt.figure('pbc lateral error')
                plt.subplot(2,1,1)
                plt.plot(timestamp_pbc, e_pose, color = 'b', label = 'e_pose')
                plt.draw()
                plt.subplot(2,1,2)
                plt.plot(timestamp_pbc, e_angle, color = 'b', label = 'e_angle')
                plt.draw()  
                plt.figure('pbc_controller')
                plt.plot(timestamp_pbc, pbc_pi, color = 'b', label = 'pbc_pi')
                plt.plot(timestamp_pbc, pbc_ff, color = 'r', label = 'pbc_ff')
                plt.draw()

        if adrc_flag == 1:
                plt.figure('eso')
                plt.subplot(4,1,1)
                plt.plot(timestamp_adrc, eso_z1, color = 'b', label = 'eso_z1')
                plt.draw()
                plt.subplot(4,1,2)
                plt.plot(timestamp_adrc, eso_z2, color = 'b', label = 'eso_z2')
                plt.draw()
                plt.subplot(4,1,3)
                plt.plot(timestamp_adrc, eso_z3, color = 'b', label = 'eso_z3')
                plt.draw()
                plt.subplot(4,1,4)
                plt.plot(timestamp_adrc, eso_z4, color = 'b', label = 'eso_z4')
                plt.draw()
        
        if trajectory_flag == 1:  
                plt.figure('trajectory')
                plt.axis([-radius-20, radius+20, -20, 2*radius+20])
                plt.plot(traj_xs, traj_ys)
                plt.plot(x, y, markersize = 5, marker='o')
                plt.savefig('/home/zy/data/4.png', format='png')

        if control_signal_flag == 1:
                plt.figure('control signal')
                plt.subplot(2,1,1)
                plt.plot(timestamp_control_signal, acc_pedal, color = 'r', label = 'acc')
                plt.plot(timestamp_control_signal, brake_pedal, color = 'b', label = 'brake')
                plt.draw()
                plt.subplot(2,1,2)
                plt.plot(timestamp_control_signal, steering_angle, color = 'r', label = 'steer')
                plt.draw()

        if desired_velocity_flag == 1:
                plt.figure('desired_vel_and_current_vel')
                if adrc_flag == 1:
                        plt.plot(timestamp_adrc, desired_velocity, color = 'r', label = 'origin_vel')
                        plt.plot(timestamp_adrc, filter_velocity, color = 'b', label = 'filter_vel')   	
                if pid_flag == 1:
                        plt.plot(timestamp_pid, desired_velocity, color = 'r', label = 'origin_vel')
                        plt.plot(timestamp_pid, filter_velocity, color = 'b', label = 'filter_vel')                           
                plt.draw()

        if pid_flag == 1:
                plt.figure('PID_output')
                plt.plot(timestamp_pid, PID_output, color =  'r', label = 'PID_output')
                plt.draw()
        
        if velocity_filter_flag == 1:
                plt.figure('velocity filter result')
                plt.plot(timestamp_local, vx_local, color = 'r', label = 'origin_vel')
                plt.plot(timestamp_vehicle, vehicle_vel_x, color = 'b', label = 'filter_vel')   	
                plt.draw()

        if acceleration_filter_flag == 1:
                plt.figure('acceleration filter result')
                plt.plot(timestamp_local,ax_local, color = 'b', label = 'local_acc')
                plt.plot(timestamp_vehicle, vehicle_acc_x, color = 'r', label = 'filter_acc')
                plt.draw()

        if pose_filter_flag == 1:
                plt.figure('pose_x_filter_result')
                plt.plot(timestamp_local, x_local, color = 'b', label = 'local_x')
                plt.plot(timestamp_vehicle, vehicle_x, color = 'r', label = 'filter_x')
                plt.draw()
                plt.figure('pose_y_filter_result')
                plt.plot(timestamp_local, y_local, color = 'b', label = 'local_y')
                plt.plot(timestamp_vehicle, vehicle_y, color = 'r', label = 'filter_y')
                plt.draw()      

        if gear_flag == 1:
                plt.figure('gear')
                plt.plot(timestamp_gear, gear, color = 'b', label = 'gear') 
                plt.draw()   

        if longitudinal_pid_pos_flag == 1:
                plt.figure('e_longitudinal_pos')
                plt.plot(timestamp_pos_pid, e_longitudinal_pos, color = 'b', label = 'e_longitudinal_pos') 
                plt.draw()    
                plt.figure('pos_loop')
                plt.plot(timestamp_pos_pid, pos_loop_output, color = 'b', label = 'pos_loop_output') 
                plt.draw()  
                plt.figure('vel_loop')
                plt.plot(timestamp_pos_pid, vel_loop_output, color = 'b', label = 'vel_loop_output') 
                plt.draw()          
                plt.figure('desired and current vel')
                plt.plot(timestamp_pos_pid, pos_pid_desired_vel, color = 'b')
                plt.plot(timestamp_pos_pid, pos_pid_current_vel, color = 'b')
                plt.draw()                                       

        plt.pause(0.001)



def callback_trajectory(msg) :
    global traj_xs, traj_ys
    traj_xs = []
    traj_ys = []
    x0 = msg.initial_pose.x
    y0 = msg.initial_pose.y
    theta0 = msg.initial_pose.theta
    for pose in msg.poses:
        x_t = pose.x * math.cos(theta0) - pose.y * math.sin(theta0) + x0
        y_t = pose.x * math.sin(theta0) + pose.y * math.cos(theta0) + y0
        traj_xs.append(x_t)
        traj_ys.append(y_t)

def callback_localize(msg) :
        global x, y, x_local, y_local, vx_local, vy_local, ax_local,timestamp_local
        x = msg.pose_x
        y = msg.pose_y
        x_local.append(msg.pose_x)
        y_local.append(msg.pose_y)
        vx_local.append(msg.vel_x)
        vy_local.append(msg.vel_y)
        ax_local.append(msg.acc_x)
        timestamp_local.append(time.time() - t0)

def callback_control_signal(msg):
        global acc_pedal, brake_pedal, steering_angle, timestamp_control_signal
        acc_pedal.append(msg.acc_pedal_pos)
        brake_pedal.append(msg.brake_pedal_pos)
        steering_angle.append(msg.steering_angle)
        timestamp_control_signal.append(time.time() - t0)

def callback_pid(data):
    global timestamp_pid, origin_velocity, filter_velocity, desired_velocity, current_acceleration, PID_output
    timestamp_pid.append(time.time() - t0)
    js = json.loads(data.data)
    adrc = js["longitudinal_pid"]
    for item in adrc:
        if item["name"] == "origin_velocity":
            origin_velocity.append(item["value"])
        if item["name"] == "filter_velocity":
            filter_velocity.append(item["value"])
        if item["name"] == "desired_velocity":
            desired_velocity.append(item["value"])
        if item["name"] == "current_acceleration":
            current_acceleration.append(item["value"])
        if item["name"] == "PID_output":
            PID_output.append(item["value"])

def callback_pbc(data):
	global e_pose, e_angle, timestamp_pbc, pbc_pi, pbc_ff, pbc_output
	timestamp_pbc.append(time.time() - t0)
	js = json.loads(data.data)	
	lateral_pbc = js["lateral_pbc"]
	for item in lateral_pbc:
		if item["name"] == "pbc_e_pose":
                        e_pose.append(item["value"])
                if item["name"] == "pbc_e_angle":
                        e_angle.append(item["value"])
                if item["name"] == "pbc_pi_output":
                        pbc_pi.append(item["value"])
                if item["name"] == "pbc_ff_output":
                        pbc_ff.append(item["value"])
                if item["name"] == "pbc_output":
                        pbc_output.append(item["value"])

def callback_vehicle(msg):
        global timestamp_vehicle, vehicle_x, vehicle_y, vehicle_ang, vehicle_vel_x, vehicle_vel_y, vehicle_vel_ang, vehicle_acc_x, vehicle_acc_y, vehicle_acc_ang
        timestamp_vehicle.append(time.time() - t0)
        vehicle_x.append(msg.x)
        vehicle_y.append(msg.y)
        vehicle_ang.append(msg.ang)
        vehicle_vel_x.append(msg.vel_x)
        vehicle_vel_y.append(msg.vel_y)
        vehicle_vel_ang.append(msg.vel_ang)
        vehicle_acc_x.append(msg.acc_x)
        vehicle_acc_y.append(msg.acc_y)
        vehicle_acc_ang.append(msg.acc_ang)

def callback_gear(data):
        global timestamp_gear, gear
        timestamp_gear.append(time.time() - t0)
        gear.append(data.data)

def callback_pos_pid(data):
        global timestamp_pos_pid, e_longitudinal_pos, pos_loop_output, vel_loop_output, pos_pid_desired_vel, pos_pid_current_vel
        timestamp_pos_pid.append(time.time() - t0)    
	js = json.loads(data.data)	
	lateral_pbc = js["longitudinal_pid_pos"]
	for item in lateral_pbc:
		if item["name"] == "e_pos":
                        e_longitudinal_pos.append(item["value"])
                if item["name"] == "pos_loop_output":
                        pos_loop_output.append(item["value"])
                if item["name"] == "vel_loop_output":
                        vel_loop_output.append(item["value"])
                if item["name"] == "desired_vel":
                        pos_pid_desired_vel.append(item["value"])
                if item["name"] == "current_vel":
                        pos_pid_current_vel.append(item["value"])
  
         
def listen():
    global t0
    rospy.init_node('listener', anonymous = True)
    rospy.Subscriber("/av_control/control_debug/adrc", String, callback_adrc)
    rospy.Subscriber("/av_control/control_debug/lateral_kinematic", String, callback_kinematic)
    rospy.Subscriber("/av_planning/planning/trajectory", Trajectory, callback_trajectory)
    rospy.Subscriber("/av_localization/localization/localize", Localize, callback_localize)
    rospy.Subscriber("/av_control/control_signal", ControlSignal, callback_control_signal)
    rospy.Subscriber("/av_control/control_debug/pid", String, callback_pid)
    rospy.Subscriber("/av_control/control_debug/lateral_pbc", String, callback_pbc)
    rospy.Subscriber("/av_control/vehicle_state", VehicleState, callback_vehicle)
    rospy.Subscriber("/av_control/gear_state", Float64, callback_gear)
    rospy.Subscriber("/av_control/control_debug/pid_pos", String, callback_pos_pid)
    rospy.spin()


if __name__=='__main__':
        read_config()
	thread.start_new_thread(plot_figure,())
	listen()
