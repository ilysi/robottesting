*** Settings ***
Library    Browser

Resource    ../variables/common_variables.resource

*** Keywords ***
I am on the login page
    New Page    ${baseUrl}

the title should be Swag Labs
    Get Title    ==    Swag Labs

the login button should be visible
    Get Text    id=login-button    ==    Login

I login with username "${username}" and password "${password}"
    Fill Text    id=user-name    ${username}
    Fill Text    id=password    ${password}
    Click    id=login-button

I should see the homepage
    Get Text    //div[@class='app_logo']    contains    Swag Labs

I should see an error message
    Get Text    //h3[@data-test='error']    ==    Epic sadface: Username and password do not match any user in this service

I should see a locked out message
    Get Text    //h3[@data-test='error']    ==    Epic sadface: Sorry, this user has been locked out.