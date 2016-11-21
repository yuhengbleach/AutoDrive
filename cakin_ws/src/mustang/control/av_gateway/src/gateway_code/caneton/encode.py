# -*- coding: utf-8 -*-

import json
import exceptions
import compat
import logging
import chksm

logger = logging.getLogger("av_gateway")
MESSAGE_MAX_LENGTH = 8

def message_encode(message_id="-1", dbc_json=None, **message_data):
    """encode a CAN message
    expect message_data contains id=n,X=a,T=b
    Args:
        message_id: int, message identifier
        dbc_json: dict
        message_data: dict, contains message data
    Returns:
        message
    Raises:
        exception.Invalid: when used DBC has not message entry
        exception.MessageNotFound: when message's ID is not found in the DBC
    """
    if "messages" not in dbc_json:
        raise exception.InvalidDBC("InvalidDBC file (no messages entry)")
    #print "start encoding message===================="


    #Initialize the return
    message = {}
    try:
        message_info = dbc_json['messages'][str(message_id)]
        message['name'] = message_info['name']
        message['id'] = message_id
        message['length'] = message_info['length']
        message['data'] = None
    except KeyError:
        raise exceptions.MessageNotFound(
            "Message ID {id:d} (0x{id:x}) not found in DBC".format(id=message_id))
    

    message_length = message['length']
    message_binary_length = message_length * 8
    #logger.info("message_binary_length %d" %message_binary_length)
    message_binary = ['0'] * message_binary_length

    #check valid
    for k in message_info["signals"].keys():
        if message_data.get(k, None) is None:
            raise exceptions.SignalNotFound(
                    "Data Fault:signal not found in message_data,Invalid signalnanme:%s" %k)
        else:
            pass
            #print "data %s=%d" %(k,message_data.get(k))

    #if enough data to fill in a message
    for sig_name in message_info["signals"].keys():
        #print sig_name
        signal_info = message_info["signals"][sig_name]
        ori_value = message_data.get(sig_name)
        factor = signal_info.get("factor", 1)
        offset = signal_info.get("offset", 0)
        v_min = signal_info.get("min", '')
        v_max = signal_info.get("max", '')
        ori_value = min(max(ori_value, v_min) , v_max)
        little_endian = signal_info.get("little_endian")
        signal_info_length = signal_info.get("length")
        bit_start = signal_info.get("bit_start")
        #print "origin=%f" %ori_value
        #print "result=(%f-%f)/%f=%f" %(ori_value,offset,factor,(ori_value-offset)/factor)
        s_pas_value = bin(int(round((ori_value - offset ) / factor)))[2:].zfill(signal_info_length)
        #print "kv: %s:%d" %(sig_name,ori_value)
        #print s_pas_value
        is_little_endian = bool(little_endian)
        if is_little_endian:
            end = message_binary_length - bit_start
            start = end - signal_info_length
        else:
            start = (bit_start // 8) * 8 + 7 - (bit_start % 8)
            end = start - signal_info_length
        message_binary[start:end] = s_pas_value

    #show message_binary
    #print "message_binary is:"
    #print message_binary
    #print "message_len = %d" %len(message_binary)
    #print ''.join(message_binary)
    i_value = int(''.join(message_binary), 2)
    bytess = [0] * message_length
    for i in range(message_length):
        if is_little_endian:
            bytess[i] = i_value % pow(2,8)
        else:
            bytess[message_length - 1 -i] = i_value % pow(2, 8)
        #print "%d,%d" %(i,bytess[i])
        i_value = i_value >> 8
    #print "encoded data in oct="
    #print bytess
    #print "finish encoding message==================="
    print "before chksm:"
    print bytess
    chksm.calc_chksm(bytess)
    print "after chksm:"
    print bytess
    return bytess
    #message_str = ""
    #for bt in bytess:
    #    message_str += "%02x" %bt
    #print "returned message:%s" %message_str
    #return message_str


if __name__ == '__main__':
    msg = {"Vehicle_Speed":25, 
            "Steering_Angle":17,
            "Control_Flag":0,
            "Acceleartion":10
            }
    m_id = 256
    with open("../dbc.json") as dbc_file:
        dbc_json = json.loads(dbc_file.read())
    message_encode(m_id, dbc_json, **msg)

