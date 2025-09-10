*** Settings ***
Library     Browser
Resource    ../variables/common_variables.resource
Resource    ../keywords/login_keywords.resource


*** Keywords ***
Initialize Browser And Login
    [Documentation]    Initializes the browser and logs in with standard user credentials.
    Set Log Level    level=TRACE
    New Browser    browser=chromium    headless=True
    # Open Browser is for debugging purposes
    # Open Browser    ${None}    chromium    False
    New Page    ${baseUrl}
    And I Am On The Login Page
    And I Login With Username "standard_user" And Password "secret_sauce"
    Wait For Elements State    css=.shopping_cart_link    stable

I Am On The Product Page
    # Go To    ${baseUrl}/inventory.html
    Get Url    ==    ${baseUrl}/inventory.html

# The Title Should Be Swag Labs
#    Get Title    ==    Swag Labs

The Product List Should Be Visible
    Wait For Elements State    css=.inventory_list    visible

I Add The Backpack To The Cart
    Click    id=add-to-cart-sauce-labs-backpack

I Add The Bike Light To The Cart
    Click    id=add-to-cart-sauce-labs-bike-light

I Add The Bolt T-Shirt To The Cart
    Click    id=add-to-cart-sauce-labs-bolt-t-shirt

The Item Should Be In The Cart
    Wait For Elements State    css=.shopping_cart_badge    visible
