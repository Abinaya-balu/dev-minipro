pipeline {
    agent any

    environment {
        DOCKERHUB_USER = 'abinayabalusamy' // Change this to your DockerHub username
        CLIENT_IMAGE = 'abinayabalusamy/react-app'
        SERVER_IMAGE = 'abinayabalusamy/node-server'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'master', url: 'https://github.com/Abinaya-balu/dev-minipro.git'
            }
        }

        stage('Docker Login') {
            steps {
                withCredentials([string(credentialsId: 'docker-hub-password', variable: 'DOCKER_PASS')]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKERHUB_USER --password-stdin'
                }
            }
        }

        stage('Build & Push Client Image') {
            steps {
                sh 'docker build -t $CLIENT_IMAGE -f ./client/Dockerfile ./client'
                sh 'docker push $CLIENT_IMAGE'
            }
        }

        stage('Build & Push Server Image') {
            steps {
                sh 'docker build -t $SERVER_IMAGE -f ./server/Dockerfile ./server'
                sh 'docker push $SERVER_IMAGE'
            }
        }

        stage('Docker Logout') {
            steps {
                sh 'docker logout'
            }
        }
    }

    post {
        success {
            echo "✅ Docker images successfully built & pushed!"
        }
        failure {
            echo "❌ Build failed! Check logs for errors."
        }
    }
}

