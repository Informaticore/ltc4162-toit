## 1.0.2 - 2021-12-24
* ADDED: the class register contains now all available register addresses of the LTC4162
* ADDED: multiple implementations of functions for the LTC4162. Check out the ltc4162 class to see all available functions
* ADDED: more test cases and testoiteron test-framework (maybe available some day)
* FIXED: replaced all u8 read/writes with u16 read/writes. the ltc4162 of course only uses 16bit values

## 1.0.1 - 2021-12-23
* FIXED: wrong system config bit values 
* FIXED: wrong system status bit values
* FIXED: wrong ibat and iin calculation

## 1.0.0 - 2021-12-22
Initial version containing following features:
* ADDED: Read VBAT
* ADDED: Read iBAT
* ADDED: Read VIN
* ADDED: Read iIN
* ADDED: Read VOUT
* ADDED: Read TEMP
* ADDED: Read Charge status
* ADDED: Read charger state (different from charge status)
* ADDED: Read system state
* ADDED: Read/Write config bits
* ADDED: basic testing of some functionallity 
* ADDED: "Test framework" testoiteron ;) with some basic assert functions