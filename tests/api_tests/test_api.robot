*** Settings ***
Library         RequestsLibrary
Library         Collections
Library         OperatingSystem
Library         JSONLibrary

Suite Setup     Setup


*** Variables ***
${BODY_FILE}=           ${CURDIR}/../../resources/api/payload/addObject_2.json
${BODY_FILE_2}=         ${CURDIR}/../../resources/api/payload/addObject_2_update.json
${BODY_FILE_PATCH}=     ${CURDIR}/../../resources/api/payload/addObject_2_patch.json
${id}=                  3
${id_wf}=               ${EMPTY}


*** Test Cases ***
Get_List_Of_All_Objects
    ${response}=    GET On Session    restfulapi    /objects
    Status Should Be    expected_status=200
    Log To Console    ${response.json()}

List_of_objects_by_ids
    ${response}=    GET On Session    restfulapi    /objects    params=id=3&id=5&id=10
    Status Should Be    expected_status=200
    Log To Console    ${response.json()}
    Request Should Be Successful    response=${response}

Single_object
    ${response}=    GET On Session    restfulapi    /objects/${id}
    Status Should Be    expected_status=200
    Log To Console    ${response.json()}
    Dictionary Should Contain Item    ${response.json()}    key=id    value=3

Add_object
    ${body}=    Load Json From File    ${BODY_FILE}

    ${response}=    POST On Session    restfulapi    /objects    json=${body}
    Status Should Be    expected_status=200
    Log To Console    ${response.json()}
    Should Be Equal    ${response.json()}[name]    Test post operation

Single_added_object
    ${response}=    GET On Session    restfulapi    /objects/ff80818196f2a23f019773b36c4411e5
    Status Should Be    expected_status=200
    Log To Console    ${response.json()}
    Dictionary Should Contain Item    ${response.json()}    key=id    value=ff80818196f2a23f019773b36c4411e5

Update_object
    ${body}=    Load Json From File    ${BODY_FILE_2}

    ${response}=    PUT On Session    restfulapi    /objects/ff80818196f2a23f019773b36c4411e5    json=${body}
    Status Should Be    expected_status=200
    Log To Console    ${response.json()}
    Dictionary Should Contain Item    ${response.json()}    key=id    value=ff80818196f2a23f019773b36c4411e5
    Dictionary Should Contain Item    ${response.json()}    key=name    value=Test post operation2

Single_added_object_2
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

Partially_update_object
    ${body}=    Load Json From File    ${BODY_FILE_PATCH}

    ${response}=    PATCH On Session    restfulapi    /objects/ff80818196f2a23f019773b36c4411e5    json=${body}
    Status Should Be    expected_status=200
    Log To Console    ${response.json()}
    Dictionary Should Contain Item    ${response.json()}    key=id    value=ff80818196f2a23f019773b36c4411e5
    Dictionary Should Contain Item
    ...    ${response.json()}
    ...    key=name
    ...    value=Test post operation2 (PAtch update test operation)

Delete_object
    ${response}=    DELETE On Session    restfulapi    /objects/${id_wf}
    Status Should Be    expected_status=200

# Post, Put, Delete Workflow Testfall


*** Keywords ***
Setup
    Create Session    restfulapi    https://api.restful-api.dev
    Set Log Level    TRACE
