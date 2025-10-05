*** Settings ***
Documentation       Common keywords for mobile tests.
Library             DateTime
Library             AppiumLibrary


*** Keywords ***
Click On Visible Element
    [Documentation]    Clicks on an element if it is visible within the specified timeout.
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    10s
    Click Element    ${locator}

Input Text If Visible
    [Documentation]    Inputs text into a field if it is visible within the specified timeout.
    [Arguments]    ${locator}    ${text}
    Wait Until Element Is Visible    ${locator}    5s
    Input Text    ${locator}    ${text}
