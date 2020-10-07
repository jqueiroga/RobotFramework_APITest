*** Settings ***
Documentation                Document to include all keywords of Authorization API executions.

Resource        ../resourceAPI.robot

*** Keywords ***
#Keyowrd to connect in API Biz Sandbox
Conectar a bizSandboxAPI
    Create Session        bizSandboxAPI        ${URL_BASE_API}

#####################################    AUTHORIZATION API KEYWORDS    #####################################    

#Keywords to Validate the user CPF  ../authentication/{{cpf}}/validate?partnerId=3351746b-0edd-457e-9ce0-7ff55e6d93d4&platformId=3351746b-0edd-457e-9ce0-7ff55e6d93d4&documenttypeid=1
Validar o CPF "${CPF_USER}"
    
    #Loading validate Payload file
    ${validatePayload}            Get Payload               /authentication/validateCPF.json
    
    #Get headers and body by login Payload
    ${headers}             Get Headers By Payload                  ${validatePayload}
    
    ${response}            Get Request        bizSandboxAPI        /authentication/${CPF_USER}/validate?partnerId=${PARTNER_ID}&platformId=${PLATFORM_ID}&documenttypeid=${DOCUMENTTYPEID}            headers=${headers}
    Set Test Variable      ${response}
    

    #Set parameter USER_ID if request return is 200
    ${USER_ID}             Set Variable                           ${response.json()["Id"]}
    Set Test Variable           ${USER_ID} 
  
#Keywords to Validate the Virtual Keyboard  ../authentication/${USER_ID}/keyboard
Carregar os UUIDs do Virtual Keyboard
    ${keyboardPayload}            Get Payload               /authentication/virtualKeyboard.json
    ${headers}             Get Headers By Payload                  ${keyboardPayload}    
    
    ${response}            Get Request        bizSandboxAPI        /authentication/${USER_ID}/keyboard            headers=${headers}
    Set Test Variable      ${response}

    #Update header of virtualKeyboard payload file
    Set To Dictionary            ${keyboardPayload["Validate return code 200"]}        response        ${response.json()}
    
    #Fill virtuaKeyboard dictionary of parameterData file.
    Fill Dictionary of virtual Keyboard      

Capturar Response e preencher Payload de Login
    Update JsonFile        /authentication/login.json        ${loginPayload}    


#Conferences of response  
Conferir o status code
    [Arguments]            ${statusCode_response}
    Should Be Equal as Strings        ${response.status_code}        ${statusCode_response}

Conferir a mensagem de erro "${msgExpected}"
    ${msgString}        Convert To String            ${response.json()[0]["Message"]} 
    Should Be Equal as Strings       ${msgString}       ${msgExpected}



#Keywords to Validade the Login API ../authentication/Login
Enviar requisição de Login do usuário
    #Loading login Payload file
    ${loginPayload}            Get Payload               /authentication/login.json

    #Get headers and body by login Payload
    ${headers}             Get Headers By Payload                  ${loginPayload}
    ${body}                Get Body By Payload                     ${loginPayload}

    ##Fill body with Userdata 
    Set To Dictionary           ${body}                 password            ${PASSWORD}
    Set To Dictionary           ${body}                 partnerID           ${PARTNER_ID}
    Set To Dictionary           ${body}                 document            ${CPF_USER}
    Set To Dictionary           ${body}                 platformID          ${PLATFORM_ID}

    #Update the loginPayload with Body Informations
    Set To Dictionary            ${loginPayload["Validate return code 200"]}        body        ${body}

    ${response}            Post Request        bizSandboxAPI        /authentication/Login            data=${body}            headers=${headers}
    Set Test Variable       ${response}
       
    #Update the loginPayload with Response Informations
    Conferir o status code    200
    Set To Dictionary            ${loginPayload["Validate return code 200"]}        response        ${response.json()}
        
    ${ACCESS_TOKEN}        Set Variable        ${loginPayload["Validate return code 200"]["response"]["access_token"]}

    Set Test Variable    ${ACCESS_TOKEN}
    Set Global Variable     ${loginPayload}   

