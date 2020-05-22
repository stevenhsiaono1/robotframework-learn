
*** Settings ***
Library    Selenium2Library    run_on_failure=Log Source
Variables    vars.py

*** Test Cases ***
Foo
    Create Webdriver    Remote    desired_capabilities=${binary_location}    command_executor=http://localhost:9515
    # Wait Until Page Contains Element    css=.workspace
    # [Teardown]    Close All Browsers



# *** Settings ***
# Library           Selenium2Library
# Library           OperatingSystem
# Variables         vars.py

# *** Variables ***
# # ${Delay}          1s
# ${executor}       http://localhost:9515

# *** Test Cases ***
# Foo
#     # Set Selenium Speed    ${Delay}
#     Create Webdriver    Remote    desired_capabilities=${binary_location}    command_executor=${executor}
#     # Wait Until Page Contains Element    css=.workspace
#     # [Teardown]    Close All Browsers

# *** Keywords ***

# Set Environment Variable
#     webdriver.chrome.driver    ./chromedriver.exe