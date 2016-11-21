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

m_id = 267
control_cycle =  0.02 # in ms

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

def record(t0, v, pos, result):
    print_msg = "time: %.2f s \t v: %.3f km/h \t pedal: %.3f" %(t0, v, pos)
    log_msg = "time:%.2f v:%.3f pedal:%.3f" %(t0, v, pos)
    print print_msg
    result.write(log_msg + "\n")

def plot_data(time_str):
    global v_d, ts, vs, us, control_cycle
    fig = plt.figure(1)
    while True:
        plt.clf()
        plt.title('Step Response')
        plt.subplot(2,1,1)
        plt.hold(True)
        plt.plot(ts,vs,linewidth=2.0)
        plt.xlabel('time [s]')
        plt.ylabel('velocity [km/h]')
        plt.subplot(2,1,2)
        plt.plot(ts,us,linewidth=2.0)
        plt.xlabel('time [s]')
        plt.ylabel('pedal position [%]')
        plt.draw()
        plt.pause(0.001)


u=5
t1=1
t2=5
ts=[]
vs=[]
us=[]
if len(sys.argv)>1:
    u = float(sys.argv[1])
if len(sys.argv)>2:
    t1 = float(sys.argv[2])
if len(sys.argv)>3:
    t2=float(sys.argv[3])
t0 = time.time()
time_str = time.strftime("%m%d-%H%M%S")
thread.start_new_thread(plot_data,(time_str,))
try:
    with open("logs/model_test-%s.txt" %time_str,"w") as result:
        # config_msg = "u=%.3f \t t1=%.3f \t t2=%.3f \n"%(u, t1, t2)
        # result.write(config_msg)
        while True:
            t_start = time.time()
            t = t_start-t0
            v = get_current_vel()
            pos = 0
            if t>t1 and t<t2:
                pos = u
            send_pedal_pos(pos)
            record(t, v, pos, result)
            ts.append(t)
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
