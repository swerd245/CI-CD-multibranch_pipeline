pipeline {
    agent any

    parameters {
        choice(
            name: 'DEPLOY_ENV',
            choices: ['local', 'EC2'],
            description: 'Choose the deployment environment'
        )
    }

    stages {
        stage('Initialize') {
            steps {
                script {
                    echo "Deployment environment selected: ${params.DEPLOY_ENV}"
                }
            }
        }

        stage('Build and Deploy to Local') {
            when {
                expression { params.DEPLOY_ENV == 'local' }
            }
            steps {
                echo 'Build and Deploy to Local Environment'
                sh 'docker build -t swerd245/vite-app ./'
                sh 'docker run -d -p 8081:80 --name vite-app swerd245/vite-app'
            }
        }

        stage('Build and Deploy to EC2') {
            when {
                expression { params.DEPLOY_ENV == 'EC2' }
            }
            steps {
                echo 'Deploying to EC2 Environment'
                script {
                    sshagent(credentials: ['ec2-user']) {
                        sh "scp -o StrictHostKeyChecking=no ./Dockerfile ${EC2_USER}@${EC2_IP}:~/"
                        sh "ssh -o StrictHostKeyChecking=no ${EC2_USER}@${EC2_IP} 'docker build -t swerd245/vite-app ./'"
                        sh "ssh -o StrictHostKeyChecking=no ${EC2_USER}@${EC2_IP} 'docker stop vite-app || true && docker rm vite-app || true'"
                        sh "ssh -o StrictHostKeyChecking=no ${EC2_USER}@${EC2_IP} 'docker run -d -p 8081:80 --name vite-app swerd245/vite-app'"
                    }
                }
            }
        }
    }
}
