*** Settings ***
Resource    ../StepDefinitions/LowTempAlarmStepDef.robot

*** Test Cases ***
HighTempAlarmTest
    Given Set Low temp alarm limit -5.0 deg-SVB5
    And Set Alarm Delay 0-SVB5
    When set Thermostart air of AK CC 550 controller to 20.0 deg-MCX A0
    Then SVB5 active alarm page should be present with High Temp Alarm
    When ack the alarm in SVB5
    Then alarm should be moved to ack alarm list
    When set Thermostart ait of AK CC 550 controller to 30.0 deg-MCX A0
    Then the alarm should be cleared from ack alarm page and moves to clear alarm