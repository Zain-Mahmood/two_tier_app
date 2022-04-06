pipeline {
    agent any


    stages {
        stage('Cloning the project from Guthub'){
            steps {
                git branch: 'main',
                url: 'https://github.com/Zain-Mahmood/two_tier_app.git'
            }
    
        }
    
        stage('Building Docker image'){
            steps {
                script {
                    docker.build 'zmahmood/app.py'
                }
            }
        }

    }
}
