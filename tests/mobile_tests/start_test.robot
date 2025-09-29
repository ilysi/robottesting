*** Settings ***
Documentation       Mobile test to open Safari and search for Robot Framework.
Library             AppiumLibrary
Resource            ../../resources/mobile/capabilities.resource


*** Variables ***
${REMOTE_URL}           http://127.0.0.1:4723
${URL_ROBOTFRAMEWORK}   https://robotframework.org


*** Test Cases ***
First Test Open Safari And Search Robotframework
    [Documentation]    Open Safari and search for robotframework
    Open Safari
    Go To Url Of Robotframework
    Sleep    5s


*** Keywords ***
Open Safari
    [Documentation]    Opens Safari on an iOS device using Appium.
    Open Application    ${REMOTE_URL}    alias=safari    &{SAFARI_CAPABILITIES}

Go To Url Of Robotframework
    [Documentation]    Navigates to the specified URL in the mobile browser.
    Go To Url    ${URL_ROBOTFRAMEWORK}
