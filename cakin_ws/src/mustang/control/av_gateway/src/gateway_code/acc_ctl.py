import threading
import getch
import time,sys
import canio
import select


#send acc message,id 267 ,0x10b
diff = 2
io = canio.canio()
acc_value = 0
g_id = 267
g_cycle = 1000
mutex = threading.Lock()

def heardEnter():
    sys.stdin.flush()
    i,o,e = select.select([sys.stdin],[],[],1)
    for s in i:
        if s == sys.stdin:
            rcode = sys.stdin.read(1)
            print "input a value:" + rcode
            return rcode
    return False

def cyclic_send(m_id, cycle, times, message):
    if(io.send(m_id, **message)):
        print "already sent m_id:%d " %(m_id)
    else:
        print "fail to send m_id:%d" %m_id
    time.sleep(cycle/1000.0)
#def cyclic_send(m_id, cycle, times, message):
#    print "cyclic send:"
#    for i in range(times):
#        io.send(m_id, **message)
#        time.sleep(cycle/1000.0)
#        print "aleady sent m_id:%d for %d times" %(m_id, i)

class KeyEventThread(threading.Thread):
    def run(self):
        # your while-loop here
        print "start kb thread"
        global acc_value
        while True:
            z = heardEnter()
            print "======get input:%s" %z
            if not z:
                #time.sleep(0.5)
                continue
            elif z == "a":
                if mutex.acquire(1):  
                    acc_value += diff
                    acc_value = max(min(100, acc_value),0)
                    print "acc:%d" %acc_value
                    mutex.release()
            elif z == "d":
                if mutex.acquire(1):
                    acc_value -= 5
                    acc_value = max(min(100, acc_value),0)
                    print "dece:%d" %acc_value
                    mutex.release()
            elif ord(z) == 27:
                print "Exit process"
                break
            #time.sleep(0.5)
class SendEvent(threading.Thread):
    def run(self):
        print "start sending thread"
        global acc_value
        while True:
            message = {"CHKSM_ACU_4":0,
                  "ALIVE_ACU_4":0,
                  "ACU_TurnIndication":0,
                  "ACU_STAT_AccPedalPos":acc_value
                  }
            cyclic_send(g_id, g_cycle, 1, message)
            print ""


def main():
    kethread = KeyEventThread()
    sendthread = SendEvent()
    threads = []
    threads.append(sendthread)
    threads.append(kethread)
    for t in threads:
        t.setDaemon(True)
        t.start()
    for t in threads:
        t.join()

if __name__ == "__main__":
    main()
