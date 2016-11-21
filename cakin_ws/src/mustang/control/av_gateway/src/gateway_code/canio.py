#_*_ coding:utf-8 _*_
import can
import json
import binascii
#from caneton import *
import caneton
#from caneton.encode import *
#from caneton.decode import *
import sys
import config
import logging
import gwlog
import time

#init log
log_path = config.log_path
logger = gwlog.initLog(log_path, config.logger_name, level=logging.INFO, when="H", backup=7)
logger.info("Success init logger %s, let\'s begin..." %log_path)
class canio:
    can_interface = ""
    bus = None
    dbc_file = ""
    json_handle = None
    recv_cnt = 0
    send_cnt = 0
    recv_suc = 0
    send_suc = 0
    def __init__(self, dbc_file = "./data/dbc.json", bus_type="socketcan_ctypes"):
        try:
            #open canbus
            self.can_interface = config.can_interface
            print self.can_interface
            print bus_type
            self.bus = can.interface.Bus(self.can_interface, bustype=bus_type)
            if not self.bus:
                raise BaseException("Bus Exception:failed to open bus")
            #open dbcjson
            self.dbc_file = config.data_file
            logger.info(self.dbc_file)
            with open(self.dbc_file) as dbc:
                self.json_handle = json.loads(unicode(dbc.read(), "ISO-8859-1"))
        except BaseException,e:
            val = sys.exc_info()[1]
            logger.error("Init canio failed!")
            logger.error(str(val))

    def monitor(self, item, freq):
        if item == "recv" and self.recv_cnt % freq == 0:
            if self.recv_cnt == 0:
                lmsg = "Monitor_recv:\treceived:%d,\ttotal:%d,\trate:NA" %(
                    self.recv_cnt, self.recv_suc)
            else:
                lmsg = "Monitor_recv:\treceived:%d,\ttotal:%d,\trate:%.2f" %(
                    self.recv_cnt, self.recv_suc, 1.0 * self.recv_suc / self.recv_cnt)
            logger.info(lmsg)
            print lmsg
        elif item == "send" and self.send_cnt % freq == 0:
            if self.send_cnt == 0:
                lmsg = "Monitor_send:\tsent:%d,\ttotal:%d,\trate:NA" %(
                    self.send_cnt, self.send_suc)
            else:
                lmsg = "Monitor_send:\tsent:%d,\ttotal:%d,\trate:%.2f" %(
                    self.send_cnt, self.send_suc, 1.0 * self.send_suc / self.send_cnt)
            logger.info(lmsg)
            print lmsg
        elif item == "all" and (self.send_cnt % freq == 0 or self.recv_cnt % freq == 0):
            if self.recv_cnt == 0:
                lmsg = "Monitor_recv:\treceived:%d,\ttotal:%d,\trate:NA" %(
                    self.recv_cnt, self.recv_suc)
            else:
                lmsg = "Monitor_recv:\treceived:%d,\ttotal:%d,\trate:%.2f" %(
                    self.recv_cnt, self.recv_suc, 1.0 * self.recv_suc / self.recv_cnt)
            logger.info(lmsg)
            print lmsg
            if self.send_cnt == 0:
                lmsg = "Monitor_send:\tsent:%d,\ttotal:%d,\trate:NA" %(
                    self.send_cnt, self.send_suc)
            else:
                lmsg = "Monitor_send:\tsent:%d,\ttotal:%d,\trate:%.2f" %(
                    self.send_cnt, self.send_suc, 1.0 * self.send_suc / self.send_cnt)
            logger.info(lmsg)
            print lmsg

    def send(self, msg_id, **msg):
        try:
            self.send_cnt += 1
            logger.info("SEND_data" + str(msg))
            print msg
            #encode message
            encoded_data = caneton.message_encode(msg_id, self.json_handle, **msg)
            print encoded_data
            logger.info("SEND_Encoded_data" + str(encoded_data))
            #build message
            timestp = time.mktime(time.localtime())
            message = can.Message(timestamp = timestp, arbitration_id=msg_id, data=encoded_data, extended_id=False)
            logger.info("SEND_Can_message:" + str(message))
            if self.bus.send(message) < 0:
                logger.warning("SEND_FAIL:fail_%d" %msg_id)
                raise Exception("Fail to send message")
            else:
                logger.info("SEND_Message_result:success_%d" %msg_id)
                self.send_suc += 1
                return True
        except BaseException,e:
            print e
            val= sys.exc_info()[1]
            logger.error("SEND_EXCEPTION:%s,fail_id:%d," %(str(val),msg_id))
            return False

    def receive_once(self):
        decoded_msg = {}
        try:
            message_r = self.bus.recv()
            #print "row message:"
            #print message_r
            logger.info("RECV_received_msg:%s" %str(message_r))
            message_data_str = ""
            for i in range(message_r.dlc):
                message_data_str += "%02x" %message_r.data[i]
            #print "received data in hex %s" %message_data_str
            message_hex = binascii.unhexlify(message_data_str)
            decoded_msg = caneton.message_decode(
                                                 message_id=message_r.arbitration_id, 
                                                 message_length=len(message_hex),
                                                 message_data=message_hex,
                                                 dbc_json=self.json_handle
                                                )
            s_msg = "%s:\t" %decoded_msg["name"]
            #check valid
            if len(decoded_msg["signals"]) == 0:
                logger.warning("Empty decoded_message.signal" + str(decoded_msg))
            else:
                self.recv_suc += 1
            #logging
            for k in decoded_msg["signals"]:
                s_msg += "%s=%d\t" %(k["name"],k["value"])
            logger.info("Decoded_msg:" + s_msg)

            #for it in decoded_msg["signals"]:
            #    print "name:%s,value:%d" %(it["name"], it["value"])
        except BaseException,e:
            val = sys.exc_info()[1]
            logger.error("RECV_once_failed,reason:%s" %(str(val)))
        finally:
            self.recv_cnt += 1
            return decoded_msg


