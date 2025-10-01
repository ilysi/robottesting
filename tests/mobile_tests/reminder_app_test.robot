*** Settings ***
Documentation       POC mobile tests for native iOS app (Calculator demo).
Library             DateTime
Library             AppiumLibrary
Resource            ../../resources/mobile/keywords/common_keywords.resource


*** Test Cases ***
Create New Reminder And Verify
    [Documentation]    Creates a new reminder and verifies its presence.
    Open Reminder App
    ${timestamp}=    Get Current Date    result_format=%Y-%m-%d %H:%M:%S
    VAR    ${reminder_text}    Buy big groceries ${timestamp}
    Add Reminder Item    ${reminder_text}
    Verify Reminder Item Exists In Planned Items    ${reminder_text}
