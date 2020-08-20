*** Settings ***
Documentation         All data to connect with API Biz Sandbox

Resource              ../dataMass/parameterData.robot
Resource              ../dataMass/userData.robot
Resource              API/authorizationKWS.robot

Library               RequestsLibrary
Library               Collections 
Library               String
Library               OperatingSystem
Library	              JSONLibrary
Library               DateTime


*** Variables ***
${URL_BASE_API}           https://sandbox-code.biz.com.br

