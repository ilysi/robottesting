*** Settings ***
Documentation       Mobile capabilities for Reminder App on iOS


*** Variables ***
&{REMINDER_CAPABILITIES}    platformName=iOS
...                         appium:automationName=XCUITest
...                         appium:deviceName=iPhone 17
...                         appium:platformVersion=26.2
...                         appium:bundleId=com.apple.reminders
...                         appium:noReset=${False}
...                         appium:fullReset=${True}
...                         appium:includeSafariInWebviews=${True}
...                         appium:language=de
...                         appium:locale=de_DE
...                         appium:wdaLaunchTimeout=300000
...                         appium:wdaConnectionTimeout=300000
...                         appium:newCommandTimeout=300
