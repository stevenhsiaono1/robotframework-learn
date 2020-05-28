*** Settings ***
Library           Selenium2Library

*** Test Cases ***
Open Google
    test open browser and goto Google

print_helloworld
    log    helloworld

*** Keywords ***
test open browser and goto Google
    Open Browser    http://google.com    chrome
