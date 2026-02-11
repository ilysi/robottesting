*** Settings ***
Library    Collections



*** Keywords ***
Schema Should Match
    [Documentation]    Basic schema presence check for required keys defined in object.schema.json.
    [Arguments]    ${json}    ${schema_file}
    ${is_list}=    Evaluate    isinstance($json, list)
    ${item}=    Set Variable If    ${is_list}    ${json}[0]    ${json}
    Dictionary Should Contain Key    ${item}    id
    Dictionary Should Contain Key    ${item}    name
