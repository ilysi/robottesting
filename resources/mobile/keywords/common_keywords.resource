*** Settings ***
Documentation       Common keywords for mobile tests.
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

Go To Url Of Google
    [Documentation]    Navigates to the specified URL in the mobile browser.
    Go To Url    https://www.google.com
    Wait Until Element Is Visible    ${SAFARI_SEARCH_FIELD}    10s

Search For Appium In Safari
    [Documentation]    Searches for "appium" in Safari and clicks the Wikipedia link.
    Click Element    ${SAFARI_SEARCH_FIELD}
    Input Text    ${SAFARI_SEARCH_FIELD}    appium
    ${context}    AppiumLibrary.Get Current Context
    Log To Console    Current context: ${context}
    Scroll Element Into View    ${SAFARI_SEARCH_RESULT}
    Click Element    ${SAFARI_SEARCH_RESULT}

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

Add Reminder Item
    [Documentation]    Adds a new reminder item with the specified text.
    [Arguments]    ${item_text}
    Click Element    accessibility_id=Neue Erinnerung
    Input Text    accessibility_id=Quick Entry Title Field    ${item_text}
    Input Text    accessibility_id=Notes text view    Erinnere dich, sonst vergisst du!
    Click Element    accessibility_id=Details
    Click Element    xpath=//XCUIElementTypeSwitch[@name="Datum"]
    Click Element    accessibility_id=2
    Click Element    xpath=//XCUIElementTypeCell[@name="Priorität"]/XCUIElementTypeOther[1]
    Click Element    accessibility_id=Niedrig
    Click Element    accessibility_id=Hinzufügen

Verify Reminder Item Exists In Planned Items
    [Documentation]    Verifies that a reminder item with the specified text exists.
    [Arguments]    ${item_text}
    Click Element    xpath=//XCUIElementTypeButton[contains(@name, 'Geplant')]
    Page Should Contain Element    xpath=//XCUIElementTypeTextField[@name="Titel" and @value="${item_text}"]
