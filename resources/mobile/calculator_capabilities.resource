*** Settings ***
Documentation       Mobile capabilities for Calculator on iOS


*** Variables ***
&{CALCULATOR_CAPABILITIES}      platformName=iOS
...                             appium:automationName=XCUITest
...                             appium:deviceName=iPhone 17 Pro
...                             appium:platformVersion=26.2
...                             appium:bundleId=com.apple.calculator
...                             appium:noReset=${False}
...                             appium:fullReset=${True}
...                             appium:includeSafariInWebviews=${False}
...                             appium:language=de
...                             appium:locale=de_DE
...                             appium:wdaLaunchTimeout=300000
...                             appium:wdaConnectionTimeout=300000
...                             appium:newCommandTimeout=300
...                             appium:wdaStartupRetries=2
