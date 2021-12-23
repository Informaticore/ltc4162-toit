import charger_config as config
import .testoiteron 

class TestChargerConfig implements TestCase:

  run:
    test_config_defaults
    test_config_jeita
    test_config_en_c_over_x_term
    test_config_getter

  test_config_defaults:
    cfg := config.ChargerConfig 0xff
    assertTrue cfg.en_c_over_x_term
    assertTrue cfg.en_jeita

  test_config_jeita:
    cfg := config.ChargerConfig 0
    assertFalse cfg.en_jeita
    cfg.en_jeita = true
    assertTrue cfg.en_jeita

  test_config_en_c_over_x_term:
    cfg := config.ChargerConfig 0
    assertFalse cfg.en_c_over_x_term
    cfg.en_c_over_x_term = true
    assertTrue cfg.en_c_over_x_term

  test_config_getter:
    cfg := config.ChargerConfig 0
    cfg.en_jeita = true
    cfg.en_c_over_x_term = true
    cfg_value := cfg.get_charger_config
    assertEquals 5 cfg_value

main:
  test := TestChargerConfig
  test.run
  
