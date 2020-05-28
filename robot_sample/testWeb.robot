*** Settings ***
Library           Selenium2Library

*** Test Cases ***
Open Wiki Page
    Open Browser    https://zh.wikipedia.org/wiki/Wiki    chrome

Click Wiki Catagory
    Open Browser    https://zh.wikipedia.org/wiki/Wiki    chrome
    Click Element    //*[@id="n-indexpage"]/a

Search Godzilla
    Open Browser    https://zh.wikipedia.org/wiki/Wiki    chrome
    Input Text    //*[@id="searchInput"]    Gozilla
    Click Element    //*[@id="searchButton"]
    Capture Page Screenshot
