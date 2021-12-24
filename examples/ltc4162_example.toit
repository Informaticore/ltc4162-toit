import serial
import gpio
import i2c
import ltc4162
import system_config
import utils
import system_status
import telemetry

main:
  bus := i2c.Bus
      --sda=gpio.Pin 21
      --scl=gpio.Pin 22

  device := bus.device ltc4162.I2C_ADDRESS
  ltc4162 := ltc4162.LTC4162 device

  // Read system status and print all enabled ones
  system_status := ltc4162.read_system_status
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

  // Read all telemetry relevant registers and prints them to the terminal
  telemetry := telemetry.Telemetry ltc4162
  print ""
  charge_status := telemetry.charge_status
  print "Charge Status: $charge_status"
  charge_status_readable := telemetry.charge_status_r
  print "Charge Status: $charge_status_readable"

  print ""
  charger_state := telemetry.charger_state
  print "Charger State: $charger_state"
  charger_state_readable := telemetry.charger_state_r
  print "Charger State: $charger_state_readable"
  
  print ""
  print "VIN:   $telemetry.vin V"
  print "IIN:   $telemetry.iin A"
  print "VBAT:  $telemetry.vbat V"
  print "IBAT:  $telemetry.ibat A"
  print "VOUT:  $telemetry.vout V"
  print "TEMP:  $telemetry.temp C°"
