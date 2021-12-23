import .utils
import .register as reg

class ChargerConfig:

  en_c_over_x_term/bool := ?
  en_jeita/bool := ?

  constructor charger_config/int:
    en_c_over_x_term = is_bit_set charger_config reg.CHARGER_CONFIG_BITS.EN_C_OVER_X_TERM_BIT
    en_jeita = is_bit_set charger_config reg.CHARGER_CONFIG_BITS.EN_JEITA_BIT

  get_charger_config -> int:
    value := 0
    value = set_bit value reg.CHARGER_CONFIG_BITS.EN_C_OVER_X_TERM_BIT en_c_over_x_term
    value = set_bit value reg.CHARGER_CONFIG_BITS.EN_JEITA_BIT en_jeita
    return value