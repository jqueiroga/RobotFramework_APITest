pipeline{
    agent none
    
    stages{
        stage('Build'){
            steps{
                echo "Building or resolve Dependencies"
            }
        }
        stage('APITest'){
            agent any
            
            steps{               
                sh ''' #!/bin/bash
                docker container rm apirobot_docker | true
                docker-compose up
                '''            
            }
        }
        stage('UAT'){
            steps{
                echo "Wait for User Acceptance"
            }
        }
        stage('Prod'){
            steps{
                echo "WebApp is Ready :)"
            }
        }
    }
}
