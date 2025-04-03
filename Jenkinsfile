pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                echo 'Cloning repository...'
                checkout scm
            }
        }

        stage('Setup Node.js') {
            steps {
                script {
                    sh 'node -v'
                    sh 'npm -v'
                }
            }
        }

        stage('Build App') {
            steps {
                script {
                    sh 'chmod +x build.sh'
                    // Set CI=false to prevent ESLint from failing the build
                    sh 'CI=false npm run build'
                }
            }
        }

        stage('Build and Push Docker Image') {
            when {
                expression { currentBuild.resultIsBetterOrEqualTo('SUCCESS') }
            }
            steps {
                echo 'Building and pushing Docker image...'
                sh './docker-build.sh'
            }
        }

        stage('Deploy to Kubernetes') {
            when {
                expression { currentBuild.resultIsBetterOrEqualTo('SUCCESS') }
            }
            steps {
                echo 'Deploying to Kubernetes...'
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

