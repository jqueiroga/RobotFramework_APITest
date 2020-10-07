*** Settings ***
Documentation         Documentation of API Invoice Tests Suites

Resource            ../resources/base.robot

Suite Setup           Conectar a bizSandboxAPI

Test Teardown


*** Test Cases ***
Validar API que retorna um resumo das faturas dos últimos 12 meses
    Login Sucess
    Retornar o idAccount pelo CPF "${CPF_USER}"
    Enviar requisição de consulta de informações da conta
    Enviar requisição para obter as faturas dos últimos 12 meses
    Conferir o status code    200 

Validar API que retorna informações de uma fatura por um período
    Login Sucess
    Retornar o idAccount pelo CPF "${CPF_USER}"
    Enviar requisição de consulta de informações da conta
    Enviar requisição para obter informações da faturas do período    202007
    Conferir o status code    200 