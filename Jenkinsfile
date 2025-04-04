pipeline {
    agent any

    environment {
        IMAGE_NAME_CLIENT = "abinayabalusamy/react-client"
        IMAGE_NAME_SERVER = "abinayabalusamy/react-server"
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
                    sh "docker build -t $IMAGE_NAME_CLIENT:latest ./client"
                    sh "docker tag $IMAGE_NAME_CLIENT:latest $IMAGE_NAME_CLIENT:latest"
                    sh "docker push $IMAGE_NAME_CLIENT:latest"
                }
            }
        }

        stage('Build & Push Server Image') {
            steps {
                script {
                    sh "docker build -t $IMAGE_NAME_SERVER:latest ./server"
                    sh "docker tag $IMAGE_NAME_SERVER:latest $IMAGE_NAME_SERVER:latest"
                    sh "docker push $IMAGE_NAME_SERVER:latest"
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

