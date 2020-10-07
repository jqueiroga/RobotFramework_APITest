***Settings***
Documentation       Basic strucute of project. 


#Declate all Resources
Resource                 keywords/resourceAPI.robot


*** Keywords ***
Login Sucess
    Validar o CPF "${CPF_USER}"
    Conferir o status code    200
    Enviar requisição de Login do usuário
    Conferir o status code    200
