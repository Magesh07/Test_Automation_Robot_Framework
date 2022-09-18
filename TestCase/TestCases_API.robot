*** Settings ***
Documentation    Automate the API related Usecases as part of this project.
Resource   ../Resource/API_keywords.resource
Library    ../commonUtils/OppenheimerAPIWrapper.py

*** Test Cases ***
UC1_TC1:Insert SINGLE Class Hero Record - response code 202
    RequestsLibrary.Create Session    mysession     ${baseURI}
    ${jsonBody}  Get Binary File  ${JSONFilePath}UC1_Test_Data.json
    ${header}=  create dictionary    Content-Type=application/json
    ${response}=   POST On Session    mysession     calculator/insert        data=${jsonBody}        headers=${header}  expected_status=202
      #VALIDATIONS
    ${status_Code}=     convert to string      ${response.status_code}
    Should Be Equal    ${status_code}    202
UC1_TC2:Insert SINGLE Class Hero Record - response code 404
    RequestsLibrary.Create Session    mysession     ${baseURI}
    ${jsonBody}  Get Binary File  ${JSONFilePath}UC1_Test_Data.json
    ${header}=  create dictionary    Content-Type=application/json
    ${response}=   POST On Session    mysession     calculator/insert1       data=${jsonBody}        headers=${header}    expected_status=404
      #VALIDATIONS
    ${status_Code}=     convert to string      ${response.status_code}
    Should Be Equal    ${status_code}    404
UC1_TC3:Insert SINGLE Class Hero Record - response code 500
    RequestsLibrary.Create Session    mysession     ${baseURI}
    ${jsonBody}  Get Binary File  ${JSONFilePath}UC1_TC3_Test_Data.json
    ${header}=  create dictionary    Content-Type=application/json
    ${response}=   post on session    mysession     calculator/insert      data=${jsonBody}        headers=${header}  expected_status=500
      #VALIDATIONS
    ${status_Code}=     convert to string      ${response.status_code}
    Should Be Equal    ${status_code}    500
UC2_TC1:Insert Multiple Class Hero Record - response code 202
    RequestsLibrary.Create Session    mysession     ${baseURI}
    ${jsonBody}  Get Binary File  ${JSONFilePath}UC2_Test_Data.json
    ${header}=  create dictionary    Content-Type=application/json
    ${response}=   POST On Session    mysession     ${multipleRecord_contextPath}       data=${jsonBody}        headers=${header}
     #VALIDATIONS
    ${status_Code}=     convert to string      ${response.status_code}
    Should Be Equal    ${status_code}    202
UC2_TC2:Insert Multiple Class Hero Record - response code 404
    RequestsLibrary.Create Session    mysession     ${baseURI}
    ${jsonBody}  Get Binary File  ${JSONFilePath}UC2_Test_Data.json
    ${header}=  create dictionary    Content-Type=application/json
    ${response}=   post on session    mysession     calculator/insertMultiple1      data=${jsonBody}        headers=${header}    expected_status=404
     #VALIDATIONS
    ${status_Code}=     convert to string      ${response.status_code}
    Should Be Equal    ${status_code}    404
UC2_TC3:Insert Multiple Class Hero Record - response code 500
    RequestsLibrary.Create Session    mysession     ${baseURI}
    ${jsonBody}  Get Binary File  ${JSONFilePath}UC2_TC3_Test_Data.json
    ${header}=  create dictionary    Content-Type=application/json
    ${response}=   post on session    mysession     ${multipleRecord_contextPath}     data=${jsonBody}        headers=${header}  expected_status=500
     #VALIDATIONS
    ${status_Code}=     convert to string      ${response.status_code}
    Should Be Equal    ${status_code}    500
UC4_TC1:Bookkeeping Manager verification
    RequestsLibrary.Create Session    mysession     ${baseURI}
    ${response}=   GET On Session   mysession   calculator/taxRelief
    FOR  ${i}  IN  @{response.json()}
        ${natid_str}=   set variable    ${i["natid"]}
        ${name_str}=    set variable   ${i["name"]}
        ${reflief_str}=  set variable  ${i["relief"]}
#       ${gender_str}=    ${i["gender"]}
        ${gender_str}=  set variable    M
#       ${salary_str}=    ${i["salary"]}
        ${salary_str}=  set variable   700.00
#       ${birthday_str}=    ${i["birthday"]}
        ${birthday_str}=  set variable    07/07/1994
#       ${tax_str}=    ${i["tax"]}
        ${tax_str}=  set variable    650.00    #20.00
        log to console    "-------------------------  Test Case AC2 to AC6------------------------------ "
        log to console    /********* AC 2 verify natid masking ****************/
        ${actual_result}=   OppenheimerAPIWrapper.check_mask    ${natid_str}
         run keyword if  ${actual_result} == True   TC4_AC2_Pass_Log
         ...    ELSE    TC4_AC2_Fail_Log
        log to console    /********* AC3, AC4 and AC5 CalculatedTaxRelief ****************/
        ${taxRelief}=   OppenheimerAPIWrapper.verify_calculated_tax_relief    ${salary_str}    ${tax_str}     ${birthday_str}      ${gender_str}   ${reflief_str}
         run keyword if  ${taxRelief} == True   TC4_AC3_Pass_Log
         ...    ELSE    TC4_AC3_Fail_Log
         log to console     /********* AC 6 2 digit round round off value ****************/
         ${actual_result}=  OppenheimerAPIWrapper.verify_tax_relief_amt_two_decimal_point     ${reflief_str}
         run keyword if  ${actual_result} == True   TC4_AC6_Pass_Log
         ...    ELSE    TC4_AC6_Fail_Log
    END