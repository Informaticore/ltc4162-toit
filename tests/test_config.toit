import config
import .testoiteron 

main:
  test_config_defaults
  test_config_force_telemetry_on
  test_config_mppt_on
  test_config_suspend_charger
  test_config_telemetry_speed

test_config_defaults:
  c := config.Config 0
  assertFalse c.is_force_telemetry_on_enabled
  assertFalse c.is_mppt_on_enabled
  assertFalse c.is_run_bsr_enabled
  assertFalse c.is_suspend_charger_enabled
  assertFalse c.is_telemetry_speed_enabled

test_config_force_telemetry_on:
  cfg := config.Config 0
  assertFalse cfg.is_force_telemetry_on_enabled
  cfg.enable_force_telemetry_on true
  assertTrue cfg.is_force_telemetry_on_enabled
  cfg.enable_force_telemetry_on false
  assertFalse cfg.is_force_telemetry_on_enabled

test_config_mppt_on:
  cfg := config.Config 0
  assertFalse cfg.is_mppt_on_enabled
  cfg.enable_mppt_on true
  assertTrue cfg.is_mppt_on_enabled
  cfg.enable_mppt_on false
  assertFalse cfg.is_mppt_on_enabled

test_config_run_bsr:
  cfg := config.Config 0
  assertFalse cfg.is_run_bsr_enabled
  cfg.enable_run_bsr true
  assertTrue cfg.is_run_bsr_enabled
  cfg.enable_run_bsr false
  assertFalse cfg.is_run_bsr_enabled

test_config_suspend_charger:
  cfg := config.Config 0
  assertFalse cfg.is_suspend_charger_enabled
  cfg.enable_suspend_charger true
  assertTrue cfg.is_suspend_charger_enabled
  cfg.enable_suspend_charger false
  assertFalse cfg.is_suspend_charger_enabled

test_config_telemetry_speed:
  cfg := config.Config 0
  assertFalse cfg.is_telemetry_speed_enabled
  cfg.enable_telemetry_speed true
  assertTrue cfg.is_telemetry_speed_enabled
  cfg.enable_telemetry_speed false
  assertFalse cfg.is_telemetry_speed_enabled
