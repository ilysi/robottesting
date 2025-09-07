*** Settings ***
Library         Browser
Resource        ../../resources/keywords/product_keywords.resource

Test Setup      Initialize Browser And Login


*** Test Cases ***
Open Product Page
    Given I Am On The Product Page
    # Then The Title Should Be Swag Labs
    Then The Product List Should Be Visible

Add Backpack To Cart
    Given I Am On The Product Page
    When I Add The Backpack To The Cart
    Then The Item Should Be In The Cart

Add Bike Light To Cart
    Given I Am On The Product Page
    When I Add The Bike Light To The Cart
    Then The Item Should Be In The Cart

Add Bolt T-Shirt To Cart
    Given I Am On The Product Page
    When I Add The Bolt T-Shirt To The Cart
    Then The Item Should Be In The Cart

Workflow Testfall (Warenkorb)
    Fail    no keywords yet

Komplexe Elemente testen
    Fail    no keywords yet