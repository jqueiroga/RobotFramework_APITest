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
        stage('Test'){
            steps{
                sh "chmod 700 ./suiteRun.sh"
                sh "./suiteRun.sh"
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
