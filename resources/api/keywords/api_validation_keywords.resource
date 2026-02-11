*** Settings ***
Library    Collections
Library    JSONLibrary


*** Keywords ***
Schema Should Match
    [Documentation]    Basic schema presence check for required keys defined in object.schema.json.
    [Arguments]    ${json}    ${schema_file}
    ${is_list}=    Evaluate    isinstance($json, list)
    ${length}=    Get Length    ${json}
    Run Keyword If    ${is_list} and ${length} == 0    Fail    Expected non-empty list for schema validation but got empty list.
    ${item}=    Set Variable If    ${is_list}    ${json}[0]    ${json}
    Dictionary Should Contain Key    ${item}    id
    Dictionary Should Contain Key    ${item}    name
    Validate Json By Schema    ${item}    ${schema_file}

