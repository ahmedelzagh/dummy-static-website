pipeline {
    agent any

    parameters {
        string(name: 'DOCKER_IMAGE_TAG', defaultValue: 'latest', description: 'Tag for the Docker image')
    }

    stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM',
                    userRemoteConfigs: [[url: 'https://github.com/ahmedelzagh/dummy-static-website']],
                    branches: [[name: '*/master']]
                ])
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    def dockerImageTag = params.DOCKER_IMAGE_TAG
                    sh "docker build -t my-image:${dockerImageTag} ."
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    def dockerImageTag = params.DOCKER_IMAGE_TAG
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials',
                            usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        sh "echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin"
                        sh "docker tag my-image:${dockerImageTag} $DOCKER_USER/my-image:${dockerImageTag}"
                        sh "docker push $DOCKER_USER/my-image:${dockerImageTag}"
                    }
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
