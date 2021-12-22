
/**
    Returns true if the given &bit_num of value is set, false otherwise
*/
is_bit_set value/int bit_num/int:
  is_set/bool := ((value >> bit_num) & 0x01 == 1)
  return is_set

/**
    Enables the given &bit_num of value
    Returns the new resulting value of this operation
*/
enable_bit value/int bit_num/int:
  return value |= 0x01 << bit_num

/**
    Disables the given &bit_num of value
    Returns the new resulting value of this operation
*/
disable_bit value/int bit_num/int:
  return value &= ~(0x01 << bit_num)