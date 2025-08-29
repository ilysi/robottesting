*** Settings ***
Library    Browser
Resource    ../../resources/keywords/product_keywords.resource

Test Setup    Initialize Browser And Login

*** Test Cases ***
Open Product Page
    [Documentation]
    Given I am on the product page
    # Then the title should be Swag Labs
    Then the product list should be visible

Add Backpack to Cart
    Given I am on the product page
    When I add the backpack to the cart
    Then the item should be in the cart

Add Bike Light to Cart
    Given I am on the product page
    When I add the bike light to the cart
    Then the item should be in the cart

Add Bolt T-Shirt to Cart
    Given I am on the product page
    When I add the bolt t-shirt to the cart
    Then the item should be in the cart

Workflow Testfall (Warenkorb)

Komplexe Elemente testen