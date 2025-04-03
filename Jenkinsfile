pipeline {
    agent any

    environment {
        DOCKER_HUB_USER = "abinayabalusamy"
    }

    stages {
        stage('Clone Repository') {
            steps {
                script {
                    echo "Cloning repository..."
                    checkout scm
                }
            }
        }

        stage('Setup Node.js') {
            steps {
                script {
                    sh 'node -v || echo "Node.js not found"'
                    sh 'npm -v || echo "NPM not found"'
                }
            }
        }

        stage('Build App') {
            steps {
                script {
                    sh 'chmod +x build.sh'
                    sh './build.sh || { echo "Build failed"; exit 1; }'
                }
            }
        }

        stage('Build and Push Docker Image') {
            steps {
                script {
                    sh 'chmod +x deploy.sh'
                    sh './deploy.sh || { echo "Docker build failed"; exit 1; }'
                }
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
    }

    post {
        always {
            echo 'Pipeline execution finished'
        }
        success {
            echo 'Pipeline executed successfully'
        }
        failure {
            echo 'Pipeline failed. Check logs!'
        }
    }
}


