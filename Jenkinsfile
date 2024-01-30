pipeline {
    agent any

    environment {
        GIT_URL = "https://github.com/designagune/TEST_REPO"
    }
    stages {
        stage('Frontend Build') {
            steps {
                sh 'docker build -t swerd245/vite-app ./'
            }
        }

        stage('Frontend Deploy') {
            steps {
                script {
                    def isRunning = sh(script: 'docker ps -a -q --filter name=vite-app | grep -q .', returnStatus: true)
                    if (isRunning == 0) {
                        // If container is running, stop and remove it
                        sh 'docker stop vite-app && docker rm vite-app'
                    }
                }
                sh 'docker run -d -p 3000:3000 --name vite-app swerd245/vite-app'
            }
        }

        stage('Frontend Finish') {
            steps{
                sh 'docker images -qf dangling=true | xargs -I{} docker rmi {}'
            }
        }
    }
}
