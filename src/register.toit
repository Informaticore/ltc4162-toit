/**
  This file contains all register addresses which are available on the LTC4162. 
  Some registers have multiple which are also reflected in extra register classes
  with dedicated bit values. Also ranges of values are reflected in the form of FROM_BIT and TO_BIT
  which can be used with the utils methode read_bits
*/

VBAT_LO_ALERT_LIMIT                 ::= 0x01
VBAT_HI_ALERT_LIMIT                 ::= 0x02
VIN_LO_ALERT_LIMIT                  ::= 0x03
VIN_HI_ALERT_LIMIT                  ::= 0x04
VOUT_LO_ALERT_LIMIT                 ::= 0x05
VOUT_HI_ALERT_LIMIT                 ::= 0x06
IIN_HI_ALERT_LIMIT                  ::= 0x07
IBAT_LO_ALERT_LIMIT                 ::= 0x08
DIE_TEMP_HI_ALERT_LIMIT             ::= 0x09
BSR_HI_ALERT_LIMIT                  ::= 0x0A
THERMISTOR_VOLTAGE_HI_ALERT_LIMIT   ::= 0x0B
THERMISTOR_VOLTAGE_LO_ALERT_LIMIT   ::= 0x0C
THERMAL_REG_START_TEMP              ::= 0x10
THERMAL_REG_END_TEMP                ::= 0x11
IIN_LIMIT_TARGET                    ::= 0x15
INPUT_UNDERVOLTAGE_SETTING          ::= 0x16
ARM_SHIP_MODE                       ::= 0x19
CHARGE_CURRENT_SETTING              ::= 0x1A
VCHARGE_SETTING                     ::= 0x1B
C_OVER_X_THRESHOLD                  ::= 0x1C
MAX_CV_TIME                         ::= 0x1D
MAX_CHARGE_TIME                     ::= 0x1E
JEITA_T1                            ::= 0x1F
JEITA_T2                            ::= 0x20
JEITA_T3                            ::= 0x21
JEITA_T4                            ::= 0x22
JEITA_T5                            ::= 0x23
JEITA_T6                            ::= 0x24
TCHARGETIMER                        ::= 0x30
TCVTIMER                            ::= 0x31
CHARGER_STATE                       ::= 0x34
CHARGE_STATUS                       ::= 0x35
VBAT                                ::= 0x3A
VIN                                 ::= 0x3B
VOUT                                ::= 0x3C
IBAT                                ::= 0x3D
IIN                                 ::= 0x3E
SYSTEM_STATUS                       ::= 0x39
CHEM_CELLS                          ::= 0x43
CONFIG_BITS                         ::= 0x14
DIE_TEMP                            ::= 0x3F
THERMISTOR_VOLTAGE                  ::= 0x40
BSR                                 ::= 0x41
JEITA_REGION                        ::= 0x42
ICHARGE_DAC                         ::= 0x44
VCHARGE_DAC                         ::= 0x45
IIN_LIMIT_DAC                       ::= 0x46
VBAT_FILT                           ::= 0x47
BSR_CHARGE_CURRENT                  ::= 0x48
INPUT_UNDERVOLTAGE_DAC              ::= 0x4B


class EN_LIMIT_ALERTS_REG:
  static REG_VALUE ::= 0x0D

  static EN_TELEMETRY_VALID_ALERT_BIT        ::= 15
  static EN_BSR_DONE_ALERT_BIT               ::= 14
  static EN_VBAT_LO_ALERT_BIT                ::= 11
  static EN_VBAT_HI_ALERT_BIT                ::= 10
  static EN_VIN_LO_ALERT_BIT                 ::= 9
  static EN_VIN_HI_ALERT_BIT                 ::= 8
  static EN_VOUT_LO_ALERT_BIT                ::= 7
  static EN_VOUT_HI_ALERT_BIT                ::= 6
  static EN_IIN_HI_ALERT_BIT                 ::= 5
  static EN_IBAT_LO_ALERT_BIT                ::= 4
  static EN_DIE_TEMP_HI_ALERT_BIT            ::= 3
  static EN_BSR_HI_ALERT_BIT                 ::= 2
  static EN_THERMISTOR_VOLTAGE_HI_ALERT_BIT  ::= 1
  static EN_THERMISTOR_VOLTAGE_LO_ALERT_BIT  ::= 0

