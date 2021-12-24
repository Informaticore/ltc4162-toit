import serial
import .system_config
import .utils
import .register as reg
import .charge_settings
import .charger_config

I2C_ADDRESS ::= 0x68

class LTC4162:

  /**
  internal span term of 18191 counts per Volt
  */
  static INTERNAL_SPAN_TERM ::= 18191.0
  static AD_GAIN ::= 37.5
  static VINDIV ::= 30.0
  static VBATDIV ::= 3.5
  static RSNSB ::= 0.068
  static RSNSI ::= 0.068
  static AVCLPROG ::= 37.5
  static VOUTDIV ::= 30.07
  static TEMP_OFFSET ::= 264.4

  registers_/serial.Registers

  constructor device/serial.Device:
    registers_ = device.registers

  /**
    Returns the VBAT (battery volatage) value as %.2f string
  */
  vbat -> string:
    cell_count := 1
    value := registers_.read_u16_le reg.VBAT
    vbat_span_term := ((VBATDIV * cell_count)/INTERNAL_SPAN_TERM) 
    vbat := (vbat_span_term * value).stringify 2
    debug "vbat reg: $value calculates to: $vbat"
    return vbat

  /**
    Returns the IBAT (battery current) value as %.2f string
  */
  ibat -> string:
    value := registers_.read_u16_le reg.IBAT
    debug "ibat register value: $value"
    ad_sensitivity := 1/(INTERNAL_SPAN_TERM*RSNSB*AD_GAIN)
    debug "ad_sensitivity: $ad_sensitivity"
    ibat := (ad_sensitivity * value).stringify 3
    debug "ibat reg: $value calculates to: $ibat A"
    return ibat

  /**
    Returns the VIN (voltage input) value as %.2f string
  */
  vin -> string:
    value := registers_.read_u16_le reg.VIN
    vin := ((VINDIV/INTERNAL_SPAN_TERM) * value).stringify 2
    debug "vin reg: $value calculates to: $vin"
    return vin

  /**
    Returns the IIN (input current) value as %.2f string
  */
  iin -> string:
    value := registers_.read_u16_le reg.IIN
    debug "iin register value: $value"
    ad_sensitivity := 1/(INTERNAL_SPAN_TERM*RSNSI*AD_GAIN)
    debug "ad_sensitivity: $ad_sensitivity"
    iin := (ad_sensitivity * value).stringify 3
    debug "iin reg: $value calculates to: $iin A"
    return iin
  
  /**
    Returns the VOUT (voltage output) value as %.2f string
  */
  vout -> string:
    value := registers_.read_u16_le reg.VOUT
    vout := ((VOUTDIV/INTERNAL_SPAN_TERM) * value).stringify 2
    debug "vout reg: $value calculates to: $vout V"
    return vout

  /**
    Returns the DIE_TEMP value as %.2f string
  */
  temp -> string:
    reg := registers_.read_u16_le reg.DIE_TEMP
    temp := (reg * 0.0215 - TEMP_OFFSET).stringify 2
    debug "temp reg: $reg calculates to: $temp C°"
    return temp

  /**
    Returns the current config of the LTC4162 as $config.SystemConfig object.
  */
  read_system_config -> SystemConfig:
    value := registers_.read_u8 reg.CONFIG_BITS_REG.REG_VALUE
    debug "config bits: $value"
    return SystemConfig value

  write_system_config config/SystemConfig:
    registers_.write_u16_le reg.CONFIG_BITS_REG.REG_VALUE config.config
    debug "config bits written: $config.config"

  /**
    Returns the current system status as int. See also $system_status_readable 
  */
  system_status -> int:
    value := registers_.read_u16_le reg.SYSTEM_STATUS
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
    value := registers_.read_u16_le reg.CHARGER_STATE
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
    value := registers_.read_u16_le reg.CHARGE_STATUS
    debug "charge status: " + value.stringify
    return value

  read_v_charge_settings -> ChargeSettings:
    jeita_6_5 := registers_.read_u16_le reg.CHARGE.VCHARGE_JEITA_6_5_REG
    jeite_4_3_2 := registers_.read_u16_le reg.CHARGE.VCHARGE_JEITA_4_3_2_REG
    return ChargeSettings jeita_6_5 jeite_4_3_2
  
  write_v_charge_settings charge_settings/ChargeSettings:
    registers_.write_u16_le reg.CHARGE.VCHARGE_JEITA_6_5_REG charge_settings.get_jeiter_6_5
    registers_.write_u16_le reg.CHARGE.VCHARGE_JEITA_4_3_2_REG charge_settings.get_jeiter_4_3_2

  read_i_charge_settings -> ChargeSettings:
    jeita_6_5 := registers_.read_u16_le reg.CHARGE.ICHARGE_JEITA_6_5_REG
    jeite_4_3_2 := registers_.read_u16_le reg.CHARGE.ICHARGE_JEITA_4_3_2_REG
    return ChargeSettings jeita_6_5 jeite_4_3_2
  
  write_i_charge_settings charge_settings/ChargeSettings:
    registers_.write_u16_le reg.CHARGE.ICHARGE_JEITA_6_5_REG charge_settings.get_jeiter_6_5
    registers_.write_u16_le reg.CHARGE.ICHARGE_JEITA_4_3_2_REG charge_settings.get_jeiter_4_3_2
  
  /**
    Returns a list containing config for en_c_over_x_term [0] and en_jeita [1]
  */
  read_charger_config -> ChargerConfig:
    value := registers_.read_u16_le reg.CHARGER_CONFIG_BITS.REG_VALUE
    return ChargerConfig value

  /**
    Writes charger config for en_c_over_x_term and en_jeita to the register
  */
  write_charger_config charger_config/ChargerConfig:
    registers_.write_u16_le reg.CHARGER_CONFIG_BITS.REG_VALUE charger_config.get_charger_config

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
