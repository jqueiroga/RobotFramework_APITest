*** Settings ***
Documentation         Documentation of API Tests Suites

Resource            ../resources/base.robot

Suite Setup           Conectar a bizSandboxAPI

Test Teardown


*** Test Cases ***
Loading Login Screen
    Validar o CPF "${CPF_USER}"
    Conferir o status code    200
    Carregar os UUIDs do Virtual Keyboard
    Conferir o status code    200

Realizar Login Com Sucesso
    Login Sucess
    Capturar Response e preencher Payload de Login

Validando Refresh Token
    Login Sucess
    Enviar requisição de Refresh Token
    Conferir o status code    200
    Capturar Response e preencher Payload de Login

Trocar senha por uma já utilizada
    Login Sucess
    Enviar requisição de troca de senha usando "${PASSWORD}" 
    Conferir o status code    400
    Conferir a mensagem de erro "Essa senha já foi usada, crie uma diferente"

Trocar senha do usuário com Sucesso
    Login Sucess
    Enviar requisição de troca de senha usando "123456" 
    Conferir o status code    200
    Atualizar dados de parametro com nova senha

Validando API de solicitação de permiti minha senha via SMS
    [tags]    wip
    Login Sucess
    Enviar requisição de esqueci minha senha via "sms"   
    Conferir o status code    200

Validando API de solicitação de permiti minha senha via Email
    [tags]    wip
    Login Sucess
    Enviar requisição de esqueci minha senha via "email"   
    Conferir o status code    200

Validando API de verificação que solicitação de minha senha já foi solicada para envio por SMS
    [tags]    wip
    Login Sucess
    Enviar requisição de esqueci minha senha via "sms"   
    Conferir o status code    200
    Enviar requisição de esqueci minha senha via "email"   
    Conferir o status code    400
    Verificar que já foi solicitado envio de token por "sms"
