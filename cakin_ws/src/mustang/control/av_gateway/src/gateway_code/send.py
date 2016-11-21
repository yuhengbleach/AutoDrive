from __future__ import print_function

import can
import time
import json
import sys
from caneton.encode import *

def main(m_id):
    s = 0
    f = 0
    i = 0
    msg = {"CHKSM_GWM_1":0, 
            "ALIVE_GWM_1":1,
            "GModeInfo":1,
            "ActiveFaults":0,
            "OccuredFaults":0
            }
    m_id = int(m_id)
    with open("./data/dbc.json") as dbc_file:
        dbc_json = json.loads(unicode(dbc_file.read(), "ISO-8859-1"))
    encoded_data = message_encode(m_id, dbc_json, **msg)
    bus = can.interface.Bus('can1',bustype='socketcan_ctypes')
    if not bus:
        print("failed to open bus")
    msg = can.Message(arbitration_id=m_id, data=encoded_data, extended_id=False)
    print(msg)
    while i < 5:
        time.sleep(0.02)
        i += 1
        if bus.send(msg) < 0:
            print("Message NOT sent:%d" %i)
            f += 1
        else:
            s += 1
            print("Message sent:%d" %i)
    print("i:%d,s:%d,f:%d" %(i,s,f))

if __name__ == "__main__":
    main(sys.argv[1]) 
