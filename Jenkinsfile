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
        stage('ResultsPublish'){
           
            steps{
                step([
                        $class : 'RobotPublisher',
                        outputPath : outputDirectory,
                        outputFileName : "/results/logs/*.xml",
                        disableArchiveOutput : false,
                        passThreshold : 100,
                        unstableThreshold: 95.0,
                        otherFiles : "/results/logs/*.png",
                    ])
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
