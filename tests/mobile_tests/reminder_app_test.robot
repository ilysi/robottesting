*** Settings ***
Documentation       POC mobile tests for native iOS app (Calculator demo).
Library             AppiumLibrary
Resource            ../../resources/mobile/keywords/reminder_keywords.resource

Test Setup    Open Reminder App And Handle Popups
Test Teardown    Close App After Test Execution


*** Test Cases ***
Create New Reminder And Verify
    [Documentation]    Creates a new reminder and verifies its presence.
    Add Reminder Item    Groceries
    Verify Reminder Item Exists In Planned Items
