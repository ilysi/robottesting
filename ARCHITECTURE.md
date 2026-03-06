# Test Automation Architecture Extension Plan

Dieses Dokument zeigt, WO und WIE die empfohlenen Verbesserungen in das bestehende Framework integriert werden können, ohne den aktuellen Ablauf zu stören. Es trennt gering-invasive Ergänzungen von optionalen Refactorings.

---
## 1. Keyword Taxonomie (Utility vs. Domain)

Aktuell: Dateien unter `resources/browser/keywords/*` bündeln seitenbezogene Aktionen.
Erweiterung:
- Verzeichnis: `resources/browser/domain_flows/`
  - Datei: `order_flow_keywords.resource` (kombinierte Schritte: Login → Produkt wählen → Warenkorb prüfen → Checkout)
- Verzeichnis: `resources/browser/utility/`
  - Datei: `wait_helpers.resource` (generische Synchronisations-/Retry-Keywords)

Einbaupunkt: Neue Dateien verwenden in komplexeren Tests (`tests/browser_tests/product_test.robot`).

---
## 2. Page/Screen Abstraktion

Aktuell: Lokator-Variablen in `resources/browser/variables/common_elements.resource`.
Erweiterung:
- Neues Verzeichnis: `resources/browser/page_objects/`
  - `login_page.resource` (nur Lokatoren + einfache Getter)
  - `product_page.resource`
  - `cart_page.resource`

Einbaupunkt: Bestehende Keywords (`login_page_keywords.resource`) rufen künftig Page-Object-Lokatoren statt gemeinsame Variable-Datei.

Optionaler Refactor (schrittweise):
1. Lokatoren extrahieren in neue Page-Datei
2. Keywords anpassen (kleine Überschneidungen testen)
3. Alte gemeinsame Datei nur für wirklich globale Elemente behalten.

---
## 3. API Contract- & Schema-Validierung

Aktuell: Validierung erfolgt über JSONLibrary ad hoc.
Erweiterung:
- Verzeichnis: `resources/api/schemas/`
  - `object.schema.json` (Schema für /objects Resource)
- Datei: `resources/api/keywords/api_validation_keywords.resource`
  - Keyword: `Schema Should Match    ${response.json()}    object.schema.json`

Einbaupunkt: In `tests/api_tests/test_api.robot` nach jedem erfolgreichen GET/POST/PUT vor inhaltlicher Prüfung.

---
## 4. Testfall-Tags Strategie

Aktuell: Keine Tags gesetzt.
Erweiterung:
- In jedem Testfall Kopf: `[Tags]    smoke    login` (z. B. für `Open Login Page`)
- Regression-Komplexfälle: `[Tags]    regression    cart` in `product_test.robot`
- Kritische Pfade: `[Tags]    critical    purchase`

Einbaupunkt: Direkt in den bestehenden Testdateien unter `*** Test Cases ***`.

Nutzen: Selektiver Lauf im CI:
```
robot --include smoke tests/browser_tests
robot --exclude mobile tests/
```

---
## 5. Logging & Tracing Vereinheitlichung

Aktuell: Manuelles `Set Log Level TRACE` in Keywords.
Erweiterung:
- Zentrales Initialisierungs-Keyword in neuer Datei `resources/browser/utility/session_init.resource`:
  - Start Tracing (Browser Library: `Start Tracing    screenshots=true    snapshots=true`)
  - Video-Verzeichnis definieren aus Variable `VIDEO_DIR` (ergänzen in `robot.toml`)
- Fehler-Hooks: Globales `Test Teardown` in Suite: `Stop Tracing` + ggf. `Take Screenshot` wenn fehlgeschlagen.

Einbaupunkt: Ersetzen von `Initialize Browser Without Login` in `login_test.robot` durch neues Setup.

---
## 6. Flakiness & Metriken

Erweiterung CI (`.github/workflows/ci.yml`):
- Schritt nach Testausführung: Python-Script `scripts/extract_metrics.py` parse `output.xml` → `results/metrics.json` (Dauer, Status, Wiederholungen).
- Optional: Retry-Mechanismus nur für fehlgeschlagene Tests (`--rerunfailed output.xml --output rerun.xml`).

Verzeichnis: `scripts/` (neu) → Datei: `extract_metrics.py`.

Einbaupunkt: In jedem Job nach `robot`-Ausführung, vor Artefakt-Upload.

---
## 7. Secrets & Credentials Handling

Aktuell: Usernamen/Passwörter in `robot.toml`.
Erweiterung:
- Entfernen `USERNAME`, `PASSWORD`, `LOCKEDUSER` aus `robot.toml` → stattdessen Umgebungsvariablen im CI setzen (`env:` Block).
- Neues Keyword `Read Credentials` in `resources/browser/utility/credential_keywords.resource`:
  - Liest `Get Environment Variable    USERNAME` etc.

Einbaupunkt: `Initialize Browser And Login` verwendet dann dynamische Werte, fallback auf Dummy wenn nicht gesetzt.

---
## 8. Gemeinsame Architektur-Dokumentation

Datei: Diese `ARCHITECTURE.md` dient als Navigationsanker für neue Contributor.
Optional weitere Abschnitte:
- Migrationsplan (Page Objects in Phasen)
- Qualitätsschwellen (z. B. <2% Flakiness für smoke)

---
## 9. Beispiel Ergänzungen (Startpunkte)

Neue Dateien (vorgeschlagen):
```
resources/
  browser/
    domain_flows/
      order_flow_keywords.resource
    page_objects/
      login_page.resource
  api/
    schemas/
      object.schema.json
    keywords/
      api_validation_keywords.resource
scripts/
  extract_metrics.py
```

### Beispiel: `object.schema.json`
```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "ObjectResource",
  "type": "object",
  "required": ["id", "name"],
  "properties": {
    "id": {"type": ["string", "number"]},
    "name": {"type": "string"},
    "data": {"type": "object"}
  }
}
```

### Beispiel: Keyword für Schema Validierung
`api_validation_keywords.resource`:
```robotframework
*** Settings ***
Library    JSONLibrary
Library    OperatingSystem

*** Keywords ***
Schema Should Match
    [Arguments]    ${json}    ${schema_file}
    ${schema_path}=    Join Path    ${CURDIR}/../schemas    ${schema_file}
    Validate Json By Schema    ${json}    ${schema_path}
```

---
## 10. Priorisierte Umsetzung (Empfohlene Reihenfolge)
1. Tags & Logging (geringes Risiko, sofortiger Nutzen)
2. Credential Externalisierung (Security)
3. API Schema Validierung (Qualitätssicherung)
4. Domain Flow Keywords (Lesbarkeit komplexer Abläufe)
5. Page Objects (schrittweiser Refactor)
6. Metriken & Flakiness (Optimierung, später)

---
## 11. CI Einbaupunkte (Übersicht)
- Vorhandene Jobs: `api-tests`, `web-tests`, `mobile-tests`, `combine-reports`
- Ergänzungen:
  - In `web-tests`: Export `VIDEO_DIR` / Start Tracing
  - In `api-tests`: Schema Validierung Keywords verwenden
  - Post-Schritt: `python scripts/extract_metrics.py`

---
## 12. Nächste Schritte
- Entscheidung: Sofortige Tagging-Einführung? → Anpassung aller Testdateien.
- Bestätigen: Dürfen Credentials aus `robot.toml` entfernt werden?
- Page Object Pilot: Nur Login zuerst refactoren.

Bei Bestätigung kann ein initialer Patch erstellt werden.
