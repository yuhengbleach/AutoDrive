import canio
import time
import thread
import sys
import matplotlib.pyplot as plt

#send acc message,id 267 ,0x10b
try: 
    import xml.etree.cElementTree as ET 
except ImportError: 
    import xml.etree.ElementTree as ET 

io = canio.canio("can0","./data/new.json")

control_cycle =  0.02 # in ms

v_d = 0
k_p = 1
k_i = 0
pedal_gain = 0
e_i = 0
max_e_i = 10
max_pedal = 10
m_id = 267

ts=[]
vs=[]
us=[]

def send_pedal_pos(pos):
    msg = {"CHKSM_ACU_4":0, "ALIVE_ACU_4":0, "ACU_TurnIndication":0, "ACU_STAT_AccPedalPos":pos}
    io.send(m_id, **msg)

def get_current_vel():
    vel_valid = False
    vel = 0
    while not vel_valid:
        msg = io.receive_once()
    #msg = {"signals": [{"name":"VehicleSpeed", "value":1}]}
        for k in msg["signals"]:
            if k["name"] == "VehicleSpeed":
                vel = k["value"]
                vel_valid = True
    return vel

def read_config():
    global control_cycle, k_p, k_i, pedal_gain, max_e_i, max_pedal, m_id
    try:
        tree = ET.parse("params.xml")
        root = tree.getroot()
        control_cycle = float(root.find("control_cycle").text)
        k_p = float(root.find("k_p").text)
        k_i = float(root.find("k_i").text)
        pedal_gain = float(root.find("pedal_gain").text)
        max_e_i = float(root.find("max_e_i").text)
        max_pedal = float(root.find("max_pedal").text)
        m_id = int(root.find("m_id").text)
    except Exception, e:
        print "Error to parse params.xml"

def controller(v):
    global e_i,v_d,k_p,k_i,max_u,max_e_i,control_cycle
    e = v_d - v
    e_i += e*control_cycle
    if e_i > max_e_i:
        e_i = max_e_i
    u = k_p*e + k_i * e_i
    pos = pedal_gain*u
    if pos > max_pedal:
        pos = max_pedal
    elif pos < 0:
        pos = 0
    return pos

def record(t0, v, pos):
    global v_d
    e = v_d - v
    e_ratio = e/v_d
    print_msg = "time: %.2f s \t v: %.3f km/h \t e: %.3f km/h \t e_i: %.3f km/h e_ratio: %.3f \t pedal: %.3f" %(t0, v, e, e_i, e_ratio, pos)
    print print_msg

def plot_data(time_str):
    global v_d, ts, vs, us, control_cycle
    fig = plt.figure(1)
    while True:
        plt.clf()
        plt.title('Vehicle Speed Control')
        plt.subplot(2,1,1)
        plt.hold(True)
        plt.plot(ts,vs,linewidth=2.0)
        vds = [v_d] * len(ts)
        plt.plot(ts,vds,'r--',linewidth=2.0)
        plt.xlabel('time [s]')
        plt.ylabel('velocity [km/h]')
        plt.subplot(2,1,2)
        plt.plot(ts,us,linewidth=2.0)
        plt.xlabel('time [s]')
        plt.ylabel('pedal position [%]')
        plt.draw()
        plt.pause(0.001)


if len(sys.argv)>1:
    v_d = float(sys.argv[1])
read_config()
t0 = time.time()
time_str = time.strftime("%m%d-%H%M%S")
thread.start_new_thread(plot_data,(time_str,))
try:
    with open("logs/%s.txt" %time_str,"w") as result:
        config_msg = "control_cycle=%.3f \t k_p=%.3f \t k_i=%.3f \t pedal_gain=%.3f \t max_e_i=%.3f \t max_pedal=%.3f \n"%(control_cycle, k_p, k_i, pedal_gain, max_e_i, max_pedal)
        result.write(config_msg)
        while True:
            t_start = time.time()
            v = get_current_vel()
            pos = controller(v)
            send_pedal_pos(pos)
            record(t_start-t0, v, pos)
            ts.append(t_start-t0)
            vs.append(v)
            us.append(pos)
            delta_t = time.time() - t_start
            if delta_t<control_cycle:
                time.sleep(control_cycle-delta_t)
except Exception,e:
    print e
finally:
    send_pedal_pos(0)
    print 'exiting with zero pedal position'
    input("Press any key to exit")
