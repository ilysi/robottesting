*** Settings ***
Library         Collections
Library         OperatingSystem
Library         RequestsLibrary
Library         JSONLibrary
Resource        ../../resources/api/keywords/api_validation_keywords.resource

Suite Setup     Setup


*** Variables ***
${BODY_FILE}=           ${CURDIR}/../../resources/api/payload/addObject_2.json
${BODY_FILE_2}=         ${CURDIR}/../../resources/api/payload/addObject_2_update.json
${BODY_FILE_PATCH}=     ${CURDIR}/../../resources/api/payload/addObject_2_patch.json
${id}=                  3
${id_wf}=               ${EMPTY}


*** Test Cases ***
Get_List_Of_All_Objects
    [Tags]    api    smoke
    ${response}=    GET On Session    restfulapi    /objects
    Status Should Be    expected_status=200
    Log To Console    ${response.json()}

List_of_objects_by_ids
    [Tags]    api    regression
    ${response}=    GET On Session    restfulapi    /objects    params=id=3&id=5&id=10
    Status Should Be    expected_status=200
    Log To Console    ${response.json()}
    Request Should Be Successful    response=${response}

Single_object
    [Tags]    api    smoke
    ${response}=    GET On Session    restfulapi    /objects/${id}
    Status Should Be    expected_status=200
    Log To Console    ${response.json()}
    Dictionary Should Contain Item    ${response.json()}    key=id    value=3
    Schema Should Match    ${response.json()}    object.schema.json

Add_object
    [Tags]    api    create    critical
    ${body}=    Load Json From File    ${BODY_FILE}

    ${response}=    POST On Session    restfulapi    /objects    json=${body}
    Status Should Be    expected_status=200
    Log To Console    ${response.json()}
    Should Be Equal    ${response.json()}[name]    Test post operation
    Schema Should Match    ${response.json()}    object.schema.json

Single_added_object
    [Tags]    api    regression
    ${response}=    GET On Session    restfulapi    /objects/ff80818196f2a23f019773b36c4411e5
    Status Should Be    expected_status=200
    Log To Console    ${response.json()}
    Dictionary Should Contain Item    ${response.json()}    key=id    value=ff80818196f2a23f019773b36c4411e5
    Schema Should Match    ${response.json()}    object.schema.json

Update_object
    [Tags]    api    update    critical
    ${body}=    Load Json From File    ${BODY_FILE_2}

    ${response}=    PUT On Session    restfulapi    /objects/ff80818196f2a23f019773b36c4411e5    json=${body}
    Status Should Be    expected_status=200
    Log To Console    ${response.json()}
    Dictionary Should Contain Item    ${response.json()}    key=id    value=ff80818196f2a23f019773b36c4411e5
    Dictionary Should Contain Item    ${response.json()}    key=name    value=Test post operation2
    Schema Should Match    ${response.json()}    object.schema.json

Single_added_object_2
    [Tags]    api    regression
    ${response}=    GET On Session    restfulapi    /objects/ff80818196f2a23f019773b36c4411e5
    Status Should Be    expected_status=200
    Log To Console    ${response.json()}

    # Validation
    ${actual_value2}=    Get Value From Json    ${response.json()}    $.id
    ${actual_value2}=    Set Variable    ${actual_value2}[0]
    Should Be Equal    ${actual_value2}    ff80818196f2a23f019773b36c4411e5

    ${actual_value2}=    Get Value From Json    ${response.json()}    $.name
    ${actual_value2}=    Set Variable    ${actual_value2}[0]
    Should Be Equal    ${actual_value2}    Test post operation2

    ${actual_value2}=    Get Value From Json    ${response.json()}    $.data.test
    ${actual_value2}=    Set Variable    ${actual_value2}[0]
    Should Be Equal    ${actual_value2}    put operation update data
    Schema Should Match    ${response.json()}    object.schema.json

Partially_update_object
    [Tags]    api    patch
    ${body}=    Load Json From File    ${BODY_FILE_PATCH}

    ${response}=    PATCH On Session    restfulapi    /objects/ff80818196f2a23f019773b36c4411e5    json=${body}
    Status Should Be    expected_status=200
    Log To Console    ${response.json()}
    Dictionary Should Contain Item    ${response.json()}    key=id    value=ff80818196f2a23f019773b36c4411e5
    Dictionary Should Contain Item
    ...    ${response.json()}
    ...    key=name
    ...    value=Test post operation2 (PAtch update test operation)
    Schema Should Match    ${response.json()}    object.schema.json

Delete_object
    [Tags]    api    delete    cleanup
    ${response}=    DELETE On Session    restfulapi    /objects/${id_wf}
    Status Should Be    expected_status=200

# Post, Put, Delete Workflow Testfall


*** Keywords ***
Setup
    Create Session    restfulapi    https://api.restful-api.dev
    Set Log Level    TRACE
