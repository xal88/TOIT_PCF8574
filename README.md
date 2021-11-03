# PCF5874 and PCF5874A 8 channel I2C I/O expander

An i2c TOIT driver for the PCF5874 and PCF5874A 8 channel I2C I/O expander

## Description

The PCF8574/PCF8574A is an 8 bits I/O port expander that uses the I2C protocol.  The PCB has an integrated Pullup restitor for SCL and SDA with only 1k Ohm. When using many of those devices on the same bus, unsolder most of them.

The PCF8574 is a current sink device so you do not require the current limiting resistors.The PCF8574 and PCF8574A have a maximum sinking current of 25mA. In applications requiring additional drive, two port pins may be connected together to sink up to 50mA current. As the PCD is a current sink,the logic is inverted. Setting the Pin to Active (1), pulls it low, and the relais is triggered.

PCF8574 can mix input and output pins, but this driver only supports the output mode.
(e.g. for connecting the expander to an 8-channel relais )

Up to 8 PCF8574 plus 8 PCF8574A can be connected to one i2c bus, giving 2x8x8 = 128 I/O ports.

| TYPE     | ADDRESS-RANGE | notes                    |
|:---------|:-------------:|:------------------------:|
|PCF8574   |  0x20 to 0x27 | same range as PCF8575 !! |
|PCF8574A  |  0x38 to 0x3F |                          |
|

![PCF8574 schemaaddressing](./PCF8574_ADR.jpg)

### usage
```
sda := gpio.Pin 21
scl := gpio.Pin 22
bus := i2c.Bus --sda=sda --scl=scl --frequency=100_000
i2c_device := bus.device PCF8574.I2C_ADDRESS
pcf := PCF8574 i2c_device

pcf.read       //  reads all 8 pins at once. This one does the actual reading. returns a list with 8 elements
pcf.set        //  turns all Pins ON
pcf.clear 5    //  turns Pin 5 OFF  ( Pin range is 0..7 )
pcf.toggle     //  inverts all pins
pcf.toggle 2   //  inverts pin #2   
```

### schema
![PCF8574 schema](./esp32-and-pcf8574-layout_bb.webp)

## TODO: support INPUT detection via Interrupt

