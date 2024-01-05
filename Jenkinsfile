pipeline {
    agent any

    stages {
        stage('Cleanup') {
            steps {
                script {
                    previousBuildNumber = currentBuild.number - 1
                    // Retrieve the ID of the existing container (if any) based on the image name
                    containerID = sh(returnStdout: true, script: "docker ps -a -q --filter ancestor=trhoangduc/deploy_fe:${previousBuildNumber}.0")
                    if (containerID != "") {
                        sh "docker stop ${containerID}"  // Stop the container
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
                    // containerID = docker.run("-d", "-p", "5173:5173", dockerImage.id)  // Capture container ID
                    containerID = sh(returnStdout: true, script: "docker run -d -p 5173:5173 trhoangduc/deploy_fe:${BUILD_NUMBER}.0")
                    echo "Container ID: ${containerID}"  // Output for reference
                }
            }
        }
    }
}