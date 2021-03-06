*** Settings ***
Documentation     A test suite with a single test for valid login.
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          ./resources/homeview.robot

*** Test Cases ***
Valid Login
    Open Browser To Login Page
    Generate random email
    Input Username    bryan
    Input Password    123456
    Submit Credentials
    Welcome Page Should Be Open
    Decode QR
    Check Iframe
    Click On Link
    Search On Wikipedia
    [Teardown]    Close Browser