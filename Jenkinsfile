pipeline {
    agent any

    parameters {
        string(name: 'dummy_static_website', defaultValue: 'latest', description: 'a tag for the dummy website')
    }

    stages {
        stage('Checkout') {
            steps {
                // Clone the Git repository containing the Dockerfile and application code
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image using the specified tag
                    def dockerImageTag = params.DOCKER_IMAGE_TAG
                    sh "docker build -t my-image:${dockerImageTag} ."
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Push the Docker image to Docker Hub (or another registry)
                    def dockerImageTag = params.DOCKER_IMAGE_TAG
                    withCredentials([
                    usernamePassword(
                        credentialsId: 'dockerhub-credentials',
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable: 'DOCKER_PASS'
                    )
                ])
                {
                        writeFile file: '.env', text: """
                DOCKER_USER=${DOCKER_USER}
                DOCKER_PASS=${DOCKER_PASS}
                """
                }
                        sh "echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin"
                        sh "docker push my-image:${dockerImageTag}"
                }
            }
        }
    }
}

    post {
        always {
            // Clean up workspace after the build
            cleanWs()
        }
    }
