*** Settings ***
Documentation       POC mobile tests for native iOS app (Reminder App).

Library             AppiumLibrary
Resource            ../../resources/mobile/keywords/reminder_keywords.resource

Suite Setup         Open Reminder App And Handle Popups
Suite Teardown      Close App After Test Execution


*** Test Cases ***
Create New Reminder And Verify
    [Documentation]    Creates a new reminder and verifies its presence.
    Add Reminder Item    Groceries
    Verify Reminder Item Exists In Planned Items
