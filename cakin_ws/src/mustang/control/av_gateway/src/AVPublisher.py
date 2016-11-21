import rospy
from std_msgs.msg import String
from gateway_code import canio
import json

io = canio.canio()
def callback(data):
    global io
    #rospy.loginfo(rospy.get_caller_id() + 'I heard %s', data.data)
    js = json.loads(data.data)
    #rospy.loginfo(js)
    msg = {}
    m_id = js["id"]
    signals = js["signals"]
    for item in signals:
        msg[item["name"]]=item["value"]
    rospy.loginfo(msg)
    io.send(m_id, **msg)

def AVtoGW():
    rospy.init_node('AVtoGW', anonymous=True)

    rospy.Subscriber('gateway_ag', String, callback)

    # spin() simply keeps python from exiting until this node is stopped
    rospy.spin()

if __name__ == '__main__':
    AVtoGW()
