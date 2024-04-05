pipeline {
    agent any
    environment {
        // Define your credentials here
        REGISTRY_URL = 'https://jfrog-cr.10-35-151-40.nip.io/'
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
                sh 'trivy image --format plain ${REGISTRY_URL}demo:latest'
            }
        }
        stage('Push') {
            steps {
                withDockerRegistry(${REGISTRY_CREDENTIAL_ID}) {
                    sh 'docker push ${REGISTRY_URL}demo:latest'
                }
            }
        }
        stage('Deploy') {
            steps {
                withKubeConfig(${KUBECONFIG_CREDENTIAL_ID}) {
                    sh 'kubectl apply -f deployment.yaml'
                }
            }
        }
    }
}