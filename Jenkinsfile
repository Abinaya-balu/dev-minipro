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
                    extensions: [[$class: 'RelativeTargetDirectory', relativeTargetDir: 'mern-app']],
                    userRemoteConfigs: [[url: 'https://github.com/Abinaya-balu/dev-minipro.git']]
                ])
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
                    sh 'cd mern-app && npm install'
                }
            }
        }

        stage('Build App') {
            steps {
                script {
                    sh 'cd mern-app && CI=false npm run build'
                }
            }
        }

        stage('Build and Push Docker Image') {
            when {
                expression { currentBuild.resultIsBetterOrEqualTo('SUCCESS') }
            }
            steps {
                echo 'Building and pushing Docker image...'
                sh 'cd mern-app && ./docker-build.sh'
            }
        }

        stage('Deploy to Kubernetes') {
            when {
                expression { currentBuild.resultIsBetterOrEqualTo('SUCCESS') }
            }
            steps {
                echo 'Deploying to Kubernetes...'
                sh 'cd mern-app && ./deploy.sh'
            }
        }
    }

    post {
        always {
            echo 'Pipeline execution finished'
        }
        failure {
            echo 'Pipeline failed. Check logs!'
        }
    }
}