#Keywords to Validade the Login API ../authentication/refreshToken
Enviar requisição de Refresh Token
    ${token}        Set Variable        ${loginPayload["Validate return code 200"]["response"]["refresh_token"]}

    #Get headers  by login Payload and create body dictionary 
    ${headers}             Get Headers By Payload                  ${loginPayload}
    ${body}                Create Dictionary                      token=${token} 

    ${response}            Post Request        bizSandboxAPI        /authentication/refreshToken      data=${body}            headers=${headers}
    Conferir o status code    200

    Set Test Variable       ${response}
       
#Keywords to Validade the Login API ../authentication/changePassword
Enviar requisição de troca de senha usando "${newPassword}" 
#Loading login Payload file
    ${chagePWDPayload}            Get Payload               /authentication/chancePassword.json
    
    Set To Dictionary            ${chagePWDPayload["Validate return code 200"]["body"]}        newPassword                    ${newPassword}
    Set To Dictionary            ${chagePWDPayload["Validate return code 200"]["body"]}        newPasswordConfirmation        ${newPassword}
    Set To Dictionary            ${chagePWDPayload["Validate return code 200"]["headers"]}      Authorization                 Bearer ${ACCESS_TOKEN}

    #Get headers and body by login Payload
    ${headers}             Get Headers By Payload                  ${chagePWDPayload}
    ${body}                Get Body By Payload                     ${chagePWDPayload}

    ${response}            Put Request        bizSandboxAPI        /authentication/changePassword      data=${body}            headers=${headers}
    Conferir o status code    200
    Set Test Variable       ${response}

#Keywords to Validade the Login API ../authentication/forgotPassword
Enviar requisição de esqueci minha senha via "${type}"
    ${forgotPasswordPayload}            Get Payload               /authentication/forgotPassword.json
    
    Set To Dictionary           ${forgotPasswordPayload["Validate return code 200"]["headers"]}             Authorization       Bearer ${ACCESS_TOKEN}
    Set To Dictionary           ${forgotPasswordPayload["Validate return code 200"]["body"]}                type                ${type}
    Set To Dictionary           ${forgotPasswordPayload["Validate return code 200"]["body"]}                partnerId           ${PARTNER_ID}
    Set To Dictionary           ${forgotPasswordPayload["Validate return code 200"]["body"]}                document            ${CPF_USER}
    Set To Dictionary           ${forgotPasswordPayload["Validate return code 200"]["body"]}                platformId          ${PLATFORM_ID}
    
    #Get headers  by login Payload and create body dictionary 
    ${headers}             Get Headers By Payload                  ${forgotPasswordPayload}
    ${body}                Get Body By Payload                     ${forgotPasswordPayload}

     ${response}            Post Request        bizSandboxAPI        /authentication/forgotPassword      data=${body}            headers=${headers}
    Set Test Variable       ${response}

    Set To Dictionary      ${forgotPasswordPayload["Validate return code 200"]}        response                    ${response.json()}
    Update JsonFile        /authentication/forgotPassword.json        ${forgotPasswordPayload} 

Verificar que já foi solicitado envio de token por "${type}"
    ${validation}=      Set Variable        Validate return code 400 by ${type}
   
    @{reponseList}   Get From Dictionary   ${forgotPasswordPayload["Validate return code 400 by ${type}"]}    response
    FOR  ${responseIndex}   IN   @{reponseList}
        Log To Console  Cada Index do Response Corresponde há: ${responseIndex}
    END
    
Atualizar dados de parametro com nova senha
    ${PASSWORD}=            Set Variable           ${chagePWDPayload["Validate return code 200"]["body"]["newPassword"]}


#Fill Virtual Keyboard Dictionary by use
Fill Dictionary of virtual Keyboard
    FOR    ${index}        IN RANGE    ${10}
        #Convert index in String
        ${indexString}        Convert To String    ${index}
        
        Fill each Dictionary about number element    ${indexString}
    END

Fill each Dictionary about number element 
    [Arguments]  ${number}
    FOR    ${virtualkey}    IN         @{response.json()}
        ${condicao}           Run Keyword and Return Status        Should Contain     ${virtualkey['Label']}      ${number}
        Run Keyword if        ${condicao}         Set To Dictionary    ${VIRTUAL_KEYBOARD}        btn${number}        ${virtualkey['Value']}               
    END

