*** Settings ***
Documentation       UI tests for the product functionality.

Resource            ../../resources/browser/keywords/product_page_keywords.resource
Resource            ../../resources/browser/keywords/shopping_cart_page_keywords.resource

Test Setup          Initialize Browser And Login


*** Test Cases ***
Open Product Page
    [Tags]    browser    smoke    product
    [Documentation]    Opens the product page and verifies the title and product list visibility.
    Given I Am On The Product Page
    Then The Title Should Be Swag Labs
    Then The Product List Should Be Visible

Add Backpack To Cart
    [Tags]    browser    regression    cart
    [Documentation]    Adds the backpack item to the shopping cart and verifies it is in the cart.
    Given I Am On The Product Page
    When I Add The Backpack To The Cart
    Then The Item Should Be In The Cart

Add Bike Light To Cart
    [Tags]    browser    regression    cart
    [Documentation]    Adds the bike light item to the shopping cart and verifies it is in the cart.
    Given I Am On The Product Page
    When I Add The Bike Light To The Cart
    Then The Item Should Be In The Cart

Add Bolt T-Shirt To Cart
    [Tags]    browser    regression    cart
    [Documentation]    Adds the bolt t-shirt item to the shopping cart and verifies it is in the cart.
    Given I Am On The Product Page
    When I Add The Bolt T-Shirt To The Cart
    Then The Item Should Be In The Cart

Workflow Testfall (Warenkorb)
    [Tags]    browser    e2e    cart    critical
    [Documentation]    Complete workflow test case from login to checkout and order.
    Given I Am On The Product Page
    And I Add The Backpack To The Cart
    And I Add The Bike Light To The Cart
    And I Add The Bolt T-Shirt To The Cart
    And The Item Should Be In The Cart
    And I Go To The Shopping Cart
    And I Found "3" Items In The Cart
    And I Go To Checkout
    And Fill In Information
    And Click Continue To Step Two
    When Click Finish Order
    Then Verify Order Completion
