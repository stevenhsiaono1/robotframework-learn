
*** Settings ***
Library    Selenium2Library    run_on_failure=Log Source
Variables    ./vars.py
# Test Setup      Open Browser    None    Chrome    options=binary_location=r"C:\\Users\\user\\Desktop\\imooc_learn\\electron-simple-player\\build\\win-unpacked\\electron-simple-player.exe"
Test Setup    Create Webdriver    Remote    desired_capabilities=${binary_location}    command_executor=http://127.0.0.1:9515

*** Test Cases ***
Test Connection
    # ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    # ${options.binary_location} =    set variable    C:\\Users\\user\\Desktop\\imooc_learn\\electron-simple-player\\build\\win-unpacked\\electron-simple-player.exe
    # Create Webdriver    Chrome    options=${options}
    Wait Until Page Contains Element    //*[@id="nzxt-page"]/img    20
    [Teardown]    Close Browser
    


