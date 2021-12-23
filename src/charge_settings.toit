import .register as reg
import .utils

class ChargeSettings:
  jeita_6/int
  jeita_5/int
  jeita_4/int
  jeita_3/int
  jeita_2/int

  constructor jeiter_6_5/int jeiter_4_3_2/int:
    jeita_6 = read_bits jeiter_6_5    reg.CHARGE.JEITA_6_FROM_BIT reg.CHARGE.JEITA_6_TO_BIT 16
    jeita_5 = read_bits jeiter_6_5    reg.CHARGE.JEITA_5_FROM_BIT reg.CHARGE.JEITA_5_TO_BIT 16
    jeita_4 = read_bits jeiter_4_3_2  reg.CHARGE.JEITA_4_FROM_BIT reg.CHARGE.JEITA_4_TO_BIT 16
    jeita_3 = read_bits jeiter_4_3_2  reg.CHARGE.JEITA_3_FROM_BIT reg.CHARGE.JEITA_3_TO_BIT 16
    jeita_2 = read_bits jeiter_4_3_2  reg.CHARGE.JEITA_2_FROM_BIT reg.CHARGE.JEITA_2_TO_BIT 16

  get_jeiter_6_5 -> int:
    return jeita_6 << reg.CHARGE.JEITA_SIZE | jeita_5

  get_jeiter_4_3_2 -> int:
    return jeita_4 << reg.CHARGE.JEITA_SIZE*2 | jeita_3 << reg.CHARGE.JEITA_SIZE | jeita_2
