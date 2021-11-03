//pcf8574 basic example

import gpio
import serial.protocols.i2c as i2c
import .driver show *

main:
  sda := gpio.Pin 22
  scl := gpio.Pin 21
  bus := i2c.Bus --sda=sda --scl=scl --frequency=100_000

  device := bus.device PCF8574.I2C_ADDRESS_ALT
  pcf := PCF8574 device

  ret := pcf.read        // reads status of all port and returns list
  print "PCF read $ret"

  pcf.set 2              // turn LED 2 on   ( range from 0..7 )
  sleep --ms=5000

  pcf.set 6              // turn LED 6 on
  sleep --ms=5000

  pcf.clear              // no Pin parameter -> clear ALL
  sleep --ms=5000

  pcf.set 6
  sleep --ms=5000

  pcf.toggle             // no Pin parameter -> toggle ALL
  
  