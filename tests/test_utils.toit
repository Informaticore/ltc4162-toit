import utils
import .testoiteron

main:
  test_utils_enable_bit
  test_utils_disable_bit
  test_utils_disable_bit_high
  test_utils_is_bit_set
  test_utils_is_bit_not_set

test_utils_enable_bit:
  value/int := 0b0000_0010
  new_value/int := utils.enable_bit value 0
  assertEquals 3 new_value

test_utils_disable_bit:
  value/int := 0b0000_0011 
  new_value/int := utils.disable_bit value 1
  assertEquals 1 new_value

test_utils_disable_bit_high:
  value/int := 0b1111_1111
  new_value/int := utils.disable_bit value 7
  assertEquals 127 new_value

test_utils_is_bit_set:
  value/int := 0b0001_1000
  is_bit_set := utils.is_bit_set value 4
  assertEquals true is_bit_set

test_utils_is_bit_not_set:
  value/int := 0b0001_0000
  is_bit_set := utils.is_bit_set value 3
  assertEquals false is_bit_set
  is_bit_set = utils.is_bit_set value 5
  assertEquals false is_bit_set