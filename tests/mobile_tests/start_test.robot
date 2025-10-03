*** Settings ***
Documentation       Mobile test to open Safari and search for Robot Framework.

Library             AppiumLibrary
Resource            ../../resources/mobile/keywords/safari_keywords.resource


*** Test Cases ***
First Test Open Safari And Search Robotframework
    [Documentation]    Open Safari and search for robotframework
    Open Safari
    Go To Url Of Robotframework
