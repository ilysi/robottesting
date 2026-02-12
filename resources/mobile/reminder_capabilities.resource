*** Settings ***
Documentation       Mobile capabilities for Reminder App on iOS


*** Variables ***
&{REMINDER_CAPABILITIES}    platformName=iOS
...                         appium:automationName=XCUITest
...                         appium:deviceName=iPhone 16
...                         appium:platformVersion=18.6
...                         appium:bundleId=com.apple.reminders
...                         appium:noReset=${False}
...                         appium:fullReset=${False}
...                         appium:includeSafariInWebviews=${False}
...                         appium:language=de
...                         appium:locale=de_DE
...                         appium:wdaLaunchTimeout=300000
...                         appium:wdaConnectionTimeout=300000
...                         appium:newCommandTimeout=300
