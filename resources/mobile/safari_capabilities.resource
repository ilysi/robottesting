*** Settings ***
Documentation       Mobile capabilities for Safari on iOS


*** Variables ***
&{SAFARI_CAPABILITIES}      platformName=iOS
...                         appium:automationName=XCUITest
...                         appium:deviceName=iPhone 17 Pro
...                         appium:platformVersion=26.2
...                         browserName=Safari
...                         appium:noReset=${False}
...                         appium:fullReset=${True}
...                         appium:includeSafariInWebviews=${True}
...                         appium:language=de
...                         appium:locale=de_DE
...                         appium:wdaLaunchTimeout=300000
...                         appium:wdaConnectionTimeout=300000
...                         appium:newCommandTimeout=3600
...                         appium:webviewConnectTimeout=10000
