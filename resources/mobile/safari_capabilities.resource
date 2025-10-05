*** Settings ***
Documentation       Mobile capabilities for Safari on iOS


*** Variables ***
&{SAFARI_CAPABILITIES}      platformName=iOS
...                         appium:automationName=XCUITest
...                         appium:deviceName=iPhone 16 Pro
...                         appium:platformVersion=18.6
...                         browserName=Safari
...                         appium:wdaLaunchTimeout=300000
...                         appium:wdaConnectionTimeout=300000
...                         appium:newCommandTimeout=300
