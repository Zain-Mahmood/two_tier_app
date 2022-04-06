pipeline {
    agent any

    environment {
        IMAGE_NAME = "zainmahmood/app.py:" + "$BUILD_NUMBER"
        DOCKER_CREDENTIALS = 'docker_hub_cred'
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
                    DOCKER_IMAGE = docker.build IMAGE_NAME
        

                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('', DOCKER_CREDENTIALS) {
                        DOCKER_IMAGE.push()
                    }
                }
            }
        }
    }
}
