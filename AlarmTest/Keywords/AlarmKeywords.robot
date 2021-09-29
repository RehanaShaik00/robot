*** Settings ***
Library  SeleniumLibrary
Library     OperatingSystem

*** Variables ***
${TEMPDIR}      C:/Users/61449/AppData/Local/Temp
#${CURDIR}       C:/Users/61449/PycharmProjects/DanfossAutomation
${CUR}       DanfossAutomation


*** Keywords ***
webdriver
    Set Environment Variable    CLASSPATH   ${CURDIR}${/}chromedriver.exe
    Create Webdriver    Chrome    executable_path=chromedriver.exe
LogintoSVB5 and Select device AK-CC550-018x 20
    [Arguments]     ${SVB5username}      ${SVB5password}
    webdriver
    go to       ${danfossURL}
    #open browser    ${danfossURL}   ${browser}
    maximize browser window
    set selenium implicit wait      50seconds
    set selenium speed      1seconds
    click element   xpath://*[@id="details-button"]
    click link  xpath://*[@id="proceed-link"]
    input text  xpath://*[@id="user"]   ${SVB5username}
    input text  xpath://*[@id="pwd"]    ${SVB5password}
    click element   xpath://*[@id="signup-form"]/form/input
    click element   xpath://span[contains(text(),'File')]
    click element   xpath://span[contains(text(),'Preferences')]
    unselect checkbox    xpath://app-header/div[@id='Preferences']/div[1]/div[1]/div[2]/div[5]/div[1]/input[1]
    click element   xpath://app-header/div[@id='Preferences']/div[1]/div[1]/div[1]/button[1]/span[1]
    scroll element into view    xpath://*[@id="app-main"]/div/app-dashboard/section/div/app-device[1]/div/div/div/ngx-datatable/div/datatable-body/datatable-selection/datatable-scroller/datatable-row-wrapper[24]/datatable-body-row/div[2]/datatable-body-cell[2]
    click element   xpath://*[@id="app-main"]/div/app-dashboard/section/div/app-device[1]/div/div/div/ngx-datatable/div/datatable-body/datatable-selection/datatable-scroller/datatable-row-wrapper[24]/datatable-body-row/div[2]/datatable-body-cell[2]

setting delay in svb5
    [Arguments]     ${delayvalueinsvb5}
    double click element    xpath://td[contains(text(),'0 min')]
    clear element text  xpath://*[@id="idEditInt"]/form/div[2]/input
    input text      xpath://*[@id="idEditInt"]/form/div[2]/input       ${delayvalueinsvb5}
    click element   xpath://*[@id="idEditInt"]/form/div[3]/button[2]

LogintoMCX and select analog output
    [Arguments]     ${MCXusername}      ${MCXpassword}
    webdriver
    go to       ${MCXURL}
    #open browser     ${MCXURL}     ${browser}
    maximize browser window
    set selenium implicit wait      200seconds
    set selenium speed      1seconds
    input text  xpath://*[@id="usernameDisplay"]    ${MCXusername}
    input text  xpath://input[@id='password']       ${MCXpassword}
    click element   xpath://*[@id="button_login"]
    click element   xpath://td[contains(text(),'N.A.')]
    click element   xpath://a[contains(text(),'Details')]
    click element   xpath://*[@id="supervisor_table"]/tbody/tr[157]/td[1]/img[1]
    click element   xpath://*[@id="supervisor_table"]/tbody/tr[158]/td[1]/img[2]

set AK CC 550 controller to value
    [Arguments]     ${controllervalue}
    click element   xpath://*[@id="Params_ID164"]/td[4]
    clear element text  xpath://*[@id="popup_dialog_input_new_value"]
    input text      xpath://*[@id="popup_dialog_input_new_value"]       ${controllervalue}
    click element   xpath://*[@id="popup_dialog"]/center/table/tbody/tr[4]/th
    click element   xpath://*[@id="button_save"]/span
    sleep   5

click on device name of apeared alarm
    [Arguments]     ${devicename}      ${alarmtype}
    wait until element contains     xpath://*[@id="app-main"]/div/app-alarms/section/div/div/div/div/div[2]/datatable/ngx-datatable/div/datatable-body/datatable-selection/datatable-scroller/datatable-row-wrapper/datatable-body-row/div[2]/datatable-body-cell[2]    ${devicename}    timeout=200s
    wait until element contains     xpath://*[@id="app-main"]/div/app-alarms/section/div/div/div/div/div[2]/datatable/ngx-datatable/div/datatable-body/datatable-selection/datatable-scroller/datatable-row-wrapper/datatable-body-row/div[2]/datatable-body-cell[4]    ${alarmtype}    timeout=200s
    click element       xpath://*[@id="app-main"]/div/app-alarms/section/div/div/div/div/div[2]/datatable/ngx-datatable/div/datatable-body/datatable-selection/datatable-scroller/datatable-row-wrapper/datatable-body-row/div[2]/datatable-body-cell[2]
    sleep   5

assertion on appered alarm
    [Arguments]     ${alarmtype}    ${devicename}       ${address}      ${setting}      ${level}    ${action}
    element should contain  xpath://*[@id="lbldescriptionval"]      ${alarmtype}
    element should contain  xpath://*[@id="lblpointval"]        ${devicename}
    element should contain  xpath://*[@id="lbladdressval"]      ${address}
    element should contain  xpath://*[@id="lblsettingval"]      ${setting}
    element should contain  xpath:/html/body/ngb-modal-window/div/div/app-alarmdetailmodal/div[2]/form/div[9]/div       ${level}
    element should contain  xpath:/html/body/ngb-modal-window/div/div/app-alarmdetailmodal/div[2]/form/div[10]/div      ${action}

click on acknowledge button
    click element   xpath://*[@id="btnACK"]
