*** Settings ***
Documentation       Common elements for Reminder app tests.

*** Variables ***
# Welcome Screen FIrst Opening Remdiners App (German localization)
${REMINDER_WELCOME_SCREEN}    xpath=//XCUIElementTypeStaticText[@name="Willkommen bei Erinnerungen"]
# Welcome Screen Fortfahren Button
${REMINDER_WELCOME_FORTFAHREN_BUTTON}    xpath=//XCUIElementTypeButton[@name="Fortfahren"]
# Sync Visible Später Button
${REMINDER_SYNC_SPATER_BUTTON}    xpath=//XCUIElementTypeButton[@name="Später"]
# Listen View Got It Button
${LISTE_ERINNERUNGEN}    xpath=//XCUIElementTypeStaticText[@name="Erinnerungen"]
# Zurück Button von Erinnerungen
${LISTEN_BACK_BUTTON}    xpath=//XCUIElementTypeButton[@name="BackButton"]
# Neue Erinnerung Anlegen Button
${REMINDER_NEUE_ERINNERUNG_BUTTON}    xpath=//XCUIElementTypeButton[@name="Neue Erinnerung"]
# Title Input Field
${REMINDER_TITLE_INPUT}    xpath=//XCUIElementTypeTextField[@label="Titel"]
# Notes Input Field
${REMINDER_NOTES_INPUT}    xpath=//XCUIElementTypeTextField[@label="Notizen"]
# Edit Details Button
${REMINDER_EDIT_DETAILS_BUTTON}    xpath=//*[contains(@name, 'Details')]
# Date Switch
${REMINDER_DATE_SWITCH}    xpath=//XCUIElementTypeSwitch[@name="Datum"]
# Do Not Miss Notification Text
${REMINDER_DO_NOT_MISS_POPUP}    xpath=//XCUIElementTypeStaticText[@name="Nie eine Erinnerung verpassen"]
# Continue Button (for popups)
${REMINDER_CONTINUE_BUTTON}    xpath=//XCUIElementTypeButton[@name="Fortfahren"]
# Priority Label
${REMINDER_PRIORITY_LABEL}    xpath=//XCUIElementTypeStaticText[@name="Priorität"]
# Priority Medium Button
${REMINDER_PRIORITY_MEDIUM_BUTTON}    xpath=//XCUIElementTypeButton[@name="Mittel"]
# Reminder Save Button
${REMINDER_SAVE_BUTTON}    xpath=//XCUIElementTypeButton[@name="Fertig"]
# Reminder Planned Button
${REMINDER_PLANNED_BUTTON}    xpath=//XCUIElementTypeButton[contains(@name, 'Geplant')]
# Screen Erinnerungen
${SCREEN_ERINNERUNGEN}    xpath=//XCUIElementTypeNavigationBar[@name="Erinnerungen"]
