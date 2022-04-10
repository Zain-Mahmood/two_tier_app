pipeline {
    agent any

    environment {
        IMAGE_NAME = "zainmahmood/group4:" + "$BUILD_NUMBER"
        DOCKER_CREDENTIALS = 'docker_hub_cred'
    }


    stages {
        stage('Cloning the project from Guthub'){
            steps {
                checkout(
                    [
                        $class: 'GitSCM', 
                        branches: [[name: '*/main']],
                        userRemoteConfigs: [[url: 'git@github.com:zain-mahmood/two_tier_app.git',
                        credentialsId: 'ssh_git_cred']]
                    ]
                        
                )
            }
        }
    
        stage('Building Docker image'){
            steps {
                script {
                    DOCKER_IMAGE = docker.build IMAGE_NAME

                }
            }
        }

        // stage('Testing the code'){
        //     steps {
        //         script {
        //             sh '''
        //                 docker run --rm -v $PWD/ $IMAGE_NAME pytest

        //             '''
        //         }
        //     }
        // }

        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('', DOCKER_CREDENTIALS) {
                        DOCKER_IMAGE.push()
                    }
                }
            }
        }

        stage('Removing the docker image') {
            steps {
                sh "docker rmi $IMAGE_NAME"
            }
        }

    }
}


