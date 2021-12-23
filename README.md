# ltc4162-toit
Library to control a LTC4162 Charger IC with toitlang

## Getting Started

```
  bus := i2c.Bus
      --sda=gpio.Pin 21
      --scl=gpio.Pin 22
 
  device := bus.device ltc4162.I2C_ADDRESS
  ltc4162_ := ltc4162.LTC4162 device
```
First you create the i2c.Bus with the i2c pin. With this bus you can create the i2c device and finaly using this device to generate the LTC4162 object.

