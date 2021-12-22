import serial
import gpio
import i2c
import ltc4162
import config
import utils
import system_status

main:
  bus := i2c.Bus
      --sda=gpio.Pin 21
      --scl=gpio.Pin 22

  device := bus.device ltc4162.I2C_ADDRESS
  ltc4162 := ltc4162.LTC4162 device

  system_status := system_status.SystemStatus ltc4162.system_status
  print "System Status: $system_status.system_status"
  if system_status.is_en_chg: print "Battery Charger Enabled"
  if system_status.is_cell_count_err: print "Cell count error detected"
  if system_status.is_intvcc_gt_2p8v: print "INTVCC voltage is greater then 2.8V"
  if system_status.is_vin_gt_4p2v: print "VIN is greater then 4.2V"
  if system_status.is_no_rt: print "No frequency setting resistor is detected on the RT pin"
  if system_status.is_thermal_shutdown: print "LTC4162 is in thermal shutdown protection due to an excessively high die temperature (typically 150°C)"
  if system_status.is_vin_ovlo: print "LTC4162 is in Protection shut-down"
  if system_status.is_vin_gt_vbat: print "VIN is sufficiently above the battery voltage"

  print ""
  charge_status := ltc4162.charge_status
  print "Charge Status: $charge_status"
  charge_status_readable := ltc4162.charge_status_readable charge_status
  print "Charge Status: $charge_status_readable"

  print ""
  charger_state := ltc4162.charger_state
  print "Charger State: $charger_state"
  charger_state_readable := ltc4162.charger_state_readable charger_state
  print "Charger State: $charger_state_readable"
  
  print ""
  print "VIN:   $ltc4162.vin V"
  print "IIN:   $ltc4162.iin A"
  print "VBAT:  $ltc4162.vbat V"
  print "IBAT:  $ltc4162.ibat A"
  print "VOUT:  $ltc4162.vout V"
  print "TEMP:  $ltc4162.temp C°"

  print ""
  //ltc4162.force_telemetry_on true