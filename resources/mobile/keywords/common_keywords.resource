*** Settings ***
Documentation       Common keywords for mobile tests.
Library             DateTime
Library             AppiumLibrary
Resource            ../variables/common_elements.resource
Resource            ../variables/common_variables.resource
Resource            ../safari_capabilities.resource
Resource            ../calculator_capabilities.resource
Resource            ../reminder_capabilities.resource


*** Keywords ***
# Safari keywords
Open Safari
    [Documentation]    Opens Safari on an iOS device using Appium.
    Open Application    ${REMOTE_URL}    alias=safari    &{SAFARI_CAPABILITIES}

Go To Url Of Robotframework
    [Documentation]    Navigates to the specified URL in the mobile browser.
    Go To Url    ${URL_ROBOTFRAMEWORK}

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

# Reminder app keywords

Open Reminder App
    [Documentation]    Opens the Reminder app on iOS using Appium.
    Open Application    ${REMOTE_URL}    alias=reminder    &{REMINDER_CAPABILITIES}
    ${context}    Get Current Context
    Log To Console    Current context: ${context}
    # Handle initial pop-ups if they appear
    ${welcome_visible}    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//XCUIElementTypeStaticText[@name="Willkommen bei „Erinnerungen“]    3s
    IF    '${welcome_visible}' == 'True'
        Wait Until Keyword Succeeds    10x    1s    Click Element    xpath=//XCUIElementTypeButton[@name="Fortfahren"]
        Wait Until Keyword Succeeds    10x    1s    Click Element    xpath=//XCUIElementTypeButton[@name="Später"]
    END

Add Reminder Item
    [Documentation]    Adds a new reminder item with the specified text.
    [Arguments]    ${item_text}
    Wait Until Keyword Succeeds    10x    1s    Click Element    xpath=//XCUIElementTypeButton[@name="Neue Erinnerung"]
    ${timestamp}    Get Current Date    result_format=%Y-%m-%d %H:%M:%S
    VAR    ${REMINDER_TEXT}    new ${item_text} ${timestamp}    scope=TEST
    Wait Until Keyword Succeeds    10x    1s    Input Text    xpath=//XCUIElementTypeTextField[@label="Titel"]    ${REMINDER_TEXT}
    Wait Until Keyword Succeeds    10x    1s    Input Text    xpath=//XCUIElementTypeTextField[@label="Notizen"]    Erinnere dich, sonst vergisst du!
    Wait Until Keyword Succeeds    10x    1s    Click Element    xpath=//XCUIElementTypeStaticText[@name="Details"]
    Wait Until Keyword Succeeds    10x    1s    Click Element    xpath=//XCUIElementTypeSwitch[@name="Datum"]
    Wait Until Keyword Succeeds    10x    1s    Click Element    xpath=//XCUIElementTypeStaticText[@name="1"]
    Wait Until Keyword Succeeds    10x    1s    Click Element    xpath=//XCUIElementTypeStaticText[@name="Priorität"]
    Wait Until Keyword Succeeds    10x    1s    Click Element    xpath=//XCUIElementTypeButton[@name="Niedrig"]
    Wait Until Keyword Succeeds    10x    1s    Click Element    xpath=//XCUIElementTypeButton[@name="Hinzufügen"]

Verify Reminder Item Exists In Planned Items
    [Documentation]    Verifies that a reminder item with the specified text exists.
    Wait Until Keyword Succeeds    10x    1s    Click Element    xpath=//XCUIElementTypeButton[contains(@name, 'Geplant')]
    Page Should Contain Element    xpath=//XCUIElementTypeTextField[@name="Titel" and @value="${REMINDER_TEXT}"]

Close App
    [Documentation]    Closes the currently opened mobile application.
    Close Application