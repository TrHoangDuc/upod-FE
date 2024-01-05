pipeline {
    agent any

    stages {
        stage('Cleanup') {
            steps {
                script {
                    // Check if a previous container is running and stop it
                    sh "docker inspect --format='{{.State.Running}}' ${containerID}"  // Check container state
                    if ('true' == sh(returnStdout: true, script: "docker inspect --format='{{.State.Running}}' ${containerID}")) {
                        sh "docker stop ${containerID}"  // Stop the container if running
                    }
                }
            }
        }

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

        stage('Run Docker Image') {
            steps {
                script {
                    containerID = docker.run("-d", "-p", "5173:5173", dockerImage.id)  // Capture container ID
                    echo "Container ID: ${containerID}"  // Output for reference
                }
            }
        }
    }
}