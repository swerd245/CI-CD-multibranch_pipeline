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
                sh 'docker ps -a -q --filter name=frontend | grep -q . && docker stop swerd245/vite-app && docker rm swerd245/vite-app'
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
