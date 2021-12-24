import .ltc4162
import encoding.json

class Telemetry:
  vbat := ? 
  ibat := ? 
  vin := ? 
  iin := ? 
  vout := ? 
  temp := ? 
  system_status := ? 
  system_status_r := ? 
  charge_status := ? 
  charge_status_r := ? 
  charger_state := ?
  charger_state_r := ? 

  constructor ltc4162/LTC4162:
    vbat = ltc4162.vbat 
    ibat = ltc4162.ibat 
    vin = ltc4162.vin 
    iin = ltc4162.iin 
    vout = ltc4162.vout 
    temp = ltc4162.temp 
    system_status = ltc4162.read_system_status
    system_status_r = system_status.get_status_as_string_list
    charge_status = ltc4162.charge_status 
    charge_status_r = ltc4162.charge_status_readable charge_status
    charger_state = ltc4162.charger_state
    charger_state_r = ltc4162.charger_state_readable charger_state

  json_dump -> ByteArray:
    payload := json.encode {
        "vbat": vbat,
        "ibat": ibat,
        "vin": vin,
        "iin": iin,
        "vout": vout,
        "temp": temp,
        "sys_status_r": system_status_r,
        "charger_state": charger_state,
        "charger_state_r": charger_state_r,
        "charge_status": charge_status,
        "charge_status_r": charge_status_r
    }
    return payload