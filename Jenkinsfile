pipeline {
    agent any

    environment {
        DOCKER_COMPOSE_FILE = '/API/devops/pipeline/docker-compose.yml'
        DOCKER_COMPOSE_TEST_FILE = '/API/devops/pipeline/docker-compose-test.yml'
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
                    // Run Docker Compose to start your application
                    sh "docker-compose -f ${DOCKER_COMPOSE_FILE} up -d"
                    sh "docker-compose -f ${DOCKER_COMPOSE_TEST_FILE} up -d"
                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    // Navigate to the test application directory
                    dir(TEST_PATH) {
                        // Assuming npm is used for Node.js tests
                        sh 'npm install'
                        sh 'npm test'
                    }
                }
            }
        }

        stage('Merge Branch') {
            when {
                expression { currentBuild.resultIsBetterOrEqualTo('SUCCESS') }
            }
            steps {
                script {
                    // If the result is successful, merge the branch
                    echo 'Tests passed! Merging branches.'
                    // Replace 'your-branch-to-merge' with the actual branch name
                    sh 'git merge your-branch-to-merge'
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
