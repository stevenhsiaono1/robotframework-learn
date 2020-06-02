*** Settings ***
Test Setup        Create Webdriver    Remote    desired_capabilities=${binary_location}    command_executor=http://127.0.0.1:9515    # Test Setup    Open Browser    None    Chrome    options=binary_location=r"C:\\Users\\user\\Desktop\\imooc_learn\\electron-simple-player\\build\\win-unpacked\\electron-simple-player.exe"
Test Teardown     Close Browser
Library           Selenium2Library    run_on_failure=Log Source
Variables         ./vars.py
Library           FileControl.py

*** Variables ***
${IMAGE_PATH}    C:\\Users\\1700485\\Desktop\\git_project\\electron-simple-player\\resources\\images\\平視馬特洪峰，是我一直以來的願望.jpg
${AUDIO_PATH}    C:\\Users\\1700485\\Desktop\\git_project\\electron-simple-player\\resources\\audio\\Wincent Weiss - Kein Lied (Live in der Barclaycard Arena, Hamburg, 2019).mp3
${VIDEO_PATH}    C:\\Users\\1700485\\Desktop\\git_project\\electron-simple-player\\resources\\video\\孫盛希 Shi Shi【Someday or One Day】電視劇「想見你」片頭曲 Official Music Video.mp4

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
   Wait And Click    id:add-media-btn
   Select Window    NEW
   Wait Until Page Contains    Select Media to List    10
   Wait And Click    id:add-media
   Select Window    MAIN
   Wait Until Element Is Visible    id:nzxt-page    10
    
Check No Media Then Add Image To Play
    Check No Media Then Add Media To Play    ${IMAGE_PATH}    id:play-images

Check No Media Then Add Audio To Play
    Check No Media Then Add Media To Play    ${AUDIO_PATH}    id:current-seeker

Check No Media Then Add Video To Play
    Check No Media Then Add Media To Play    ${VIDEO_PATH}    id:play-video

*** Keywords ***
Wait And Click
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    20
    Click Element    ${locator}

Clear Then Add Media
    [Arguments]    ${FILE_PATH}
    Sleep  3s
    Wait And Click    id:delete-all-btn
    Wait Until Page Contains    No Media on List!    10
    Wait And Click    id:add-media-btn
    Select Window    NEW
    Wait And Click    id:select-media
    Sleep  5s
    # call customized lib of autoit
    ${result}    set_file    ${FILE_PATH}
    Sleep  5s
    Wait And Click    id:add-media
    Sleep  5s

Check No Media Then Add Media To Play
    [Arguments]    ${FILE_PATH}    ${locator}
    Clear Then Add Media    ${FILE_PATH}
    Select Window    MAIN
    Wait And Click    class:fa-play
    Sleep  10s
    Wait Until Element Is Visible    ${locator}    5s
    Wait And Click    class:fa-pause
    Wait Until Element Is Not Visible    ${locator}    5s
    Sleep  3s
    Delete All Cookies