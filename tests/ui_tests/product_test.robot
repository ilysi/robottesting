*** Settings ***
Documentation       UI tests for the product functionality.

Resource            ../../resources/ui/keywords/product_page_keywords.resource
Resource            ../../resources/ui/keywords/shopping_cart_page_keywords.resource

Test Setup          Initialize Browser And Login


*** Test Cases ***
Open Product Page
    [Documentation]    Opens the product page and verifies the title and product list visibility.
    Given I Am On The Product Page
    Then The Title Should Be Swag Labs
    Then The Product List Should Be Visible

Add Backpack To Cart
    [Documentation]    Adds the backpack item to the shopping cart and verifies it is in the cart.
    Given I Am On The Product Page
    When I Add The Backpack To The Cart
    Then The Item Should Be In The Cart

Add Bike Light To Cart
    [Documentation]    Adds the bike light item to the shopping cart and verifies it is in the cart.
    Given I Am On The Product Page
    When I Add The Bike Light To The Cart
    Then The Item Should Be In The Cart

Add Bolt T-Shirt To Cart
    [Documentation]    Adds the bolt t-shirt item to the shopping cart and verifies it is in the cart.
    Given I Am On The Product Page
    When I Add The Bolt T-Shirt To The Cart
    Then The Item Should Be In The Cart

Workflow Testfall (Warenkorb)
    [Documentation]    Complete workflow test case from login to checkout and order.
    Given I Am On The Product Page
    And I Add The Backpack To The Cart
    And I Add The Bike Light To The Cart
    And I Add The Bolt T-Shirt To The Cart
    And The Item Should Be In The Cart
    And I Go To The Shopping Cart
    # Verify items in cart
    And I Found "3" Items In The Cart
    # Proceed to checkout
    And I Go To Checkout
    # Enter details
    And Fill In Information
    # Continue to overview
    And Click Continue To Step Two
    # Finish order
    When Click Finish Order
    # Verify order completion
    Then Verify Order Completion
    # Note: The following steps need to be implemented in the keywords resource file.

# Komplexe Elemente testen
#    Fail    no keywords yet
