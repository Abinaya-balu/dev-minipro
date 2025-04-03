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
                    extensions: [[$class: 'RelativeTargetDirectory', relativeTargetDir: '.']],
                    userRemoteConfigs: [[url: 'https://github.com/Abinaya-balu/dev-minipro.git']]
                ])
                sh 'ls -l' // Debugging step to verify files
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
                    sh 'cd mern-app && ls -l' // Debugging step to confirm package.json
                    sh 'cd mern-app && npm install' // Install dependencies inside correct folder
                }
            }
        }

        stage('Build App') {
            steps {
                script {
                    sh 'cd mern-app && npm run build'
                }
            }
        }

        stage('Build and Push Docker Image') {
            steps {
                script {
                    sh './build.sh'
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    sh './deploy.sh'
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline execution completed successfully!'
        }
        failure {
            echo 'Pipeline failed. Check logs!'
        }
    }
}

