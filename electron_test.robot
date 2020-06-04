*** Settings ***
Test Setup        Create Webdriver    Remote    desired_capabilities=${binary_location}    command_executor=http://127.0.0.1:9515    # Test Setup    Open Browser    None    Chrome    options=binary_location=r"C:\\Users\\user\\Desktop\\imooc_learn\\electron-simple-player\\build\\win-unpacked\\electron-simple-player.exe"
Test Teardown     Close Browser
Library           Selenium2Library    run_on_failure=Log Source
Library           FileControl.py
# Library           FileControl.FileControl
Variables         ./vars.py

*** Variables ***
${IMAGE}    C:\\Users\\1700485\\Desktop\\git_project\\electron-simple-player\\resources\\images\\平視馬特洪峰，是我一直以來的願望.jpg
${AUDIO}    C:\\Users\\1700485\\Desktop\\git_project\\electron-simple-player\\resources\\audio\\Wincent Weiss - Kein Lied (Live in der Barclaycard Arena, Hamburg, 2019).mp3
${VIDEO}    C:\\Users\\1700485\\Desktop\\git_project\\electron-simple-player\\resources\\video\\孫盛希 Shi Shi【Someday or One Day】電視劇「想見你」片頭曲 Official Music Video.mp4
${DELAY}    10
${RETRY_CNT}    20 sec
${RETRY_INTERVAL}    5 sec
${PLAY_SEC}    10
${PAUSE_SEC}    3

*** Test Cases ***
Show Main Page
    Check Logo Shows

Check Logo Redirection
    Check Logo Shows
    Click Logo Shoud Direct To Official Website
   
Show Add Media Window
    Click Add Media Btn
    Default Add Window Should Contain "Select Media to List"
    Click Confirm And Add Btn
    Check Logo Shows
    
Clear And Add Image To Play
    Clear All Media
    Click Add Media Btn
    Check Add List Empty
    Select ${IMAGE} To Add List
    Check Add List Not Empty
    Click Confirm And Add Btn
    Check Main List Not Empty
    Check Media Shows With id:play-images
    
Clear And Add Audio To Play
    Clear All Media
    Click Add Media Btn
    Check Add List Empty
    Select ${AUDIO} To Add List
    Check Add List Not Empty
    Click Confirm And Add Btn
    Check Main List Not Empty
    Check Media Shows With id:current-seeker

Clear And Add Video To Play
    Clear All Media
    Click Add Media Btn
    Check Add List Empty
    Select ${VIDEO} To Add List
    Check Add List Not Empty
    Click Confirm And Add Btn
    Check Main List Not Empty
    Check Media Shows With id:play-video

# BAD Sample
Check No Media Then Add Multiple Media to Play
    Clear All Media
    Click Add Media Btn
    Check Add List Empty
    Select ${IMAGE} To Add List
    Check Add List Not Empty
    Click Confirm And Add Btn
    Check Main List Not Empty
    Click Add Media Btn
    Check Add List Empty
    Select ${AUDIO} To Add List
    Check Add List Not Empty
    Click Confirm And Add Btn
    Check Main List Not Empty
    Click Add Media Btn
    Check Add List Empty
    Select ${VIDEO} To Add List
    Check Add List Not Empty
    Click Confirm And Add Btn
    Check Main List Not Empty
    Wait And Click    //*[@id="tracksList"]/ul/li[1]/div/i[1]
    Sleep  5s
    ${count} =    Get Element Count    class:fa-pause
    Should Be True    ${count} == 1
    Wait And Click    //*[@id="tracksList"]/ul/li[2]/div/i[1]
    Sleep  10s
    ${count} =    Get Element Count    class:fa-pause
    Should Be True    ${count} == 1
    Wait And Click    //*[@id="tracksList"]/ul/li[3]/div/i[1]
    Sleep  10s
    ${count} =    Get Element Count    class:fa-pause
    Should Be True    ${count} == 1

*** Keywords ***
Wait And Click
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    20
    Click Element    ${locator}

Check Logo Shows
    Wait Until Page Contains Element    //*[@id="nzxt-page"]/img    ${DELAY}

Click Logo Shoud Direct To Official Website
    Click Element    //*[@id="nzxt-page"]/img
    Wait Until Page Contains    為電腦玩家與組裝者打造的機殼、散熱器材與配件。    ${DELAY}

Click Add Media Btn
    Wait And Click    id:add-media-btn
    Select Window    NEW

Default Add Window Should Contain "${NO_MEDIA_TEXT}"
    Wait Until Page Contains    ${NO_MEDIA_TEXT}    ${DELAY}

Click Confirm And Add Btn
    Wait And Click    id:add-media
    Select Window    MAIN

Clear All Media
    Wait And Click    id:delete-all-btn
    Wait Until Page Contains    No Media on List!    ${DELAY}

Check Add List Empty
    Wait Until Element Is Not Visible    //*[@id="musicList"]/ul/li    ${DELAY}

Check Add List Not Empty
    Wait Until Element Is Visible    //*[@id="musicList"]/ul/li    ${DELAY}

Select ${MEDIA} To Add List
    Wait And Click    id:select-media
    Wait Until Keyword Succeeds    ${RETRY_CNT}    ${RETRY_INTERVAL}    Set File Path    ${MEDIA}

Set File Path
    [Arguments]    ${MEDIA}
    ${result}    set_file    ${MEDIA}
    Should Be True    ${result} == True

Check Main List Not Empty
    Wait Until Page Does Not Contain    No Media on List!    ${DELAY}

Check Media Shows With ${locator}
    sleep    ${PAUSE_SEC}
    Wait And Click    class:fa-play
    Wait Until Element Is Visible    ${locator}    ${DELAY}
    sleep    ${PLAY_SEC}
    Wait And Click    class:fa-pause
    Wait Until Element Is Not Visible    ${locator}    ${DELAY}
    sleep    ${PAUSE_SEC}