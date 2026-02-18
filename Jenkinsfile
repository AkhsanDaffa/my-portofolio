pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'jawaracode/portofolio-web'
        DOCKER_TAG = "v${env.BUILD_NUMBER}"
    }

    stages {
        stage('Checkout Kode') {
            steps {
                echo 'Menjemput kode terbaru dari GitHub...'
                checkout scm
            }
        }

        stage('Build Image (ARM64)') {
           steps {
                echo 'Merakit Docker Image di Raspberry Pi (ARM64)...'
                sh "docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} -t ${DOCKER_IMAGE}:latest ."
           }        
        }

        stage('Push ke Docker Hub') {
            steps {
                echo 'Mengirim Image ke Docker Hub...'
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', passwordVariable: 'DOCKER_PASS', usernameVariable: 'DOCKER_USER')]) {
                    sh "echo \$DOCKER_PASS | docker login -u \$DOCKER_USER --password-stdin"
                    sh "docker push ${DOCKER_IMAGE}:${DOCKER_TAG}"
                    sh "docker push ${DOCKER_IMAGE}:latest"            }
        }

        stage('Pembersihan') {
            echo 'Delete Local image'
            sh "docker rmi ${DOCKER_IMAGE}:${DOCKER_TAG} ${DOCKER_IMAGE}:latest"
        }
    }
}