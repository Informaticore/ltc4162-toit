import .testoiteron
import .test_utils
import .test_system_config
import .test_charger_config

main:
  print "Run all test"
  testcases := [TestUtils, TestChargerConfig, TestSystemConfig]
  testcases.do: | test_case/TestCase |
    test_case.run
      
  print ""
  print "(｡◕‿◕｡) -ALL TESTS OKAY"
