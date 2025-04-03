pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                echo 'Cloning repository...'
                checkout scm
                sh 'ls -l'  // List contents to verify checkout
            }
        }

        stage('Setup Node.js') {
            steps {
                sh 'node -v'
                sh 'npm -v'
            }
        }

        stage('Install Server Dependencies') {
            steps {
                dir('server') { // Navigate to server directory
                    sh 'npm install'
                }
            }
        }

        stage('Install Client Dependencies') {
            steps {
                dir('client') { // Navigate to client directory
                    sh 'npm install'
                }
            }
        }

        stage('Build Client') {
            steps {
                dir('client') {
                    sh 'npm run build'
                }
            }
        }

        stage('Start Server') {
            steps {
                dir('server') {
                    sh 'node app.js &'
                }
            }
        }

        stage('Build and Push Docker Image') {
            steps {
                sh './build.sh'
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh './deploy.sh'
            }
        }
    }

    post {
        always {
            echo 'Pipeline execution finished'
        }
        failure {
            echo 'Pipeline failed. Check logs!'
        }
    }
}

