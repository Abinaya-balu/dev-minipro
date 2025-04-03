pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                echo 'Cloning repository...'
                checkout scm
                sh 'ls -l'  // Verify files
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
                dir('build/server') { // Corrected path
                    sh 'npm install'
                }
            }
        }

        stage('Install Client Dependencies') {
            steps {
                dir('build/client') { // Corrected path
                    sh 'npm install'
                }
            }
        }

        stage('Build Client') {
            steps {
                dir('build/client') {
                    sh 'npm run build'
                }
            }
        }

        stage('Start Server') {
            steps {
                dir('build/server') {
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

