*** Settings ***
Documentation       Common keywords for mobile tests.
Library             DateTime
Library             AppiumLibrary
Resource            ../variables/mobile_safari_elements.resource
Resource            ../variables/common_variables.resource
Resource            ../safari_capabilities.resource


*** Keywords ***
# Safari keywords
Open Safari
    [Documentation]    Opens Safari on an iOS device using Appium.
    Open Application    ${REMOTE_URL}    alias=safari    &{SAFARI_CAPABILITIES}

Go To Url Of Robotframework
    [Documentation]    Navigates to the specified URL in the mobile browser.
    Go To Url    ${URL_ROBOTFRAMEWORK}
