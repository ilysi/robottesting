*** Settings ***
Documentation       Keywords for shopping cart page actions.

Library             Browser
Resource            ../variables/common_variables.resource
Resource            ../variables/common_elements.resource


*** Keywords ***
I Found "${NUMBER_OF_ITEMS}" Items In The Cart
    [Documentation]    Verifies the number of items in the shopping cart.
    Get Element Count    ${INVENTORY_ITEMS}    ==    ${NUMBER_OF_ITEMS}

I Go To Checkout
    [Documentation]    Clicks the checkout button on the shopping cart page.
    Click    ${CHECKOUT_BUTTON}
    Get Url    ==    ${baseUrl}/checkout-step-one.html

Fill In Information
    [Documentation]    Fills in the checkout information form step one.
    Fill Text    ${FIRST_NAME_FIELD}    Max
    Fill Text    ${LAST_NAME_FIELD}    Mustermann
    Fill Text    ${POSTAL_CODE_FIELD}    12345

Click Continue To Step Two
    [Documentation]    Clicks the continue button on the checkout information page.
    Click    ${CONTINUE_BUTTON}
    Get Url    ==    ${baseUrl}/checkout-step-two.html

Click Finish Order
    [Documentation]    Clicks the finish button on the checkout overview page.
    Click    ${FINISH_BUTTON}
    Get Url    ==    ${baseUrl}/checkout-complete.html

Verify Order Completion
    [Documentation]    Verifies that the order completion page is displayed.
    Get Text    ${ORDER_COMPLETE_HEADER}    ==    Thank you for your order!
