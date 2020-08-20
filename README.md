# Robot Framework in Docker, with API tests

## What is it?
This project consists of a Docker image containing a Robot Framework installation.

This installation also contains Requests library for Robot Framework. The test cases and reports should be mounted as volumes.

## Versioning
The versioning of this image follows the one of Robot Framework:

Major version matches the one of Robot Framework

Minor and patch versions are specific to this project (allows to update the versions of the other dependencies)

The versions used are:

Robot Framework 3.2.1

Robot Framework Requests 2.24.0

Robot Framework SeleniumLibrary 4.4.0

Robot Framework JsonLibrary 0.7.0


## Folder Structure
```
-./
-- resources
---  resources/keywords
     resources/payload
-- results
-- suiteExecution
-- tests
```

Resouces: Folder to put all files to help in tests execution

Resources/keywords: Folder to create robot files to archiving the keywords used in tests

Resources/payload: Folder to create robot files to archiving the payload used in tests

results: Folder that robotFramework will create the reports execution files.

suitExecution: Folder that will be all files to execution by docker.

tests: Folder thar will archiving all tests files.

## Pre-Condictions
You will have to install the Docker in your machine. Acess https://www.docker.com/products/docker-desktop to install the Docker

## Running the container
This container can be run using the following command:

docker run \
    -v <local path to the reports' folder>:/results:Z \
    -v <local path to the test suites' folder>:/apiTest/suiteExecution:Z \
    robotframewoek_apitest:latest
    
  ## Continuous integration  
  The pipeline stage can also rely on a Docker agent, as shown in the example below:
  
    pipeline{
    agent {
        docker {
            image 'robotframewoek_apitest:latest'
            args '--shm-size=1g -u root' 
        }
    }
    
    stages{
        stage('Build'){
            steps{
                echo "Building or resolve Dependencies"
            }
        }
        stage('API Test'){
            steps{
                sh "./suiteRun.sh"
            }
        }
     }
     }
