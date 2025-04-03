pipeline {
    agent any

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
                sh './build.sh'
            }
        }

        stage('Build and Push Docker Image') {
            steps {
                // Grant executable permissions to the deploy script
                sh 'chmod +x deploy.sh'

                // Build and push the Docker image using the deploy script
                sh './deploy.sh'
            }
        } 

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    sh 'kubectl config current-context'  // Debugging: Check the current cluster
                    sh 'kubectl apply -f k8s/deployment.yaml'
                    sh 'kubectl apply -f k8s/service.yaml'
                }
            }
        }
    }  // 🔥 Closing brace for "stages" added here
}  // 🔥 Closing brace for "pipeline" remains unchanged