class EN_CHARGER_STATE_ALERTS_REG:
  static REG_VALUE ::= 0x0E

  static EN_BAT_DETECT_FAILED_FAULT_ALERT_BIT  ::= 12
  static EN_BATTERY_DETECTION_ALERT_BIT        ::= 11
  static EN_CHARGER_SUSPENDED_ALERT_BIT        ::= 8
  static EN_PRECHARGE_ALERT_BIT                ::= 7
  static EN_CC_CV_CHARGE_ALERT_BIT             ::= 6
  static EN_NTC_PAUSE_ALERT_BIT                ::= 5
  static EN_TIMER_TERM_ALERT_BIT               ::= 4
  static EN_C_OVER_X_TERM_ALERT_BIT            ::= 3
  static EN_MAX_CHARGE_TIME_ALERT_BIT          ::= 2
  static EN_BAT_MISSING_FAULT_ALERT_BIT        ::= 1
  static EN_BAT_SHORT_FAULT_ALERT_BIT          ::= 0

class EN_CHARGE_STATUS_ALERTS_REG:
  static REG_VALUE ::= 0x0F

  static EN_ILIM_REG_ACTIVE_ALERT_BIT    ::= 5
  static EN_THERMAL_REG_ACTIVE_ALERT_BIT ::= 4
  static EN_VIN_UVCL_ACTIVE_ALERT_BIT    ::= 3
  static EN_IIN_LIMIT_ACTIVE_ALERT_BIT   ::= 2
  static EN_CONSTANT_CURRENT_ALERT_BIT   ::= 1
  static EN_CONSTANT_VOLTAGE_ALERT_BIT   ::= 0

class CONFIG_BITS_REG:
  static REG_VALUE ::= 0x14

  static SUSPEND_CHARGER     ::= 5
  static RUN_BSR             ::= 4
  static TELEMETRY_SPEED     ::= 3
  static FORCE_TELEMETRY_ON  ::= 2
  static MPPT_EN             ::= 1

class CHARGE:
  static VCHARGE_JEITA_6_5_REG    ::= 0x25
  static VCHARGE_JEITA_4_3_2_REG  ::= 0x26
  static ICHARGE_JEITA_6_5_REG    ::= 0x27
  static ICHARGE_JEITA_4_3_2_REG  ::= 0x28

  static JEITA_SIZE        ::= 5
  static JEITA_6_FROM_BIT  ::= 9
  static JEITA_6_TO_BIT    ::= 5

  static JEITA_5_FROM_BIT  ::= 4
  static JEITA_5_TO_BIT    ::= 0

  static JEITA_4_FROM_BIT  ::= 14
  static JEITA_4_TO_BIT    ::= 10

  static JEITA_3_FROM_BIT  ::= 9
  static JEITA_3_TO_BIT    ::= 5

  static JEITA_2_FROM_BIT  ::= 4
  static JEITA_2_TO_BIT    ::= 0

class CHARGER_CONFIG_BITS:
  static REG_VALUE ::= 0x29

  static EN_C_OVER_X_TERM_BIT  ::= 2
  static EN_JEITA_BIT          ::= 0

class LIMIT_ALERTS_REG:
  static REG_VALUE ::= 0x36

class CHEM_CELLS_REG:
  static REG_VALUE ::= 0x43

  static CHEM_FROM_BIT        ::= 11
  static CHEM_TO_BIT          ::= 8

  static CELL_COUNT_FROM_BIT  ::= 3
  static CELL_COUNT_TO_BIT    ::= 0

class TELEMETRY_STATUS_REG:
  static REG_VALUE ::= 0x4A

  static BSR_QUESTIONABLE_BIT ::= 1
  static TELEMETRY_VALID      ::= 0 