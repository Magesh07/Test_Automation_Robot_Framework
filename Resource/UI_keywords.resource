*** Settings ***
Library    SeleniumLibrary
Library    clipboard

*** Variables ***
${url}=     http://localhost:8080/
${buttonText_Xpath}=  //a[@href='dispense']
${dispenseText}=    //div[@class='container']/div
${ExpectedResult}=   Dispense Now
${ExpectedDispenseText}=    Cash dispensed
${dispenseNowButton_Xpath}=    xpath://a[text() = 'Dispense Now']
${uploadFile_XPath}=    xpath://*[@class='custom-file-input']
${singleRecordPath}=    ${EXECDIR}\\TestData\\SingleRecord.csv
${multipleRecordPath}=    ${EXECDIR}\\TestData\\MultipleRecord.csv
${filepath}=  ../TestData/MultipleRecord.csv

*** Keywords ***
set global variable  ${get_text}
Initialize browser
   open browser    ${url}      chrome
   maximize browser window
   sleep    3s
scroll to bottom
    execute javascript    window.scrollTo(0,document.body.scrollHeight)
     sleep    3s
click on file upload button
     Click Element At Coordinates     ${uploadFile_XPath}  0   15






