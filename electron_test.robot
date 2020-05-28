*** Settings ***
Test Setup        Create Webdriver    Remote    desired_capabilities=${binary_location}    command_executor=http://127.0.0.1:9515    # Test Setup    Open Browser    None    Chrome    options=binary_location=r"C:\\Users\\user\\Desktop\\imooc_learn\\electron-simple-player\\build\\win-unpacked\\electron-simple-player.exe"
Test Teardown     Close Browser
Library           Selenium2Library    run_on_failure=Log Source
Variables         ./vars.py
Library           FileControl.py

*** Test Cases ***

Main Page
   # ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
   # ${options.binary_location} =    set variable    C:\\Users\\user\\Desktop\\imooc_learn\\electron-simple-player\\build\\win-unpacked\\electron-simple-player.exe
   # Create Webdriver    Chrome    options=${options}
   Wait Until Page Contains Element    //*[@id="nzxt-page"]/img    20

Logo Redirection
   # Use Keywords
   Wait And Click    //*[@id="nzxt-page"]/img
   Wait Until Page Contains    為電腦玩家與組裝者打造的機殼、散熱器材與配件。    20

Show Add Media Window
   Wait And Click    id:add-music-btn
   Select Window    NEW
   Wait Until Page Contains    Select Media to List    10
   Wait And Click    id:add-music
   Select Window    MAIN
   Wait Until Element Is Visible    id:nzxt-page    10
    
    
Check No Media Then Add Media
    Wait And Click    id:delete-all-btn
    Wait Until Page Contains    No Media on List!    10
    Wait And Click    id:add-music-btn
    Select Window    NEW
    Wait And Click    id:select-music
    Sleep  5s
    # call customized lib of autoit to select file
    ${result}=    set_file
    Sleep  5s
    Wait And Click    id:add-music
    Sleep  3s

*** Keywords ***
Wait And Click
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    20
    Click Element    ${locator}
