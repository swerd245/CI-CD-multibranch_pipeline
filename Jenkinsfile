peline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: "https://github.com/designagune/TEST_REPO"
            }
        }

        stage('Build Project') {
            steps {
                sh './npm run build'
            }
        }

        stage('Docker Login') {
            steps {
                sh 'echo gkstndk132! | docker login -u swerd245@gmail.com --password-stdin'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t chrkb1569/jenkins:test .'
            }
        }

        stage('Push Docker Image') {
            steps {
                sh 'docker push chrkb1569/jenkins:test'
            }
        }
    }
}}
