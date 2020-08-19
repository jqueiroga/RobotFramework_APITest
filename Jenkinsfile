pipeline{
    agent {
        docker {
            image 'ppodgorsek/robot-framework:latest'
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
                sh "docker-compose up"
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