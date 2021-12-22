import serial
import gpio
import i2c
import ltc4162
import config
import utils
import system_status
import telemetry

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

  config := ltc4162.read_config
  config.enable_force_telemetry_on true
  ltc4162.write_config config

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
