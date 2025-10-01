*** Settings ***
Documentation    Mobile capabilities for Safari on iOS


*** Variables ***
&{CALCULATOR_CAPABILITIES}    platformName=iOS
...    automationName=XCUITest
...    deviceName=iPhone 16 Pro
...    platformVersion=18.6
...    bundleId=com.apple.calculator
...    wdaLaunchTimeout=300000
...    wdaConnectionTimeout=300000
...    newCommandTimeout=300
