*** Settings ***
Documentation       POC mobile tests for native iOS app (Calculator demo).
Library             AppiumLibrary
Resource            ../../resources/mobile/keywords/common_keywords.resource


*** Test Cases ***
Launch Calculator And Verify UI
    [Documentation]    Launches Calculator app and checks if result display is visible.
    [Tags]    robot:exclude
    Open Calculator App
    Wait Until Element Is Visible    accessibility_id=Result    10s
    Element Should Be Visible    accessibility_id=Result
    Close Application

Perform Simple Calculation
    [Documentation]    Performs 2 + 3 and verifies the result.
    [Tags]    robot:exclude
    Open Calculator App
    Tap Calculator Button    2
    Tap Calculator Button    +
    Tap Calculator Button    3
    Tap Calculator Button    =
    ${result}    Get Calculator Result
    Should Be Equal    ${result}    5
    Close Application

Handle Alert In App
    [Documentation]    Tests navigation and alert handling
    ...    (simulate by triggering an action that might show an alert; adjust for your app).
    [Tags]    robot:exclude
    Open Calculator App
    # Example: If your app has a menu or action that triggers an alert
    Tap Calculator Button    AC  # Clear, or replace with app-specific action
    # Assume an alert appears; accept it
    Wait Until Element Is Visible    //XCUIElementTypeAlert    5s
    Click Element    //XCUIElementTypeButton[@name="OK"]  # Adjust locator
    Close Application
