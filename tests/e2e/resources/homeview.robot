*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported SeleniumLibrary.
Library           SeleniumLibrary

*** Variables ***
${SERVER}         localhost:8080
${BROWSER}        Firefox
${DELAY}          0
${username}       bryan
${password}       123456
${LOGIN URL}      http://${SERVER}/

*** Keywords ***
Open Browser To Login Page
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}
    Login Page Should Be Open

Login Page Should Be Open
    Title Should Be    vue-robot-selenium

Go To Login Page
    Go To    ${LOGIN URL}
    Login Page Should Be Open

Input Username
    [Arguments]    ${username}
    Input Text    username    ${username}

Input Password
    [Arguments]    ${password}
    Input Text    password    ${password}

Submit Credentials
    Click Button    login

Welcome Page Should Be Open
    ${text}=   Get Text    id:title
    Should Contain Any    ${text}   Welcome

Click On Link
    Click Element       //*[@data-qa="wiki-link"]
    ${text}=   Get Text     //*[@class="central-textlogo-wrapper"]
    Should Contain Any    ${text}   Wikipedia

Search On Wikipedia
    Input Text  //*[@id="searchInput"]   Selenium
    Click Element       class:pure-button
    Title Should Be    Selenium - Wikipedia 
    ${text}=   Get Text     //*[@id="firstHeading"]
    Should Contain Any   ${text}   Selenium

Check Iframe
    Select Frame        //iframe[@id='iframe']
    Current Frame Should Contain        MY BLOG
    Unselect Frame

Decode QR
    ${test}=  execute javascript    ${CURDIR}/../modules/qr.js
    Should Be Equal As Strings  ${test}  1
    sleep  5s