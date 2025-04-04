pipeline {
    agent any

    environment {
        CLIENT_IMAGE = "abinayabalusamy/react-client"
        SERVER_IMAGE = "abinayabalusamy/react-server"
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'master', url: 'https://github.com/Abinaya-balu/dev-minipro.git'
            }
        }

        stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                }
            }
        }

        stage('Build & Push Client Image') {
            steps {
                script {
                    sh "docker build -t $CLIENT_IMAGE:latest ./client"
                    sh "docker push $CLIENT_IMAGE:latest"
                }
            }
        }

        stage('Build & Push Server Image') {
            steps {
                script {
                    sh "docker build -t $SERVER_IMAGE:latest ./server"
                    sh "docker push $SERVER_IMAGE:latest"
                }
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
            echo "✅ Build and Push Successful!"
        }
        failure {
            echo "❌ Build failed! Check logs for errors."
        }
    }
}

