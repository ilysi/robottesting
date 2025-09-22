*** Settings ***
Documentation       Keywords for product page actions.

Library             Browser
Resource            ./login_page_keywords.resource
Resource            ../variables/common_elements.resource


*** Keywords ***
I Am On The Product Page
    [Documentation]    Navigates to the product page and verifies the URL.
    Get Url    ==    ${baseUrl}/inventory.html

# The Title Should Be Swag Labs
#    Get Title    ==    Swag Labs

The Product List Should Be Visible
    [Documentation]    Checks that the product list is visible on the product page.
    Wait For Elements State    ${PRODUCT_LIST}    visible

I Add The Backpack To The Cart
    [Documentation]    Adds the backpack item to the shopping cart.
    Click    ${BACKPACK_PRODUCT}

I Add The Bike Light To The Cart
    [Documentation]    Adds the bike light item to the shopping cart.
    Click    ${BIKE_LIGHT_PRODUCT}

I Add The Bolt T-Shirt To The Cart
    [Documentation]    Adds the bolt t-shirt item to the shopping cart.
    Click    ${BOLT_TSHIRT_PRODUCT}

The Item Should Be In The Cart
    [Documentation]    Verifies that an item has been added to the shopping cart.
    Wait For Elements State    ${SHOPPING_CART_BADGE}    visible

I Go To The Shopping Cart
    [Documentation]    Navigates to the shopping cart page.
    Click    ${SHOPPING_CART_LINK}
    Get Url    ==    ${baseUrl}/cart.html
