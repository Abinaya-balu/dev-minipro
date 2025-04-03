pipeline {
    agent any

    tools {
        nodejs 'NodeJS' // 🔥 Use the NodeJS tool from Jenkins
    }

    environment {
        DOCKER_HUB_USER = "abinayabalusamy"
    }

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/Abinaya-balu/dev-minipro.git'
            }
        }

        stage('Build App') {
            steps {
                sh 'chmod +x build.sh'
                sh 'node -v'  // Debug: Check if Node.js is available
                sh './build.sh'
            }
        }

        stage('Build and Push Docker Image') {
            steps {
                sh 'chmod +x deploy.sh'
                sh './deploy.sh'
            }
        } 

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    sh 'kubectl config current-context'  
                    sh 'kubectl apply -f k8s/deployment.yaml'
                    sh 'kubectl apply -f k8s/service.yaml'
                }
            }
        }
    }
}

