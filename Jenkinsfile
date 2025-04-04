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
        //sh 'docker build -t abinayabalusamy/react-client:latest ./build/client'
        docker buildx create --use
        docker buildx build --platform linux/amd64,linux/arm64 -t abinayabalusamy/react-client:latest ./build/client

    }
}
stage('Build & Push Server Image') {
    steps {
        sh 'docker build -t abinayabalusamy/react-server:latest ./build/server'
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

