*** Settings ***
Library    Browser

Resource    ../../resources/keywords/login_keywords.resource

Test Setup    New Browser    browser=chromium    headless=False

*** Test Cases ***
Open Login Page
    Given I am on the login page
    Then the title should be Swag Labs
    And the login button should be visible

Login to Homepage
    Given I am on the login page
    When I login with username "standard_user" and password "secret_sauce"
    Then I should see the homepage

Login With False Password
    Given I am on the login page
    When I login with username "standard_user" and password "secret_sausages"
    Then I should see an error message

Login With Locked Out User
    Given I am on the login page
    When I login with username "locked_out_user" and password "secret_sauce"
    Then I should see a locked out message