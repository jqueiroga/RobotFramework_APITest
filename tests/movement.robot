*** Settings ***
Documentation         Documentation of API Movement Tests Suites

Resource            ../resources/base.robot

Suite Setup           Conectar a bizSandboxAPI

Test Teardown


*** Test Cases ***
Validar API que retorna um resumo das faturas dos últimos 12 meses
    Login Sucess
    Retornar o idAccount pelo CPF "${CPF_USER}"
    Enviar requisição de consulta de informações da conta
    Enviar requisição que retorna os detalhes da fatura no período    202007
    Conferir o status code    200 
