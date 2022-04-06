pipeline {
    agent any

    environment {
        IMAGE_NAME = "zainmahmood/app.py:" + "$BUILD_NUMBER"
    }


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
                    DOCKER_IMAGE = docker.build 'zainmahmood/app.py'
        

                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('', 'docker_hub_cred') {
                        DOCKER_IMAGE.push()
                    }
                }
            }
        }
    }
}
