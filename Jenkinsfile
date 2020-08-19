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