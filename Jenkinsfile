pipeline {
    agent any

    environment {
        IMAGE_NAME = "abinayabalusamy/reactbooking"
        CONTAINER_NAME = "my-app"
        REGISTRY = "docker.io/abinayabalusamy"
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Build and Test') {
            steps {
                script {
                    sh 'docker build -t $IMAGE_NAME .'
                }
            }
        }

        stage('Push to Registry') {
            steps {
                script {
                    sh 'docker tag $IMAGE_NAME $REGISTRY/$IMAGE_NAME:latest'
                    sh 'docker push $REGISTRY/$IMAGE_NAME:latest'
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    sh './deploy.sh'
                }
            }
        }
    }
}


