# Copyright (c) 2018 Amit Chahar
#
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

from bluetooth import *
import bss_pty

server_sock = BluetoothSocket(RFCOMM)
server_sock.bind(("", PORT_ANY))
server_sock.listen(1)

port = server_sock.getsockname()[1]

uuid = "347fb489-38fb-4325-898b-ec28b40c3c46"

advertise_service(server_sock, "Bluetooth-Server-Shell",
                  service_id=uuid,
                  service_classes=[uuid, SERIAL_PORT_CLASS],
                  profiles=[SERIAL_PORT_PROFILE],
                  )

print("Raspberry Pi BLE shell started")
print("Waiting for connections...")
print("Waiting for connection on RFCOMM channel %d" % port)

client_sock, client_info = server_sock.accept()
print("Accepted connection from ", client_info)

bss_pty.spawn("/bin/bash", client_sock)
# try:
#     while True:
#         data = client_sock.recv(1024)
#         if len(data) == 0:
#             break
#         print("received [%s]" % data)
# except IOError:
#     pass

print("disconnected")

client_sock.close()
server_sock.close()
print("all done")
