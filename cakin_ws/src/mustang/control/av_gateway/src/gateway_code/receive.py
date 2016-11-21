import can
import decode

can_interface = 'can1'
bus = can.interface.Bus(can_interface, bustype='socketcan_ctypes')
print(bus)
if not bus:
    print("fail to open bus")
#bus = can.interface.Bus()
message = bus.recv()
cnt  = 0
while message and cnt < 2:
    cnt += 1
    print(message)
    t_data = ""
    for i in range(message.dlc):
        tmp = "%02x" %message.data[i]  # important
        t_data = t_data + tmp
    print "received data in hex:"
    print t_data
    result = decode.decode_message(message.arbitration_id, t_data)
    print(cnt)
    for it in result["signals"]:
        print("name:%s,value:%d\n====" %(it["name"], it["value"]))
    message = bus.recv()
