import serial

with serial.Serial('COM6', baudrate=115200) as ser:
    print(ser.read(20))