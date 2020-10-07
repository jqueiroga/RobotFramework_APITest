*** Settings ***
Documentation                Document to include all keywords of Movement API executions.

Resource        ../resourceAPI.robot


*** Keywords ***
#Keywords to Validade the API to detail movement invoic by period ../i/issuer/movement/{{account_id}}/{period}
Enviar requisição que retorna os detalhes da fatura no período
    [Arguments]            ${period}
    #Get Summary Payload    
    ${movementPeriodPayload}        Get Payload               /movement/movementPeriod.json

    Set To Dictionary          ${movementPeriodPayload["Validate return code 200"]["headers"]}     Authorization                  Bearer ${ACCESS_TOKEN}

    #Get headers  by invoicePeriodP Payload and create body dictionary 
    ${headers}             Get Headers By Payload            ${movementPeriodPayload}

    #Send GetRequest
    ${response}            Get Request        bizSandboxAPI            issuer/movement/${ACCOUNT}/${period}            headers=${headers}
    Set Test Variable       ${response}

    Set To Dictionary      ${movementPeriodPayload["Validate return code 200"]}        response                    ${response.json()}
    Update JsonFile        /movement/movementPeriod.json        ${movementPeriodPayload} 
