*** Settings ***
Documentation       POC mobile tests for native iOS app (Calculator demo).
Library             AppiumLibrary
Resource            ../../resources/mobile/keywords/common_keywords.resource


*** Test Cases ***
Create New Reminder And Verify
    [Documentation]    Creates a new reminder and verifies its presence.
    Open Reminder App
    Add Reminder Item    Buy groceries
    Verify Reminder Item Exists In Planned Items    Buy groceries
