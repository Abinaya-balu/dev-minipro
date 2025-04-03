pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                echo 'Cloning repository...'
                checkout([
                    $class: 'GitSCM',
                    branches: [[name: '*/master']],
                    doGenerateSubmoduleConfigurations: false,
                    extensions: [[$class: 'RelativeTargetDirectory', relativeTargetDir: '.']], // Clone directly into workspace
                    userRemoteConfigs: [[url: 'https://github.com/Abinaya-balu/dev-minipro.git']]
                ])
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

        stage('Install Dependencies') {
            steps {
                script {
                    sh 'npm install' // No need to change directory
                }
            }
        }

        stage('Build App') {
            steps {
                script {
                    sh 'CI=false npm run build' // Run in correct directory
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
