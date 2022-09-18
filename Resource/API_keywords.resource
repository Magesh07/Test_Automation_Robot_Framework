*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    OperatingSystem
Library    JSONLibrary

*** Variables ***
${baseURI}=    http://localhost:8080/
${multipleRecord_contextPath}=  calculator/insertMultiple
${path1}=   ../Resource Files/resource.txt
${JSONFilePath}=  C:\\Users\\MageshKumar\\PycharmProjects\\pythonProject\\Test1\\TestData\\
${response}

*** Keywords ***
#AC2
TC4_AC2_Pass_Log
    log to console    ....AC2 - The nat id only contains $ from 5th digit Test Pass   ....  >>
TC4_AC2_Fail_Log
    Run Keyword And Continue On Failure     Fail    <...AC2-The nat id does not contains $ from 5th digit Test case Failed...>
#AC3,4,5,6
TC4_AC3_Pass_Log
    log to console  .... AC3,AC4 & AC5 - Tax Relief calculation Test Pass ....  >>
TC4_AC3_Fail_Log
    Run Keyword And Continue On Failure     Fail     <...AC3,AC4 & AC5 -Tax Relief calculation Test case Failed...>
#AC6
TC4_AC6_Pass_Log
    log to console  ..... AC6 Final Tax Relief with 2 digit round off ....Test Pass >>
TC4_AC6_Fail_Log
    Run Keyword And Continue On Failure     Fail  <...AC6 - Final Tax Relief with 2 digit round off Test case Failed...>