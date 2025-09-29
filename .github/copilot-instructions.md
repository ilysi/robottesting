# Copilot Instructions for robottesting

## Project Overview
This repository is a Robot Framework test suite for web, API, and mobile automation. It uses Robot Framework, RobotCode, and several libraries for browser, API, and mobile testing. Tests are organized by platform and type.

## Architecture & Structure
- **tests/**: Main test suites, organized into `api_tests/`, `browser_tests/`, and `mobile_tests/`. Each test file uses Robot Framework syntax.
- **resources/**: Shared resources, including keywords and variables for browser and API tests. Use these for reusable logic and data.
- **browser/**: Likely used for browser traces and temp files (not for test logic).
- **robot.toml**: Project-level configuration, including global variables (e.g., `BASEURL`, credentials, browser type).
- **pyproject.toml**: Python dependencies and build config. Uses Poetry for environment management.

## Key Libraries & Dependencies
- `robotframework`, `robotcode`, `robotframework-browser`, `robotframework-jsonlibrary`, `robotframework-requests`, `robotframework-appiumlibrary`
- Mobile tests use Appium via `AppiumLibrary`.
- Browser tests use `robotframework-browser`.
- API tests use `robotframework-requests` and `robotframework-jsonlibrary`.

## Developer Workflows
- **Install dependencies:**
  ```sh
  poetry install
  ```
- **Run tests:**
  Use RobotCode runner or standard Robot Framework CLI. Example:
  ```sh
  robot tests/browser_tests/login_test.robot
  robot tests/api_tests/test_api.robot
  robot tests/mobile_tests/start_test.robot
  ```
  Or run all tests:
  ```sh
  robot tests/
  ```
- **Configure environment:**
  - Global variables and settings in `robot.toml`.
  - Python version: 3.11+
- **Debugging:**
  - Use `log-level` in `robot.toml` to adjust verbosity.
  - Output directory is set to `results`.

## Project-Specific Patterns
- **Variables:**
  - Global variables in `robot.toml` and per-suite variables in each test file.
- **Keywords:**
  - Custom keywords defined in resource files (e.g., `resources/browser/keywords/`) and within test files.
  - Use `[Documentation]` tags for keyword and test case descriptions.
- **Test Case Organization:**
  - Each test file starts with `*** Settings ***`, `*** Variables ***`, `*** Test Cases ***`, and `*** Keywords ***` sections.
- **Mobile Testing:**
  - Uses Appium with iOS device configuration. See `tests/mobile_tests/start_test.robot` for example.

## Integration Points
- **External services:**
  - Mobile tests require Appium server running at `${REMOTE_URL}`.
  - Browser and API tests use external URLs (e.g., `BASEURL`).

## Conventions
- Use descriptive names for test cases and keywords.
- Store reusable logic in resource files.
- Keep secrets and credentials in configuration, not in code.
- Prefer `robot.toml` for project-wide settings.
- Use Robot Framework formatting and best practices.

## CI/CD Pipeline
Automated tests are run via GitHub Actions (`.github/workflows/ci.yml`) on every push, pull request, or manual trigger. The workflow is split into jobs for API, browser, and mobile tests:

- **api-tests**: Runs API tests on Ubuntu, saves results as artifacts.
- **web-tests**: Runs browser tests (with rfbrowser) on Ubuntu, sets up Node.js and browser dependencies, saves results as artifacts.
- **mobile-tests**: Runs Appium/iOS simulator tests on macOS, boots simulator, installs Appium, starts server, saves logs and results as artifacts.
- **combine-reports**: Downloads all results, merges them with `rebot`, and uploads a combined report.

Artifacts are retained for 7 days. Mobile tests require macOS runners and Appium setup. See `ci.yml` for details on environment setup and job dependencies.

## Example: Mobile Test Structure
```robotframework
*** Settings ***
Library    AppiumLibrary
*** Variables ***
${REMOTE_URL}    http://127.0.0.1:4723
*** Test Cases ***
First Test Open Safari And Search Robotframework
    Open Safari
    Go To Url Of Robotframework
*** Keywords ***
Open Safari
    Open Application    ${REMOTE_URL} ...
```

---
If any section is unclear or missing, please provide feedback to improve these instructions.