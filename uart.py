import serial
import keyboard

ser = serial.Serial('COM3', 115200)  # change COM port to yours

while True:
    if keyboard.is_pressed('a'):
        ser.write(bytes([0x01]))
    elif keyboard.is_pressed('s'):
        ser.write(bytes([0x02]))
    elif keyboard.is_pressed('d'):
        ser.write(bytes([0x03]))
    elif keyboard.is_pressed('f'):
        ser.write(bytes([0x04]))