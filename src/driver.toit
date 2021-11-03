import binary show BIG_ENDIAN
import serial
import serial.protocols.i2c as i2c
import gpio

/**
TOIT driver PCF8574 i2c I/O port expander
*/

class PCF8574:
  device_ /i2c.Device

  /** The default I2C address base for the PCF8574 plus Jumper setting A2, A1, A0 */
  static I2C_ADDRESS ::= 0x20
  static I2C_ADDRESS_000 ::= 0x20
  static I2C_ADDRESS_001 ::= 0x21
  static I2C_ADDRESS_010 ::= 0x22
  static I2C_ADDRESS_011 ::= 0x23
  static I2C_ADDRESS_100 ::= 0x24
  static I2C_ADDRESS_101 ::= 0x25
  static I2C_ADDRESS_110 ::= 0x26
  static I2C_ADDRESS_111 ::= 0x27
  
  _state := 0b00000000         // default to all OFF, after power on 
  _stateL := [0,0,0,0,0,0,0,0]
  _mask  := 0b11111111         // all PIns 
  
  /** The alternate I2C address base for the PCF8574A  */
  static I2C_ADDRESS_ALT ::= 0x38

  constructor .device_:
    _bytes := device_.read 1
    _state = _bytes[0] ^ 0b11111111

  read:    // no filter, alway return array with 8 elements
    _bytes := device_.read 1
    _state = _bytes[0] ^ 0b11111111
    return bin2list( _state )   // inverted result 1 = ON

  set pin="ALL":      // pin = ALL sets all pin
    _mask = validate_pin pin
    _state = _state  | _mask 
    device_.write #[( _state ^ 0b11111111 ) ]
    return bin2list(_state )

  clear pin="ALL":      // pin = pin number [0..7], ALL sets all pin
    _mask = validate_pin pin
    _state = _state & ( _mask ^ 0b11111111 )  
    device_.write #[( _state ^ 0b11111111 ) ]
    return bin2list(_state )
  
  validate_pin pin:   // pin valid range 0..7, ALL
    if pin == "ALL":
      return 0b11111111
    else if pin <= 7 and pin >= 0:
      return 1 << pin
    else:
      print "Invalid pin $pin. Use 0-7, or 'ALL'"
      return 0b00000000
    
  toggle pin = "ALL":
    _mask = validate_pin pin
    _state = _state ^ _mask
    device_.write #[(_state ^ 0b11111111 ) ]
    return bin2list(_state)   // inverted result 1 = ON

  bin2list value:   // take binary 8 bit and write to on/off array
    8.repeat:
      _stateL[it] = value%2
      value = value >> 1
    return _stateL


      
    
     
    
    