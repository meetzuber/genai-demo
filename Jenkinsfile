pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh 'docker build -t jfrog-cr.10-35-151-40.nip.io/docker-local/demo:latest .'
            }
        }
        stage('Scan') {
            steps {
                sh 'trivy image --format table jfrog-cr.10-35-151-40.nip.io/docker-local/demo:latest'
            }
        }
        stage('Push') {
            steps {
                withCredentials([[$class: 'DockerRegistryCredential', credentialsId: 'admin-jcr', url: 'https://jfrog-cr.10-35-151-40.nip.io/']]) {
                    sh 'docker push jfrog-cr.10-35-151-40.nip.io/docker-local/demo:latest'
                }
            }
        }
        stage('Deploy') {
            steps {
                withCredentials([[$class: 'KubeConfig', credentialsId: 'prdrke2-k8s']]) {
                    sh 'kubectl apply -f deployment.yaml'
                }
            }
        }
    }
}