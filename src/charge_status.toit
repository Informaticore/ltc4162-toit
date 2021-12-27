
class ChargeStatus:

  charge_status/int

  constructor value/int:
    charge_status = value

  /**
    Encodes the given int $charge_status to its readable string representation.
    Returns the current charge status as readable string.
    Use $charge_status to receive the int value of the charge_status
  */
  charge_status_readable -> string:
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
