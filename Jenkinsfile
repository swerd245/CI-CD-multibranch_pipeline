peline {
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
                    // 컨테이너가 실행 중인지 확인
                    def isRunning = sh(script: 'docker ps -a -q --filter name=vite-app | grep -q .', returnStatus: true)
                    if (isRunning == 0) {
                        // 컨테이너가 실행 중이면 중지 및 제거
                        sh 'docker stop vite-app && docker rm vite-app'
                    }
                }
                // 새 컨테이너 실행
                sh 'docker run -d -p 80:80 --name vite-app swerd245/vite-app'
            }
        }

        stage('Frontend Finish') {
            steps {
                // 쓸모없는 이미지 제거
                sh 'docker images -qf dangling=true | xargs -I{} docker rmi {}'
            }
        }
    }
}
