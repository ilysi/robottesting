*** Settings ***
Documentation       Keywords for login actions.

Library             Browser
Resource            ../variables/common_variables.resource
Resource            ../variables/common_elements.resource


*** Keywords ***
I Am On The Login Page
    [Documentation]    Navigates to the login page using the base URL.
    Get Url    ==    ${BASEURL}/

The Title Should Be Swag Labs
    [Documentation]    Verifies that the page title is 'Swag Labs'.
    Get Title    ==    ${TITLE}

The Login Button Should Be Visible
    [Documentation]    Checks that the login button is visible and has the correct text.
    Get Text    ${LOGIN_BUTTON}    ==    Login

I Login With Username "${USERNAME}" And Password "${PASSWORD}"
    [Documentation]    Fills in the username and password fields and clicks the login button.
    Fill Text    ${USERNAME_FIELD}    ${USERNAME}
    Fill Text    ${PASSWORD_FIELD}    ${PASSWORD}
    Click    ${LOGIN_BUTTON}

I Should See The Homepage
    [Documentation]    Verifies that the homepage is displayed after login.
    Get Text    ${HOMEPAGE_APP_LOGO}    contains    Swag Labs

I Should See An Error Message
    [Documentation]    Checks for the error message when login fails.
    Get Text
    ...    ${ERROR_MESSAGE}
    ...    ==
    ...    Epic sadface: Username and password do not match any user in this service

I Should See A Locked Out Message
    [Documentation]    Checks for the locked out user error message.
    Get Text    ${ERROR_MESSAGE}    ==    Epic sadface: Sorry, this user has been locked out.

Initialize Browser And Login
    [Documentation]    Initializes the browser and logs in with standard user credentials.
    Set Log Level    level=TRACE
    New Browser    browser=webkit    headless=False    slowMo=1s
    New Context    recordVideo={"dir": "videos", "size": {"width": 800, "height": 600}}
    # Open Browser is for debugging purposes
    # Open Browser    ${None}    chromium    False
    New Page    ${baseUrl}
    And I Am On The Login Page
    And I Login With Username "${USERNAME}" And Password "${PASSWORD}"
    Wait For Elements State    css=.shopping_cart_link    stable

Initialize Browser Without Login
    [Documentation]    Initializes the browser without logging in.
    Set Log Level    level=TRACE
    New Browser    browser=webkit    headless=False    slowMo=1s
    New Context    recordVideo={"dir": "videos", "size": {"width": 800, "height": 600}}
    # Open Browser is for debugging purposes
    Open Browser    url=${BASEURL}    browser=webkit    headless=False
