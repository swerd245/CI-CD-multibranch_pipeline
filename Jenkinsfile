pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: "https://github.com/designagune/TEST_REPO"
            }
        }

        stage('Build Project') {
            steps {
                sh '../TEST_REPO'
            }
        }

        stage('Docker Login') {
            steps {
                sh 'echo gkstndk132! | docker login -u swerd245@gmail.com --password-stdin'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t swerd245/vite-app .'
            }
        }

        stage('Push Docker Image') {
            steps {
                sh 'docker push swerd245/vite-app'
            }
        }
    }
}
