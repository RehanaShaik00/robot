*** Settings ***
Library  SeleniumLibrary
Resource    ../Keywords/AlarmKeywords.robot

*** Variables ***
${browser}  chrome
${danfossURL}   https://118.185.187.242:6027/#/
${MCXURL}   http://118.185.187.242:6031/Login.html

*** Keywords ***
Set Low temp alarm limit -5.0 deg-SVB5
    LogintoSVB5 and Select device AK-CC550-018x 20  Supervisor  S@danfoss123
    Set Low Temp in SVB5    -5.0

Set Low Temp in SVB5
    [Arguments]     ${tempvalueinsvb5}
    double click element    xpath://td[contains(text(),'-5.0 °C')]
    clear element text  xpath://body/ngb-modal-window[1]/div[1]/div[1]/app-edit-float[1]/div[1]/form[1]/div[2]/input[1]
    input text      xpath://body/ngb-modal-window[1]/div[1]/div[1]/app-edit-float[1]/div[1]/form[1]/div[2]/input[1]     ${tempvalueinsvb5}
    click element   xpath://body/ngb-modal-window[1]/div[1]/div[1]/app-edit-float[1]/div[1]/form[1]/div[3]/button[2]

Set Alarm Delay 0-SVB5
    setting delay in svb5   0

set Thermostart air of AK CC 550 controller to 20.0 deg-MCX A0
    LogintoMCX and select analog output     admin   PASS
    set AK CC 550 controller to value   6000

SVB5 active alarm page should be present with High Temp Alarm
    switch browser  1
    set selenium implicit wait  200seconds
    set selenium speed      1seconds
    click element   xpath://span[contains(text(),'Alarms')]
    click on device name of apeared alarm     AK-CC550-018x 20    --- Low Temp Alarm
    assertion on appered alarm      --- Low Temp Alarm      AK-CC550-018x 20   20      Alarm if error      Normal      1

ack the alarm in SVB5
    click on acknowledge button

alarm should be moved to ack alarm list
    click element   xpath://button[@id='acknowledged']
    sleep   5
    click on device name of apeared alarm     AK-CC550-018x 20    --- Low Temp Alarm
    assertion on appered alarm      --- Low Temp Alarm      AK-CC550-018x 20   20      Alarm if error      Normal      1
    click element   xpath://*[@id="btnclose"]

set Thermostart ait of AK CC 550 controller to 30.0 deg-MCX A0
    switch browser      2
    set AK CC 550 controller to value   9000

the alarm should be cleared from ack alarm page and moves to clear alarm
    switch browser  1
    set selenium implicit wait      200seconds
    set selenium speed      1seconds
    click element   xpath://*[@id="cleared"]
    click on device name of apeared alarm     AK-CC550-018x 20    --- Low Temp Alarm
    assertion on appered alarm      --- Low Temp Alarm      AK-CC550-018x 20   20      Alarm if error      Normal      1
    click element   xpath://*[@id="btnclose"]
    switch browser  2
    set AK CC 550 controller to value   6000
    close all browsers

