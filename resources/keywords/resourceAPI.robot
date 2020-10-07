*** Settings ***
Documentation         All data to connect with API Biz Sandbox

Resource              ../dataMass/parameterData.robot
Resource              ../dataMass/userData.robot
Resource              API/authorizationKWS.robot
Resource              API/accountKWS.robot
Resource              API/invoiceKWS.robot
Resource              API/movementKWS.robot

Library               RequestsLibrary
Library               Collections 
Library               String
Library               OperatingSystem
Library	              JSONLibrary
Library               DateTime


*** Variables ***
${URL_BASE_API}           https://sandbox-code.biz.com.br

*** Keywords ***
#####################################    UTIL GENERIC KEYWORDS    #####################################  
#Return a headers dictionary by a payload
Get Headers By Payload
    [Arguments]        ${payloadFile}

    ${my_Headers}      Set Variable         ${payloadFile["Validate return code 200"]["headers"]}
    [Return]           ${my_Headers}

#Return a bady dictionary by a payload
Get Body By Payload
    [Arguments]        ${payloadFile}

    ${my_Body}         Set Variable        ${payloadFile["Validate return code 200"]["body"]}
    [Return]           ${my_Body}

#Create a new payload object
Get Payload
    [Arguments]                  ${jsonFile}
    ${payloadFile}               Get File            ${EXECDIR}/resources/payload/${jsonFile}
    ${newPayload}                To Json             ${payloadFile}

    [Return]     ${newPayload}  

#Update the body dictionary from a payload
Update JsonFile
    [Arguments]        ${jsonFile}            ${newFile}
    ${stringFile}        Convert JSON To String                        ${newFile}
    Create File          ${EXECDIR}/resources/payload/${jsonFile}      ${stringFile}

