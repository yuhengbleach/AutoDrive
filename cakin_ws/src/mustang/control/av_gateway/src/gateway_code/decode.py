import binascii
import json

import caneton

def decode_message(m_id, data):
    with open('dbc.json') as dbc_file:
        dbc_json = json.loads(dbc_file.read())
        print(data)
        message_data = binascii.unhexlify(data)
        print("mess_len=%d" %len(message_data))
        message = caneton.message_decode(message_id=m_id,
            message_length=len(message_data), message_data=message_data,
            dbc_json=dbc_json)
        return message

