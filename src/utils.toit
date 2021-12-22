
is_bit_set value/int bit_num/int:
  is_set/bool := ((value >> bit_num) & 0x01 == 1)
  return is_set

enable_bit value/int bit_num/int:
  return value |= 0x01 << bit_num

disable_bit value/int bit_num/int:
  return value &= ~(0x01 << bit_num)