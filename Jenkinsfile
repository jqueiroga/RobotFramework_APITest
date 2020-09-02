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
            agent any
            
            steps {
                    echo 'Testing...'
                    script {
                      step(
                        [
                          $class                    : 'RobotPublisher',
                          outputPath                : "./results/",
                          outputFileName            : "*.xml",
                          reportFileName            : "report.html",
                          logFileName               : "log.html",
                          disableArchiveOutput      : false,
                          passThreshold             : 100,
                          unstableThreshold         : 95.0,
                          otherFiles                : "*.png"
                        ]
                      )
                    }  
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
