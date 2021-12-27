
class ChargerState:

  charger_state/int

  constructor value/int:
    charger_state = value

  is_charger_suspended -> bool:
    return charger_state == 256

  /**
    Returns the $charger_state to its readable string representation.
  */
  charger_state_readable -> string:
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