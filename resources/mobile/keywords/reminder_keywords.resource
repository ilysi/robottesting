*** Settings ***
Documentation       Common keywords for mobile tests.

Library             ScreenCapLibrary
Library             DateTime
Library             AppiumLibrary
Resource            ../variables/common_variables.resource
Resource            ../reminder_capabilities.resource
Resource            ../keywords/common_keywords.resource


*** Keywords ***
Open Reminder App And Handle Popups
    [Documentation]    Opens the Reminder app and handles any initial pop-ups if they appear.
    Open Reminder App
    Start Video Recording
    Handle Initial Pop-Ups If They Appear

Open Reminder App
    [Documentation]    Opens the Reminder app on iOS using Appium.
    Open Application    ${REMOTE_URL}    alias=reminder    &{REMINDER_CAPABILITIES}

Handle Initial Pop-Ups If They Appear
    [Documentation]    Handles system alerts and in-app onboarding pop-ups in Reminders app.
    # Handle Reminders welcome screen (German localization)
    ${welcome_visible}    Run Keyword And Return Status
    ...    Wait Until Element Is Visible
    ...    xpath=//XCUIElementTypeStaticText[@name="Willkommen bei „Erinnerungen“"]    10s
    IF    ${welcome_visible}
        Log To Console    Welcome screen detected, handling it.
        Run Keyword And Ignore Error    Click Element    xpath=//XCUIElementTypeButton[@name="Fortfahren"]
        ${sync_visible}    Run Keyword And Return Status
        ...    Wait Until Element Is Visible
        ...    xpath=//XCUIElementTypeButton[@name="Später"]    10s
        IF    ${sync_visible}
            Run Keyword And Ignore Error    Click Element    xpath=//XCUIElementTypeButton[@name="Später"]
        END
        ${got_it_visible}    Run Keyword And Return Status
        ...    Wait Until Element Is Visible
        ...    xpath=//XCUIElementTypeButton[@name="Listen"]    10s
        IF    ${got_it_visible}
            Log To Console    Inside "Listen" view, but test should start from main view of the app.
            Run Keyword And Ignore Error    Click Element    xpath=//XCUIElementTypeButton[@name="Listen"]
        END
    END

Close App After Test Execution
    [Documentation]    Closes the currently opened mobile application.
    # Close Application
    Close Application
    Stop Video Recording

Add Reminder Item
    [Documentation]    Adds a new reminder item with the specified text.
    [Arguments]    ${item_text}
    Start New Reminder    ${item_text}
    Fill Reminder Details
    Set Reminder Date
    Set Reminder Priority
    Save Reminder

Start New Reminder
    [Documentation]    Starts the process of adding a new reminder item.
    [Arguments]    ${item_text}
    Click On Visible Element    xpath=//XCUIElementTypeButton[@name="Neue Erinnerung"]
    ${timestamp}    Get Current Date    result_format=%Y-%m-%d %H:%M:%S
    VAR    ${REMINDER_TEXT}    new ${item_text} ${timestamp}    scope=TEST

Fill Reminder Details
    [Documentation]    Fills in the details for the new reminder item.
    Input Text If Visible    xpath=//XCUIElementTypeTextField[@label="Titel"]    ${REMINDER_TEXT}
    Input Text If Visible    xpath=//XCUIElementTypeTextField[@label="Notizen"]    Erinnere dich, sonst vergisst du!
    Click On Visible Element    xpath=//XCUIElementTypeStaticText[@name="Details"]
    # alternative xpath=//XCUIElementTypeButton[@name="Details bearbeiten"] wennn aus Erinnerungen liste gestartet

Set Reminder Date
    [Documentation]    Sets the date for the new reminder item to today.
    Click On Visible Element    xpath=//XCUIElementTypeSwitch[@name="Datum"]
    # TODO: handle initial popup if it appears
    ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//XCUIElementTypeStaticText[@name="Nie eine Erinnerung verpassen"]    3s
    IF    ${status}
        Log To Console    Initial popup detected, handling it.
        Click On Visible Element    xpath=//XCUIElementTypeButton[@name="Fortfahren"]
        Sleep    4s    Wait untill OS Alert is loaded
        Click Alert Button    Erlauben
    END
    ${current_date}    Get Current Date    increment=1day    result_format=%d
    ${day}    Convert To Integer    ${current_date}
    Log To Console    -------------------------------
    Log To Console    Day: ${day}
    Log To Console    -------------------------------
    Click On Visible Element    xpath=//XCUIElementTypeStaticText[@name="${day}"]

Set Reminder Priority
    [Documentation]    Sets the priority for the new reminder item to low.
    Click On Visible Element    xpath=//XCUIElementTypeStaticText[@name="Priorität"]
    Click On Visible Element    xpath=//XCUIElementTypeButton[@name="Mittel"]

Save Reminder
    [Documentation]    Saves the new reminder item.
    Click On Visible Element    xpath=//XCUIElementTypeButton[@name="Hinzufügen"]

Verify Reminder Item Exists In Planned Items
    [Documentation]    Verifies that a reminder item with the specified text exists.
    Click On Visible Element    xpath=//XCUIElementTypeButton[contains(@name, 'Geplant')]
    Page Should Contain Element    xpath=//XCUIElementTypeTextField[@name="Titel" and @value="${REMINDER_TEXT}"]
