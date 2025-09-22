*** Settings ***
Documentation       Mobile test to open Safari and search for Robot Framework.

Library             AppiumLibrary


*** Variables ***
${REMOTE_URL}           http://127.0.0.1:4723
${PLATFORM_NAME}        iOS
${AUTOMATION_NAME}      XCUITest
${DEVICE_NAME}          iPhone 16 Pro
${PLATFORM_VERSION}     18.6
${APP}                  Safari


*** Test Cases ***
First Test Open Safari And Search Robotframework
    [Documentation]    Open Safari and search for robotframework
    Open Safari
    Go To Url    https://robotframework.org
    Sleep    5s


*** Keywords ***
Open Safari
    [Documentation]    Opens Safari on an iOS device using Appium.
    Open Application    ${REMOTE_URL}
    ...    platformName=${PLATFORM_NAME}
    ...    automationName=${AUTOMATION_NAME}
    ...    deviceName=${DEVICE_NAME}
    ...    platformVersion=${PLATFORM_VERSION}
    ...    browserName=${APP}
