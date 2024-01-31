pipeline {
    agent any

    environment {
        EC2_IP = "3.90.3.174" // EC2 인스턴스의 IP 주소
        EC2_USER = "ec2-user" // EC2 인스턴스의 사용자명
        PROJECT_DIR = "project-directory" // EC2 인스턴스 내 프로젝트 디렉토리 이름
    }

    stages {
        stage('Initialize') {
            steps {
                script {
                    echo "Current branch: ${env.BRANCH_NAME}"
                }
            }
        }

        stage('Build and Deploy to Local') {
            when {
                expression { env.BRANCH_NAME == 'develop' }
            }
            steps {
                echo 'Build and Deploy to Local Environment'
                sh 'docker build -t swerd245/vite-app ./'
                sh 'docker stop vite-app || true'
                sh 'docker rm vite-app || true'
                sh 'docker run -d -p 8081:80 --name vite-app swerd245/vite-app'
            }
        }

        stage('Build and Deploy to EC2') {
            when {
                expression { env.BRANCH_NAME == 'main' }
            }
            steps {
                echo 'Deploying to EC2 Environment'
                script {
                    // 전체 프로젝트 디렉토리를 EC2 인스턴스로 복사
                    sh "scp -o StrictHostKeyChecking=no -r . ${EC2_USER}@${EC2_IP}:~/${PROJECT_DIR}"
                    // EC2 인스턴스에서 Docker 빌드 및 실행
                    sshagent(credentials: ['ec2-user']) {
                        sh "ssh -o StrictHostKeyChecking=no ${EC2_USER}@${EC2_IP} 'cd ~/${PROJECT_DIR} && docker build -t swerd245/vite-app .'"
                        sh "ssh -o StrictHostKeyChecking=no ${EC2_USER}@${EC2_IP} 'docker stop vite-app || true && docker rm vite-app || true'"
                        sh "ssh -o StrictHostKeyChecking=no ${EC2_USER}@${EC2_IP} 'docker run -d -p 8081:80 --name vite-app swerd245/vite-app'"
                    }
                }
            }
        }
    }
}
