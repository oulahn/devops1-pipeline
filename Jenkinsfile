pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'oulahn-webapp-api:latest'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build and Push Docker Image') {
            steps {
                script {
                    // Build and push your Docker image
                    def dockerImage = docker.build(env.DOCKER_IMAGE)
                    docker.withRegistry('https://hub.docker.com', 'docker-credentials') {
                        dockerImage.push()
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Deploy your application using the Docker image
                    docker.withRegistry('https://registry.example.com', 'docker-credentials') {
                        docker.image(env.DOCKER_IMAGE).run('-p 8080:80 --name webapp-api')
                    }
                }
            }
        }
    }

    post {
        success {
            // Notify success (e.g., send an email)
            emailext attachLog: true, body: 'Build successful!', subject: 'Build Success', to: 'oula.hnaino@gmail.com'
        }
        failure {
            // Notify failure (e.g., send an email)
            emailext attachLog: true, body: 'Build failed. Check the Jenkins logs for details.', subject: 'Build Failure', to: 'oula.hnaino@gmail.com'
        }
    }
}
