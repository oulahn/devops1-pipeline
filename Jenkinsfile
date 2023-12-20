pipeline {
    agent any

    environment {
        DOCKER_COMPOSE_FILE = '/API/devops/pipeline/docker-compose.yml'
        DOCKER_COMPOSE_TEST_FILE = '/API/devops/pipeline/docker-compose-test.yml'
    //    DOCKER_MACHINE_NAME = '18.181.184.53'
        TEST_PATH = '/API/devops/testapp'
    }
    


    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Run Docker Compose') {
            steps {
                script {
                    // Connect to the Docker machine on AWS
                    //sh "eval \$(docker-machine env ${DOCKER_MACHINE_NAME})"

                    // Run Docker Compose to start your application
                    sh "docker-compose -f ${DOCKER_COMPOSE_FILE} up -d"
                    sh "docker-compose -f ${DOCKER_COMPOSE_TEST_FILE} up -d"
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