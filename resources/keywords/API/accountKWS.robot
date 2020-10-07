*** Settings ***
Documentation                Document to include all keywords of Account API executions.

Resource        ../resourceAPI.robot


*** Keywords ***
#Keywords to Validade the Login API ../authentication/CurrentTime
Enviar requisição de currentTime
    #Get CurrentTime Payload    
    ${currentTimePayload}        Get Payload               /account/currentDateTime.json

    Set To Dictionary          ${currentTimePayload["Validate return code 200"]["headers"]}     Authorization                  Bearer ${ACCESS_TOKEN}

    #Get headers  by CurrentTime Payload and create body dictionary 
    ${headers}             Get Headers By Payload                  ${currentTimePayload}
    
    ${response}            Get Request        bizSandboxAPI        /authentication/CurrentTime            headers=${headers}
    Set Test Variable       ${response}

    Set To Dictionary      ${currentTimePayload["Validate return code 200"]}        response                    ${response.json()}
    Update JsonFile        /account/currentDateTime.json        ${currentTimePayload} 
    
#Keywords to retorn the account by CPF  ../issuer/account?document={{cpf}}&ProductId=84&documentTypeId=1
Retornar o idAccount pelo CPF "${CPF_USER}"
    #Loading accountId Payload file
    ${accountIdPayload}            Get Payload               /account/accountId.json

    #Get headers and body by login Payload
    ${headers}             Get Headers By Payload                  ${accountIdPayload}
    
    #Fill headers with Userdata 
    Set To Dictionary           ${headers}                 Authorization           Bearer ${ACCESS_TOKEN}
   
    #Send GetRequest to capture the accountId by user's CPF
    ${response}            Get Request        bizSandboxAPI        /issuer/account?document=${CPF_USER}&documentTypeId=1            headers=${headers}
    Set Test Variable      ${response}
    
    #Insert in AccountIdPayload the Request's reponse
    Set To Dictionary      ${accountIdPayload["Validate return code 200"]}        response                    ${response.json()}
    Update JsonFile        /account/accountId.json        ${accountIdPayload} 

    #Set parameter ACCOUNT_ID if request return is 200
    ${ACCOUNT}               Set Variable                           ${accountIdPayload["Validate return code 200"]["response"]["Content"][0]["AccountId"]}
    Set Global Variable           ${ACCOUNT} 
    
    
#Keywords to Validade the account Information API ../issuer/account/{accountId}
Enviar requisição de consulta de informações da conta
    #Get CurrentTime Payload    
    ${accountPayload}        Get Payload               /account/account.json

    Set To Dictionary          ${accountPayload["Validate return code 200"]["headers"]}     Authorization                  Bearer ${ACCESS_TOKEN}

    #Get headers  by CurrentTime Payload and create body dictionary 
    ${headers}             Get Headers By Payload                  ${accountPayload}

    
    ${response}            Get Request        bizSandboxAPI        /issuer/account/${ACCOUNT}            headers=${headers}
    Set Test Variable       ${response}

    Set To Dictionary      ${accountPayload["Validate return code 200"]}        response                    ${response.json()}
    Update JsonFile        /account/account.json        ${accountPayload} 



#Keywords to Validade the Timeline API ../issuer/account/${ACCOUNT}/TimeLine?elements=${elements}&page=${page}&responseCode=${responseCode}&orderDesc=${orderDesc}
Enviar requisição para obter retorno da timeline das últimas compras
    #Get Timeline Payload    
    ${timeLinePayload}        Get Payload               /account/timeline.json

    Set To Dictionary          ${timeLinePayload["Validate return code 200"]["headers"]}     Authorization                  Bearer ${ACCESS_TOKEN}

    #Get headers  by Timeline Payload and create body dictionary 
    ${headers}             Get Headers By Payload                  ${timeLinePayload}

    #Set parameters Variables to fill request
    ${elements}=             Set Variable        ${timeLinePayload["Validate return code 200"]["parametro"]["elements"]} 
    ${page}=                 Set Variable        ${timeLinePayload["Validate return code 200"]["parametro"]["page"]} 
    ${responseCode}=         Set Variable        ${timeLinePayload["Validate return code 200"]["parametro"]["responseCode"]} 
    ${orderDesc}=            Set Variable        ${timeLinePayload["Validate return code 200"]["parametro"]["orderDesc"]} 

    #Send GetRequest
    ${response}            Get Request        bizSandboxAPI        issuer/account/${ACCOUNT}/TimeLine?elements=${elements}&page=${page}&responseCode=${responseCode}&orderDesc=${orderDesc}            headers=${headers}
    Set Test Variable       ${response}

    Set To Dictionary      ${timeLinePayload["Validate return code 200"]}        response                    ${response.json()}
    Update JsonFile        /account/account.json        ${timeLinePayload} 
