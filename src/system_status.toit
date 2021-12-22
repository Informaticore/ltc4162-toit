import .utils

class SystemStatus:

  static BIT_INTVCC_GT_2P8V   ::= 7
  static BIT_VIN_GT_4P2V      ::= 6
  static BIT_VIN_GT_VBAT      ::= 5
  static BIT_VIN_GT_OVLO      ::= 4
  static BIT_THERMAL_SHUTDOWN ::= 3
  static BIT_NO_RT            ::= 2
  static BIT_CELL_COUNT_ERROR ::= 1
  static BIT_EN_CHG           ::= 0

  system_status := 0

  constructor system_status_value/int:
    system_status = system_status_value

  /**
    Returns true if INTVCC pin voltage is greater than the telemetry system lockout level (2.8V typical) false otherwise
  */
  is_intvcc_gt_2p8v -> bool:
    return is_bit_set system_status BIT_INTVCC_GT_2P8V

  /**
    Returns true if  VIN pin voltage is at least greater than the switching regulator undervoltage lockout level (4.2V typical) false otherwise
  */
  is_vin_gt_4p2v -> bool:
    return is_bit_set system_status BIT_VIN_GT_4P2V

  /**
    Returns true if VIN pin voltage is sufficiently above the battery voltage to begin a charge cycle (typically +150mV) false otherwise
  */
  is_vin_gt_vbat -> bool:
    return is_bit_set system_status BIT_VIN_GT_VBAT

  /**
    Returns true if input voltage shutdown protection is active due to an input voltage above its protection shut-down threshold of approximately 38.6V. false otherwise
  */
  is_vin_ovlo -> bool:
    return is_bit_set system_status BIT_VIN_GT_OVLO

  /**
    Returns true if the LTC4162 is in thermal shutdown protection due to an excessively high die temperature (typically 150°C). false otherwise
  */
  is_thermal_shutdown -> bool:
    return is_bit_set system_status BIT_THERMAL_SHUTDOWN

  /**
    Returns true if no frequency setting resistor is detected on the RT pin. The RT pin impedance detection circuit will typically indicate a missing 
    RT resistor for values above 1.4MΩ. no_rt always indicates true when the battery charger is not enabled such as when there is no input power available.
  */
  is_no_rt -> bool:
    return is_bit_set system_status BIT_NO_RT

  /**
    Returns true if a cell count error occurs and charging will be inhibited if the CELLS0 and CELLS1 pins are programmed for more than 8 cells. 
    cell_count_err always indicates true when telemetry is not enabled such as when the charger is not enabled.
  */
  is_cell_count_err -> bool:
    return is_bit_set system_status BIT_CELL_COUNT_ERROR

  /**
    Returns true if battery charger is enabled, false otherwise
  */
  is_en_chg -> bool:
    return is_bit_set system_status BIT_EN_CHG
