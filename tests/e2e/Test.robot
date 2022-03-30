*** Settings ***
Library    SeleniumLibrary
Documentation
...    My First Test
...    This test will Verify Google
*** Test Cases ***
Open Google & Verify Google
    Open Browser   <https://www.google.com>   browser=chrome
    ${Get_title}=      Get Title
    Should Be Equal As Strings     ${Get_title}   Google
    Close Browser