*** Settings ***
Documentation       Common keywords for mobile tests.

Library             DateTime
Library             ScreenCapLibrary
Library             AppiumLibrary
Resource            ../variables/common_variables.resource
Resource            ../reminder_capabilities.resource
Resource            ../keywords/common_keywords.resource
Resource            ../variables/reminders_elements.resource


*** Keywords ***
Open Reminder App And Handle Popups
    [Documentation]    Opens the Reminder app and handles any initial pop-ups if they appear.
    Open Reminder App
    Handle Initial Pop-Ups If They Appear

Open Reminder App
    [Documentation]    Opens the Reminder app on iOS using Appium.
    Log To Console    Opens the Reminder app
    Open Application    ${REMOTE_URL}    alias=reminder    &{REMINDER_CAPABILITIES}

Handle Initial Pop-Ups If They Appear
    [Documentation]    Handles system alerts and in-app onboarding pop-ups in Reminders app.
    # Handle Reminders welcome screen (German localization)
    ${welcome_visible}    Run Keyword And Return Status
    ...    Wait Until Element Is Visible
    ...    ${REMINDER_WELCOME_SCREEN}    10s
    IF    ${welcome_visible}
        Log To Console    Welcome screen detected, handling it.
        Run Keyword And Ignore Error    Click Element    ${REMINDER_WELCOME_FORTFAHREN_BUTTON}
        ${sync_visible}    Run Keyword And Return Status
        ...    Wait Until Element Is Visible
        ...    ${REMINDER_SYNC_SPATER_BUTTON}    10s
        IF    ${sync_visible}
            Log To Console    Sync visible, clicking "Später" button.
            Run Keyword And Ignore Error    Click Element    ${REMINDER_SYNC_SPATER_BUTTON}
        END
        ${got_it_visible}    Run Keyword And Return Status
        ...    Wait Until Element Is Visible
        ...    ${LISTE_ERINNERUNGEN}    10s
        IF    ${got_it_visible}
            Log To Console    Inside "Listen" view, go back to main view of reminder app.
            Run Keyword And Ignore Error    Click Element    ${LISTE_ERINNERUNGEN}
        END
    END
   

Close App After Test Execution
    [Documentation]    Closes the currently opened mobile application.
    Log To Console    Closes the currently opened mobile application.
    # Close Application
    Close Application

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
    Log To Console    Starts the process of adding a new reminder item.
    Click On Visible Element    ${REMINDER_NEUE_ERINNERUNG_BUTTON}
    ${timestamp}    Get Current Date    result_format=%Y-%m-%d %H:%M:%S
    VAR    ${REMINDER_TEXT}    new ${item_text} ${timestamp}    scope=TEST

Fill Reminder Details
    [Documentation]    Fills in the details for the new reminder item.
    Log To Console    Fills in the details for the new reminder item.
    Input Text If Visible    ${REMINDER_TITLE_INPUT}    ${REMINDER_TEXT}
    Input Text If Visible    ${REMINDER_NOTES_INPUT}    Erinnere dich, sonst vergisst du!
    Click Element            ${REMINDER_EDIT_DETAILS_BUTTON}

Set Reminder Date
    [Documentation]    Sets the date for the new reminder item to tomorrow.
    Log To Console    Sets the date for the new reminder item to tomorrow.
    Click On Visible Element    ${REMINDER_DATE_SWITCH}
    # TODO: handle initial popup if it appears
    ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${REMINDER_DO_NOT_MISS_POPUP}    3s
    IF    ${status}
        Log To Console    Initial popup detected, handling it.
        Click On Visible Element    ${REMINDER_CONTINUE_BUTTON}
        Sleep    4s    Wait untill OS Alert is loaded
        Click Alert Button    Erlauben
    END
    ${current_date}    Get Current Date    increment=1day    result_format=%d
    ${day}    Convert To Integer    ${current_date}
    Log To Console    -------------------------------
    Log To Console    Day: ${day}
    Log To Console    -------------------------------
    Click On Day Picker    ${day}

Set Reminder Priority
    [Documentation]    Sets the priority for the new reminder item to medium.
    Log To Console    Sets the priority for the new reminder item to medium.
    Click Element    ${REMINDER_PRIORITY_LABEL}
    Click Element    ${REMINDER_PRIORITY_MEDIUM_BUTTON}

Save Reminder
    [Documentation]    Saves the new reminder item.
    Log To Console    Saves the new reminder item.
    Click Element    ${REMINDER_SAVE_BUTTON}

Click On Day Picker
    [Documentation]    Clicks on the day picker with the specified day value.
    [Arguments]    ${day}
    Log To Console    Clicks on the day picker with the specified day value.
    Click On Visible Element    xpath=//XCUIElementTypeStaticText[@name="${day}"]

Verify Reminder Item Exists In Planned Items
    [Documentation]    Verifies that a reminder item with the specified text exists.
    Log To Console    Verifies that a reminder item with the specified text exists.
    ${screen_view}    Run Keyword And Return Status
    ...    Wait Until Element Is Visible
    ...    ${SCREEN_ERINNERUNGEN}    5s
    IF    ${screen_view}
        Log To Console    Still in Erinnerungen view, navigating back to main view.
        Click Element    ${LISTEN_BACK_BUTTON}
    END
    Click On Visible Element    ${REMINDER_PLANNED_BUTTON}
    Verify Reminder Title Exists    ${REMINDER_TEXT}

Verify Reminder Title Exists
    [Documentation]    Verifies that a reminder title with the specified text exists.
    [Arguments]    ${reminder_text}
    Log To Console    Verifies that a reminder title with the specified text exists.
    Page Should Contain Element    xpath=//XCUIElementTypeTextField[@name="Titel" and @value="${reminder_text}"]
