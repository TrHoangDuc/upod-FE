pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/TrHoangDuc/upod.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("trhoangduc/deploy_fe:${BUILD_NUMBER}.0")
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'DockerHub') {
                        dockerImage.push()
                    }
                }
            }
        }

        stage('Run Docker Image'){
          steps {
            script {
              sh "docker run -d -p 5173:5173 trhoangduc/deploy_fe:${BUILD_NUMBER}.0"
            }
          }
        }
    }
}