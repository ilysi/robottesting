*** Settings ***
Documentation       UI tests for the login functionality.

Resource            ../../resources/ui/keywords/login_page_keywords.resource

Test Setup          New Browser    browser=chromium    headless=True


*** Test Cases ***
Open Login Page
    [Documentation]    Opens the login page and verifies the title and login button visibility.
    Given I Am On The Login Page
    Then The Title Should Be Swag Labs
    And The Login Button Should Be Visible

Login to Homepage
    [Documentation]    Logs in with valid credentials and verifies the homepage is displayed.
    Given I Am On The Login Page
    When I Login With Username "${USERNAME}" And Password "${PASSWORD}"
    Then I Should See The Homepage

Login With False Password
    [Documentation]    Attempts to log in with a valid username but incorrect password and checks for an error message.
    Given I Am On The Login Page
    When I Login With Username "${USERNAME}" And Password "${PASSWORD}"
    Then I Should See An Error Message

Login With Locked Out User
    [Documentation]    Attempts to log in with a locked out user and checks for the locked out message.
    Given I Am On The Login Page
    When I Login With Username "${LOCKEDUSER}" And Password "${PASSWORD}"
    Then I Should See A Locked Out Message
