pipeline {
    agent any
    environment {
        // Define your credentials here
        REGISTRY_URL = 'jfrog-cr.10-35-151-40.nip.io/docker-local/'
        REGISTRY_CREDENTIAL_ID = 'admin-jcr'
        KUBECONFIG_CREDENTIAL_ID = 'prdrke2-k8s'
    }
    stages {
        stage('Build') {
            steps {
                sh 'docker build -t ${REGISTRY_URL}demo:latest .'
            }
        }
        stage('Scan') {
            steps {
                sh 'trivy image ${REGISTRY_URL}demo:latest'
            }
        }
        stage('Push') {
            steps {
                withDockerRegistry(credentialsId: 'admin-jcr', url: 'https://jfrog-cr.10-35-151-40.nip.io/') {
                    sh 'docker push ${REGISTRY_URL}demo:latest'
                }
            }
        }
        stage('Deploy') {
            steps {
                withKubeConfig(credentialsId: 'prdrke2-k8s') {
                    sh 'kubectl apply -f deployment.yaml'
                }
            }
        }
    }
}