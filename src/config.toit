import .utils
import serial

class Config:
  static BIT_SUSPEND_CHARGER    ::= 2
  static BIT_RUN_BSR            ::= 3
  static BIT_TELEMETRY_SPEED    ::= 4
  static BIT_FORCE_TELEMETRY_ON ::= 5
  static BIT_MPPT_ENABLED       ::= 6

  config/int := 0

  constructor config_value/int:
    config = config_value

  enable_suspend_charger enable/bool:
    set_bit_ BIT_SUSPEND_CHARGER enable

  enable_run_bsr enable/bool:
    set_bit_ BIT_RUN_BSR enable

  enable_telemetry_speed enable/bool:
    set_bit_ BIT_TELEMETRY_SPEED enable

  enable_force_telemetry_on enable/bool:
    set_bit_ BIT_FORCE_TELEMETRY_ON enable

  enable_mppt_on enable/bool:
    set_bit_ BIT_MPPT_ENABLED enable

  set_bit_ bit/int enable/bool:
    if enable:
      config = enable_bit config bit
    else:
      config = disable_bit config bit

  is_suspend_charger_enabled -> bool:
    return is_bit_set config BIT_SUSPEND_CHARGER

  is_run_bsr_enabled -> bool:
    return (is_bit_set config BIT_RUN_BSR)

  is_telemetry_speed_enabled -> bool:
    return (is_bit_set config BIT_TELEMETRY_SPEED)

  is_force_telemetry_on_enabled -> bool:
    return (is_bit_set config BIT_FORCE_TELEMETRY_ON)

  is_mppt_on_enabled -> bool:
    return (is_bit_set config BIT_MPPT_ENABLED)
