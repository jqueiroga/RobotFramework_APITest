*** Settings ***
Documentation                Document to include all keywords of Invoice API executions.

Resource        ../resourceAPI.robot


*** Keywords ***
#Keywords to Validade the summary  API ../issuer/invoice/{{account_id}}/summary
Enviar requisição para obter as faturas dos últimos 12 meses
    #Get Summary Payload    
    ${summaryPayload}        Get Payload               /invoice/summary.json

    Set To Dictionary          ${summaryPayload["Validate return code 200"]["headers"]}     Authorization                  Bearer ${ACCESS_TOKEN}

    #Get headers  by summary Payload and create body dictionary 
    ${headers}             Get Headers By Payload            ${summaryPayload}

    #Send GetRequest
    ${response}            Get Request        bizSandboxAPI            issuer/invoice/${ACCOUNT}/summary            headers=${headers}
    Set Test Variable       ${response}

    Set To Dictionary      ${summaryPayload["Validate return code 200"]}        response                    ${response.json()}
    Update JsonFile        /invoice/summary.json        ${summaryPayload} 


#Keywords to Validade the invoice by period API ../issuer/invoice/{accountId}/{period}
Enviar requisição para obter informações da faturas do período
    [Arguments]            ${period}
    #Get Summary Payload    
    ${invoicePeriodPayload}        Get Payload               /invoice/invoicePeriod.json

    Set To Dictionary          ${invoicePeriodPayload["Validate return code 200"]["headers"]}     Authorization                  Bearer ${ACCESS_TOKEN}

    #Get headers  by invoicePeriodP Payload and create body dictionary 
    ${headers}             Get Headers By Payload            ${invoicePeriodPayload}

    #Send GetRequest
    ${response}            Get Request        bizSandboxAPI            issuer/invoice/${ACCOUNT}/${period}            headers=${headers}
    Set Test Variable       ${response}

    Set To Dictionary      ${invoicePeriodPayload["Validate return code 200"]}        response                    ${response.json()}
    Update JsonFile        /invoice/invoicePeriod.json        ${invoicePeriodPayload} 
