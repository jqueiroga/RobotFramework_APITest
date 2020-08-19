pipeline{
    agent any
    
    stages{
        stage('Build'){
            steps{
                echo "Building or resolve Dependencies"
            }
        }
        stage('Test'){
            steps{
                echo "Running progression tests"
            }
        }
        stage('UAT'){
            steps{
                echo "Wait for User Acceptance"
                input(message: 'Go to production?', ok: 'Yes')
            }
        }
        stage('Prod'){
            steps{
                echo "WebApp is Ready :)"
            }
        }
    }
}