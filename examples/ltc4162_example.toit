import serial
import gpio
import i2c
import ltc4162
import system_config
import utils
import system_status
import register
import pubsub

topic ::= "cloud:telemetry"

main:
  bus := i2c.Bus
      --sda=gpio.Pin 21
      --scl=gpio.Pin 22

  device := bus.device ltc4162.I2C_ADDRESS
  ltc4162 := ltc4162.LTC4162 device

  // Read system status and print all enabled ones
  system_status := ltc4162.read_system_status
  print system_status.system_status
  status_list := system_status.get_status_as_string_list
  print "System Status:"
  status_list.do: | item |
    print " -> $item" 

  // Read system config from the device and enables force_telementry_on to be enabled and
  // also enabled the MPPT algorithm and writes the config back to the device
  system_config := ltc4162.read_system_config
  system_config.enable_force_telemetry_on true
  system_config.enable_mppt_on true
  ltc4162.write_system_config system_config

  // Read the charger config and enables C/x termination once the battery reaches constant voltage
  charger_config := ltc4162.read_charger_config
  charger_config.en_c_over_x_term = true
  ltc4162.write_charger_config charger_config

  charge_status := ltc4162.read_charge_status
  print "Charge Status: $charge_status.charge_status_readable"

  // Read all telemetry relevant registers and prints them to the terminal
  charger_state := ltc4162.read_charger_state
  print "Charger State: $charger_state.charger_state_readable"
  
  payload := ""
  payload += "Status: $charge_status.charge_status_readable\n"
  payload += "Status value: $charge_status.charge_status\n"
  payload += "VIN:   $ltc4162.vin V\n"
  payload += "IIN:   $ltc4162.iin A\n"
  payload += "VBAT:  $ltc4162.vbat V\n"
  payload += "IBAT:  $ltc4162.ibat A\n"
  payload += "VOUT:  $ltc4162.vout V\n"
  payload += "TEMP:  $ltc4162.temp C°\n"
  print payload

  //some functions are not yet implemented with the ltc-driver but you can read registers as follows
  chem_cells := ltc4162.read register.CHEM_CELLS_REG.REG_VALUE
  cell_count := utils.read_bits chem_cells register.CHEM_CELLS_REG.CELL_COUNT_FROM_BIT register.CHEM_CELLS_REG.CELL_COUNT_TO_BIT
  //print cell_count

  json := {
    "charger": charge_status.charge_status_readable,
    "vin": ltc4162.vin,
    "iin": ltc4162.iin,
    "vbat": ltc4162.vbat,
    "ibat": ltc4162.ibat,
    "vout": ltc4162.vout,
    "temp": ltc4162.temp
  }

  //pubsub.publish topic charge_status.charge_status_readable