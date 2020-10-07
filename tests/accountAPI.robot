*** Settings ***
Documentation         Documentation of API Account Tests Suites

Resource            ../resources/base.robot

Suite Setup           Conectar a bizSandboxAPI

Test Teardown


*** Test Cases ***
Validar API que retornar a DateTime corrente
    Login Sucess
    Enviar requisição de currentTime
    Conferir o status code    200 

Validar API que retornar a conta de um Portador
    Login Sucess
    Retornar o idAccount pelo CPF "${CPF_USER}"
    Conferir o status code    200 

Validar API que informações da conta do usuário logado
    Login Sucess
    Retornar o idAccount pelo CPF "${CPF_USER}"
    Enviar requisição de consulta de informações da conta
    Conferir o status code    200 

#Validar API que retorna dados da Fatura Atual do usuário logado


Validar API que retorna a timeline das últimas compras realizada pelo usuário logado
    Login Sucess
    Retornar o idAccount pelo CPF "${CPF_USER}"
    Enviar requisição de consulta de informações da conta
    Enviar requisição para obter retorno da timeline das últimas compras
    Conferir o status code    200 
