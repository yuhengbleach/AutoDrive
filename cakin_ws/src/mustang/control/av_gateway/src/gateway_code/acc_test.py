import canio
import time
import sys

#send acc message,id 267 ,0x10b

io = canio.canio("can0","./data/new.json")
def cyclic_send(m_id, cycle, times, message):
    for i in range(times):
        io.send(m_id, **message)
        time.sleep(cycle/1000.0)
        print "aleady sent m_id:%d for %d times" %(m_id, times)

def main():
    acc_v = 0
    need = 10.0 * 1000
    top = 20.0
    cnt = 50
    i = 0
    if len(sys.argv) == 1:
        while True:
            while acc_v <= top:
                print acc_v
                message = {"CHKSM_ACU_4":0,
                           "ALIVE_ACU_4":0,
                           "ACU_TurnIndication":0,
                           "ACU_STAT_AccPedalPos":acc_v
                        }
                m_id = 267
                cyclic_send(m_id, need/top, 1, message)
                acc_v += 2
                print ""
            while True:
                print acc_v
                message = {"CHKSM_ACU_4":0,
                           "ALIVE_ACU_4":0,
                           "ACU_TurnIndication":0,
                           "ACU_STAT_AccPedalPos":20
                        }
                m_id = 267
                cyclic_send(m_id, need/top, 1, message)
                acc_v = max(min(acc_v, top), 0)
                i += 1
                print ""
            while True:
                print acc_v
                message = {"CHKSM_ACU_4":0,
                           "ALIVE_ACU_4":0,
                           "ACU_TurnIndication":0,
                           "ACU_STAT_AccPedalPos":0
                        }
                m_id = 267
                cyclic_send(m_id, 20, 1, message)
                acc_v -= 1
                acc_v = max(min(acc_v, top), 0)
                print ""
    elif len(sys.argv) == 2:
        cc = int(sys.argv[1])
        while True:
            while acc_v <= 100:
                print acc_v
                message = {"CHKSM_ACU_4":0,
                           "ALIVE_ACU_4":0,
                           "ACU_TurnIndication":0,
                           "ACU_STAT_AccPedalPos":acc_v
                        }
                m_id = 267
                cyclic_send(m_id, cc, 1, message)
                acc_v += 1
                print ""
            while acc_v >=0:
                print acc_v
                message = {"CHKSM_ACU_4":0,
                           "ALIVE_ACU_4":0,
                           "ACU_TurnIndication":0,
                           "ACU_STAT_AccPedalPos":acc_v
                        }
                m_id = 267
                cyclic_send(m_id, cc, 1, message)
                acc_v -= 1
                print ""


if __name__ == "__main__":
    main()
