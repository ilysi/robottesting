*** Settings ***
Documentation       Common elements for mobile UI tests.


*** Variables ***
# button for google popup to stay in used browser
${BROWSER_STAY_BUTTON}    xpath=//XCUIElementTypeButton[@name="Im Browser bleiben"]
# search field in Safari
${SAFARI_SEARCH_FIELD}    xpath=//textarea[@name="q"]
# appium wiki link in search results
${SAFARI_SEARCH_RESULT}   xpath=//XCUIElementTypeStaticText[@name="Wikipedia (Englisch)"]
