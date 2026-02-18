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
                    sh "docker push ${DOCKER_IMAGE}:latest"    
                }
            }
        }

        // stage('Deploy ke Raspi') {
        //    steps {
        //         echo 'Medeploy container baru ke Localhost...'

        //         sh "docker stop portofolio-web || true"
        //         sh "docker rm portofolio-web || true"

        //         sh "docker run -d -p 2001:80 --name portofolio-web ${DOCKER_IMAGE}:latest"
        //    }        
        // }

        stage('Deploy ke Kubernetes') {
            steps {
                echo '🚀 Memulai Deployment ke K3s Cluster...'
                
                // Menggunakan kredensial SSH Raspi yang sudah kamu simpan
                sshagent(['akhsan_server']) {
                    // 1. Buat folder penampungan di Raspi (jika belum ada)
                    sh "ssh -o StrictHostKeyChecking=no akhsan_server@192.168.0.120 'mkdir -p ~/k8s-deploy'"

                    // 2. Kirim file YAML terbaru dari Jenkins ke Raspi
                    sh "scp -o StrictHostKeyChecking=no -r k8s/* akhsan_server@192.168.0.120:~/k8s-deploy/"

                    // 3. Perintahkan Raspi untuk menerapkan update
                    sh """
                        ssh -o StrictHostKeyChecking=no akhsan_server@192.168.0.120 '
                            kubectl apply -f ~/k8s-deploy/
                            
                            # Paksa restart agar image terbaru ter-pull
                            kubectl rollout restart deployment/portofolio-web
                            
                            # Cek status rollout
                            kubectl rollout status deployment/portofolio-web
                        '
                    """
                }
            }
        }
    }
}