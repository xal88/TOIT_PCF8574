# PCF5874 and PCF5874A 8 channel I2C I/O expander

## Description

The PCF8574/PCF8574A is an 8 bits I/O port expander that uses the I2C protocol. 
The PCF8574 is a current sink device so you do not require the current limiting resistors.

The PCF8574 and PCF8574A have a maximum sinking current of 25mA. 
In applications requiring additional drive, two port pins may be connected together to sink up to 50mA current.
It has an inverted logic for relais, set "ON" tuns the Pin low, and "OFF" turns it high.

PCF8574 can mix input and output pins, but this driver only supports the output mode.
(e.g. for connecting the expander to an 8-channel relais )

Up to 8 PCF8574 plus 8 PCF8574A can be connected to one i2c bus, giving 2x8x8 = 128 I/O ports.

This library gives easy control over the 8 pins of one PCF8574 or PCF8574A chip.
These chips are identical in behavior although there are two distinct address ranges.

| TYPE     | ADDRESS-RANGE | notes                    |
|:---------|:-------------:|:------------------------:|
|PCF8574   |  0x20 to 0x27 | same range as PCF8575 !! |
|PCF8574A  |  0x38 to 0x3F |                          |

Base address = 0x20 + 0..7 depending on address pins A0..A2
P0,P1,P2,P3,P4,P5,P6,P7 are digital I/O ports
SDA,SCL are the I2C pins
![PCF8574 schemaaddressing](./PCF8574_ADR.jpg)

### constructor

### Read and Write
- **read all** reads all 8 pins at once. This one does the actual reading.
- **read pin** reads a single pin; pin = 0..7
- **on**
- **off**
- **toggle**  invert all

## schema
![PCF8574 schema](./esp32-and-pcf8574-layout_bb.webp)

## TODO: support INPUT detection via Interrupt