if __name__ == "__main__":
    io = canio()
    if sys.argv[1] == "send":
        #msg = {"Vehicle_Speed":25, 
        #        "Steering_Angle":17,
        #        "Control_Flag":0,
        #        "Acceleartion":10
        #        }
        #147
        msg = {"VehicleSpeedValid":0,
                "CHKSM_ABS_ESC_2":100,
                "ALIVE_ABS_ESC_2":101,
                "Wheelspeed_RL":12,
                "Wheelspeed_RR":24,
                "Wheelspeed_RL_Valid":0,
                "Wheelspeed_RR_Valid":0,
                "VehicleSpeed":75
                }
        msg = { #178
                "CHKSM_EMS_3" :0,
                "ALIVE_EMS_3":13,
                "STAT_BrakePedal":0,
                "STAT_ClutchPedal":1,
                "EngineSpeed":500,
                "EngineIdleSpeed":200,
                "STAT_AcceleratorpedalPosition":30,
                "STAT_AcceleratorPosRaw":10
                }
        #267#
        ped = 0
        diff = 1
        #msg = {"CHKSM_GWM_1":0, 
        #        "ALIVE_GWM_1":1,
        #        "GModeInfo":1,
        #        "ActiveFaults":0,
        #        "OccuredFaults":0
        #        }
        m_id = int(sys.argv[2])
        io.send(m_id,**msg)
        #while ped < 5:
        #    ped += diff
        #    msg = {"CHKSM_ACU_4":0,
        #          "ALIVE_ACU_4":0,
        #          "ACU_TurnIndication":0,
        #          "ACU_STAT_AccPedalPos":ped
        #           }
        #    m_id = int(sys.argv[2])
        #    if not io.send(m_id, **msg):
        #        print "fail to send"
        #    else:
        #        print "succ send"
        #    if ped == 100 or ped == 0:
        #        diff = -1 * diff
        #    time.sleep(0.2)
         
    elif sys.argv[1] == "recv":
        i = 0
        result = open("./log/all" , "w")
        while True:
            decoded_msg = io.receive_once()
            if not decoded_msg:
                logger.error("error msg = "+ str(decoded_msg))
                logger.error("error to recv message, continue")
                continue
            #print "decoded message:"
            s_msg = "%s:\t" %decoded_msg["name"]
            for k in decoded_msg["signals"]:
                s_msg += "%s=%d\t" %(k["name"],k["value"])
            print s_msg
            i+=1
            io.monitor("recv", 5)
            #print "moni succ rate:%d/%d=%.2f" %(io.recv_suc, io.recv_cnt, 1.0*io.recv_suc/io.recv_cnt)
    elif sys.argv[1] == "moni":
        i = 0
        m_id = int(sys.argv[2])
        result = open("./log/%d" %m_id, "w")
        while True:
            decoded_msg = io.receive_once()
            print "decoded message:"
            if decoded_msg["id"] == m_id:
                s_msg = "%d:\t%s:\t" %(decoded_msg["id"], decoded_msg["name"])
                for k in decoded_msg["signals"]:
                    s_msg += "%s=%.2f\t" %(k["name"],k["value"])
                result.write(s_msg + "\n")
                i+=1
        result.close()
    else:
        print "Command not found/n Please choose \'send + id\' or \'recv\' "

