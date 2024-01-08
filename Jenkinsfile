pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build('jfrog-cr.10-35-151-40.nip.io/docker-local/helloworld:' + env.BUILD_NUMBER)
                 }
             }
         }

        stage('Scan Docker Image with Trivy') {
            steps {
                sh  'trivy image --exit-code 0 --severity HIGH,CRITICAL --ignore-unfixed --format json jfrog-cr.10-35-151-40.nip.io/docker-local/helloworld:' + env.BUILD_NUMBER
             }
         }

        stage('Push Docker Image to Registry') {
            steps {
                script {
                    docker.withRegistry('https://jfrog-cr.10-35-151-40.nip.io', 'admin-jcr') {
                        dockerImage.push()
                     }
                 }
             }
         }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    withKubeConfig([credentialsId: 'prdrke2-k8s', context: '', cluster: '', namespace: '']) {
                        // Replace 'deployment.yaml' with the path to your Kubernetes deployment configuration file
                        sh 'sed -i "s/latest/${BUILD_NUMBER}/g" deployment.yaml'
                        sh 'kubectl apply -f deployment.yaml'
                     }
                 }
             }
         }
     }
}
