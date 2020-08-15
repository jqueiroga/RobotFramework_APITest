*** Settings ***
Documentation                All user information to execute all Tests Suites 

*** Variables ***
#User variable response to ../authentication/Login
${CPF_USER}                97604451829
${PASSWORD}                123456
${ACCESS_TOKEN}            0
${USER_ID}                 0
#Account variable response to ../issuer/account/?document={{cpf}}
${ACCOUNT_ID}              account_id

&{VIRTUAL_KEYBOARD}        btn0=UUID_0
...                        btn1=UUID_1
...                        btn2=UUID_2
...                        btn3=UUID_3
...                        btn4=UUID_4
...                        btn5=UUID_5
...                        btn6=UUID_6
...                        btn7=UUID_7
...                        btn8=UUID_8
...                        btn9=UUID_9


&{PERSON}                  Id=personID
...                        Name=personName
...                        SocialName=personSocialName
...                        Phome=personPhone
...                        Cpf=personCPF
...                        Birthday=personBirthday
...                        DateCreated=personDateCreated
...                        DateChanged=personDateChanged
...                        IsActive=personIsActive


*** Keywords ***
