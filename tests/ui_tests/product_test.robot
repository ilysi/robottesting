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

# Workflow Testfall (Warenkorb)
#     Fail    no keywords yet

# Komplexe Elemente testen
#     Fail    no keywords yet