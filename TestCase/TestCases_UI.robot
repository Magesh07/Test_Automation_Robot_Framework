*** Settings ***
Documentation    Automate the UI related Usecases as part of this project.
#Library    RPA.Desktop.Clipboard
#Library    PyAutoGUI
Resource  ../Resource/UI_keywords.resource
Library    ../commonUtils/fileupload.py
Library    os

*** Test Cases ***
    #(5) As the Governor, I should be able to see a button on the screen so
    #that I can dispense tax relief for my working class heroes
TC1:Verify that DISPENSE NOW button on the screen is in RED-COLORED
      Initialize browser
      scroll to bottom
      wait until element is visible    ${buttonText_Xpath}
      wait until element is enabled    ${buttonText_Xpath}
      ${css}=         Get WebElement    ${dispenseNowButton_Xpath}
      ${prop_val}=    Call Method       ${css}    value_of_css_property   background-color
      ${redColor1}=  Convert To String     rgba(220, 53, 69, 1)
      ${redColor2}=  Convert To String     rgba(200, 35, 51, 1)
      ${rgbvalue}=  Catenate  ${redColor1}  ${redColor2}
      should contain    ${rgbvalue}     ${prop_val}  msg=expected rgbvalue does not match with actual rgbvalue
TC2:Verify that button text on the screen must be exactly "Dispense Now"
      wait until element is visible    ${buttonText_Xpath}
      wait until element is enabled    ${buttonText_Xpath}
      ${get_text}=     Get Text  ${buttonText_Xpath}
      Capture Page Screenshot
      should be equal as strings    ${get_text}   ${ExpectedResult}
TC3:Verify that Cash dispensed message is getting displayed once governer clicked the dispense now button
      wait until element is enabled    ${buttonText_Xpath}
      click element    ${buttonText_Xpath}
      wait until element is visible    ${dispenseText}
      wait until element is enabled    ${dispenseText}
      ${get_text}=     Get Text  ${dispenseText}
      Capture Page Screenshot
      should be equal as strings    ${get_text}   ${ExpectedDispenseText}
      log to console  Hello, console!  ${get_text}
      #(3) As the Clerk, I should be able to upload a csv file to a portal so
       #that I can populate the database from a UI
TC4: Verify that clerk user is able to insert the SINGLE record into database via GUI using CSV file.
      Go To   ${url}
      wait until element is enabled   ${uploadFile_XPath}
      click on file upload button
      Capture Page Screenshot
      fileupload.clipboard    ${singleRecordPath}
TC5: Verify that clerk user is able to insert the MULTPLE record into database via GUI using CSV file.
      wait until element is enabled   ${uploadFile_XPath}
      click on file upload button
      Capture Page Screenshot
      fileupload.clipboard    ${multipleRecordPath}
      close browser
