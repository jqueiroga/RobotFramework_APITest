*** Settings ***
Documentation                Main card information to execute all Tests Suites 

*** Variables ***
#Main Card variables response to ../issuer/card/{{account_id}}?statusId=7&documentTypeId=1&document={{cpf}}
${CARD_ID}                 cardId
${CARD_NUMBER_MASK}        numberCardWithMask
${CARD_NAME}               nameOnCard
${STATUS}                  statusCard
 


*** Keywords ***
