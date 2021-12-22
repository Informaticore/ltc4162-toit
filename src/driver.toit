import serial
import .config
import .utils

I2C_ADDRESS ::= 0x68

class LTC4162:
  static REG_VBAT_ ::= 0x3A
  static REG_VIN ::= 0x3B
  static REG_VOUT ::= 0x3C
  static REG_IBAT ::= 0x3D
  static REG_IIN ::= 0x3E
  static REG_SYSTEM_STATUS ::= 0x39
  static REG_CHARGER_STATE ::= 0x34
  static REG_CHARGE_STATUS ::= 0x35
  static REG_CHEM_CELLS ::= 0x43
  static REG_CONFIG_BITS ::= 0x14
  static REG_DIE_TEMP ::= 0x3F

  static ADCGAIN ::= 18191.0
  static VINDIV ::= 30.0
  static VBATDIV ::= 3.5
  static RSNSB ::= 0.068
  static RSNSI ::= 0.068
  static AVPROG ::= 37.5
  static AVCLPROG ::= 37.5
  static VOUTDIV ::= 30.07
  static TEMP_OFFSET ::= 264.4
  static LSB ::= 10000

  registers_/serial.Registers

  constructor device/serial.Device:
    registers_ = device.registers

  /**
    Returns the VBAT (battery volatage) value as %.2f string
  */
  vbat -> string:
    cell_count := 1
    value := registers_.read_u16_le REG_VBAT_
    vbat := (((VBATDIV * cell_count)/ADCGAIN) * value).stringify 4
    debug "vbat reg: $value calculates to: $vbat"
    return vbat

  /**
    Returns the IBAT (battery current) value as %.2f string
  */
  ibat -> string:
    value := registers_.read_u16_le REG_IBAT
    debug "ibat register value: $value"
    ad_sensitivity := 1/(ADCGAIN*RSNSB*AVPROG)
    debug "ad_sensitivity: $ad_sensitivity"
    ibat := (ad_sensitivity * value).stringify 3
    debug "ibat reg: $value calculates to: $ibat A"
    return ibat

  /**
    Returns the VIN (voltage input) value as %.2f string
  */
  vin -> string:
    value := registers_.read_u16_le REG_VIN
    vin := ((VINDIV/ADCGAIN) * value).stringify 2
    debug "vin reg: $value calculates to: $vin"
    return vin

  /**
    Returns the IIN (input current) value as %.2f string
  */
  iin -> string:
    value := registers_.read_u16_le REG_IIN
    debug "iin register value: $value"
    ad_sensitivity := 1/(ADCGAIN*RSNSI*AVPROG)
    debug "ad_sensitivity: $ad_sensitivity"
    iin := (ad_sensitivity * value).stringify 3
    debug "iin reg: $value calculates to: $iin A"
    return iin
  
  /**
    Returns the VOUT (voltage output) value as %.2f string
  */
  vout -> string:
    value := registers_.read_u16_le REG_VOUT
    vout := ((VOUTDIV/ADCGAIN) * value).stringify 2
    debug "vout reg: $value calculates to: $vout V"
    return vout

  /**
    Returns the DIE_TEMP value as %.2f string
  */
  temp -> string:
    reg := registers_.read_u16_le REG_DIE_TEMP
    temp := (reg * 0.0215 - TEMP_OFFSET).stringify 2
    debug "temp reg: $reg calculates to: $temp C°"
    return temp

  /**
    Returns the current config of the LTC4162 as $config.Config object.
  */
  read_config -> Config:
    value := registers_.read_u8 REG_CONFIG_BITS
    debug "config bits: $value"
    return Config value

  write_config config/Config:
    registers_.write_u16_le REG_CONFIG_BITS config.config
    debug "config bits written: $config.config"

  /**
    Returns the current system status as int. See also $system_status_readable 
  */
  system_status -> int:
    value := registers_.read_u16_le REG_SYSTEM_STATUS
    debug "system status: " + value.stringify
    return value
  
  /**
    Encodes the given int $sys_stat to its readable string representation which can be looked up in the datasheet.
    Returns the current charge status as string.
    Use $system_status to receive the int value of the system_status
  */
  system_status_readable sys_stat/int:
    status_lst := []
    if (is_bit_set sys_stat 7):
      status_lst.add "intvcc_gt_2p8v"
    if (is_bit_set sys_stat 6):
      status_lst.add "vin_gt_4p2v"
    if (is_bit_set sys_stat 5):
      status_lst.add "vin_gt_vbat"
    if (is_bit_set sys_stat 4):
      status_lst.add "vin_ovlo: Input voltage shutdown protection is active: Input voltage above 38.6V"
    if (is_bit_set sys_stat 3):
      status_lst.add "thermal_shutdown"
    if (is_bit_set sys_stat 2):
      status_lst.add "no_rt"
    if (is_bit_set sys_stat 1):
      status_lst.add "cell_count_err"
    if (is_bit_set sys_stat 0):
      status_lst.add "en_chg"
    return status_lst

  /**
    Returns the current charger state as int. See also $charger_state_readable 
  */
  charger_state -> int:
    value := registers_.read_u16_le REG_CHARGER_STATE
    debug "charger state: $value"
    return value
  
  /**
    Encodes the given int $charger_state to its readable string representation.
    Returns the current charge status as readable string.
    Use $charger_state to receive the int value of the charge_status
  */
  charger_state_readable charger_state/int -> string:
    if charger_state == 1:
      return "Shorted Battery"
    else if charger_state == 2:
      return "Battery Missing"
    else if charger_state == 4:
      return "Max charge time reached"
    else if charger_state == 8:
      return "c over x term?!"
    else if charger_state == 16:
      return "Timer term?"
    else if charger_state == 32:
      return "NTC pause"
    else if charger_state == 64:
      return "Constant current / Constant Voltage charging phase"
    else if charger_state == 128:
      return "precharge phase"
    else if charger_state == 256:
      return "Suspended/Pending"
    else if charger_state == 2048:
      return "Thermal Regulation"
    else if charger_state == 4096:
      return "Bat Detect Failed"
    else:
      return "None"

  /**
    Returns the current charge status as int. See also $charge_status_readable 
  */
  charge_status -> int:
    value := registers_.read_u16_le REG_CHARGE_STATUS
    debug "charge status: " + value.stringify
    return value
  
  /**
    Encodes the given int $charge_status to its readable string representation.
    Returns the current charge status as readable string.
    Use $charge_status to receive the int value of the charge_status
  */
  charge_status_readable charge_status/int -> string:
    if charge_status == 0:
      return "Charging OFF"
    else if charge_status == 1:
      return "Constant Voltage"
    else if charge_status == 2:
      return "Constant Current"
    else if charge_status == 4:
      return "Input Current Crontrol active"
    else if charge_status == 8:
      return "Undervoltage Protection active"
    else if charge_status == 16:
      return "Thermal Regulation active"
    else if charge_status == 32:
      return "Dropout"
    else:
      return "None"
