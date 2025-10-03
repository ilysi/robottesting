*** Settings ***
Documentation       Common keywords for mobile tests.
Library             DateTime
Library             AppiumLibrary
Resource            ../variables/common_variables.resource
Resource            ../calculator_capabilities.resource


*** Keywords ***
# Calculator app keywords

Open Calculator App
    [Documentation]    Opens the Calculator app on iOS using Appium.
    Open Application    ${REMOTE_URL}    alias=calculator    &{CALCULATOR_CAPABILITIES}

Tap Calculator Button
    [Documentation]    Taps a button in the Calculator app by accessibility ID.
    [Arguments]    ${button_text}
    Click Element    accessibility_id=${button_text}

Get Calculator Result
    [Documentation]    Retrieves the result display text.
    ${result}    Get Text    accessibility_id=Result
    RETURN    ${result}
