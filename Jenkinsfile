pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: "https://github.com/designagune/TEST_REPO"
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
	stage('Deploy') {
            steps {
                sh 'ssh -o StrictHostKeyChecking=no ubuntu@$APPLICATION_SERVER'
                sh 'scp $JAR_FILE_PATH ubuntu@$APPLICATION_SERVER:/home/ubuntu/chrkb1569'
                sh 'scp $SCRIPT_FILE_PATH ubuntu@$APPLICATION_SERVER:/home/ubuntu/chrkb1569'
                sh 'ssh ubuntu@$APPL![](https://velog.velcdn.com/images/chrkb1569/post/6a8a3e5f-e017-471c-8b3e-eecb75ab7a15/image.png)
ICATION_SERVER "sudo chmod 777 /home/ubuntu/chrkb1569/DockerDeploy.sh"'
                sh 'ssh ubuntu@$APPLICATION_SERVER "sudo chmod 777 /home/ubuntu/chrkb1569/*.jar"'
                sh 'ssh ubuntu@$APPLICATION_SERVER "/home/ubuntu/chrkb1569/DockerDeploy.sh"'
            }
        }
    }
}
