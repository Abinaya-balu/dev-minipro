pipeline {
    agent any

    environment {
        DOCKER_HUB_USER = "abinayabalusamy"
        DOCKER_HUB_PASSWORD = credentials('docker-hub-credentials') // Jenkins Credentials
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
                sh 'kubectl apply -f k8s/deployment.yaml'
                sh 'kubectl apply -f k8s/service.yaml'
            }
        }
    }
}
