*** Settings ***
Documentation       Common elements for UI tests.


*** Variables ***
${TITLE}                    Swag Labs

# Login Page Elements
${LOGIN_BUTTON}             id=login-button
${USERNAME_FIELD}           id=user-name
${PASSWORD_FIELD}           id=password
${ERROR_MESSAGE}            xpath=//h3[@data-test='error']

# Product Page Elements
${HOMEPAGE_APP_LOGO}        xpath=//div[@class='app_logo']
${PRODUCT_LIST}             css=.inventory_list
${BACKPACK_PRODUCT}         id=add-to-cart-sauce-labs-backpack
${BIKE_LIGHT_PRODUCT}       id=add-to-cart-sauce-labs-bike-light
${BOLT_TSHIRT_PRODUCT}      id=add-to-cart-sauce-labs-bolt-t-shirt
${SHOPPING_CART_BADGE}      css=.shopping_cart_badge
${SHOPPING_CART_LINK}       xpath=//a[@data-test="shopping-cart-link"]
${INVENTORY_ITEMS}          xpath=//*[@data-test="inventory-item"]
${CHECKOUT_BUTTON}          xpath=//button[@data-test="checkout"]

# Shopping Cart Page Elements
${FIRST_NAME_FIELD}         xpath=//input[@id="first-name"]
${LAST_NAME_FIELD}          xpath=//input[@id="last-name"]
${POSTAL_CODE_FIELD}        xpath=//input[@id="postal-code"]
${CONTINUE_BUTTON}          xpath=//input[@id="continue"]
${FINISH_BUTTON}            xpath=//button[@id="finish"]
${ORDER_COMPLETE_HEADER}    xpath=//h2[@class="complete-header"]
