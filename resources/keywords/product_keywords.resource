*** Settings ***
Library    Browser

Resource    ../variables/common_variables.resource
Resource    ../keywords/login_keywords.resource

*** Keywords ***
Initialize Browser And Login
    Set Log Level    level=TRACE
    # New Browser    browser=chromium    headless=False
    Open Browser    ${None}    chromium    False
    And I am on the login page
    And I login with username "standard_user" and password "secret_sauce"
    Wait For Elements State    css=.shopping_cart_link    stable

I am on the product page
    # Go To    ${baseUrl}/inventory.html
    Get Url    ==    ${baseUrl}/inventory.html
    

# the title should be Swag Labs
#     Get Title    ==    Swag Labs

the product list should be visible
    Wait For Elements State    css=.inventory_list    visible

I add the backpack to the cart
    Click    id=add-to-cart-sauce-labs-backpack

I add the bike light to the cart
    Click    id=add-to-cart-sauce-labs-bike-light

I add the bolt t-shirt to the cart
    Click    id=add-to-cart-sauce-labs-bolt-t-shirt

the item should be in the cart
    Wait For Elements State    css=.shopping_cart_badge    visible