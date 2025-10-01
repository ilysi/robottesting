*** Settings ***
Documentation       Mobile test to open Safari and search for Robot Framework.
Library             AppiumLibrary
Resource            ../../resources/mobile/keywords/common_keywords.resource


*** Test Cases ***
First Test Open Safari And Search Robotframework
    [Documentation]    Open Safari and search for robotframework
    Open Safari
    Go To Url Of Robotframework
    Sleep    5s

Open Google And Search For Appium
    [Documentation]    Open Google and search for appium
    Open Safari
    Go To Url Of Google
    Search For Appium In Safari
    Sleep    5s
