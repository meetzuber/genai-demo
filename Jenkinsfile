pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t jfrog-cr.10-35-151-40.nip.io/docker-local/demo:latest .'
            }
        }

        stage('Scan Image with Trivy') {
            steps {
                sh 'trivy jfrog-cr.10-35-151-40.nip.io/docker-local/demo:latest --format table'
            }
        }

        stage('Push Image to Docker Registry') {
            steps {
                withDockerRegistry(credentialsId: 'admin-jcr', url: 'https://jfrog-cr.10-35-151-40.nip.io/') {
                    sh 'docker push jfrog-cr.10-35-151-40.nip.io/docker-local/demo:latest'
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                withKubeConfig(credentialsId: 'prdrke2-k8s') {
                    sh 'kubectl apply -f deploy.yml'
                }
            }
        }
    }
}