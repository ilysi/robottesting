# Robot Testing Suite

A Robot Framework test automation project for **API**, **web browser**, and **mobile (Appium/iOS)** testing.

## Tech Stack

- Robot Framework
- RobotCode runner
- Browser library (`robotframework-browser`)
- Requests + JSON libraries for API testing
- AppiumLibrary for mobile testing
- Poetry for dependency management

## Prerequisites

- Python 3.11+
- Poetry
- Node.js (required for Browser library setup)
- Appium + XCUITest driver (for mobile tests)
- macOS + Xcode Simulator (for local iOS mobile tests)

## Installation

```bash
poetry install
```

For browser tests, initialize browser dependencies once:

```bash
poetry run rfbrowser init
```

## Run Tests

### Run all tests

```bash
poetry run robotcode robot --outputdir results tests/
```

### Run API tests

```bash
poetry run robotcode robot --outputdir results/api tests/api_tests
```

### Run browser tests

```bash
poetry run robotcode robot --outputdir results/browser tests/browser_tests
```

### Run mobile tests

Make sure Appium is running (default: `http://127.0.0.1:4723`) and an iOS simulator/device is available.

```bash
poetry run robotcode robot --outputdir results/mobile tests/mobile_tests
```

## Project Structure

```text
tests/
  api_tests/
  browser_tests/
  mobile_tests/
resources/
  api/
    keywords/
    payload/
    schemas/
  browser/
    keywords/
    variables/
  mobile/
    keywords/
    variables/
results/
```

## Configuration

Global defaults are defined in `robot.toml`, including variables such as:

- `BASEURL`
- `BROWSER`
- `USERNAME`
- `PASSWORD`
- `TIMEOUT`

## CI

GitHub Actions runs tests on push/PR to `master`:

- `api-tests` (Ubuntu)
- `browser-tests` (Ubuntu + Browser setup)
- `mobile-tests` (macOS + Appium + iOS Simulator)

Each job uploads Robot Framework results as artifacts.

## Notes

- Output files (`output.xml`, `log.html`, `report.html`) are written under `results/`.
- Keep sensitive credentials out of committed files and prefer secrets/environment variables for CI.

## Troubleshooting

- **`poetry run robotcode tests` fails**  
  Use the Robot command form instead:
  ```bash
  poetry run robotcode robot --outputdir results tests/
  ```

- **Browser tests fail before execution (`rfbrowser`/Playwright issues)**  
  Initialize browser dependencies:
  ```bash
  poetry run rfbrowser init
  ```

- **Mobile tests cannot connect to Appium (`127.0.0.1:4723`)**  
  Start Appium and verify the server is up:
  ```bash
  appium --address 127.0.0.1 --port 4723
  ```

- **iOS mobile tests fail to launch app/session**  
  Ensure Xcode is installed, a simulator is booted, and the Appium `xcuitest` driver is installed:
  ```bash
  appium driver install xcuitest
  ```

- **Dependencies/import errors in Robot run**  
  Reinstall dependencies in the Poetry environment:
  ```bash
  poetry install
  ```
