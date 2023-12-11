pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        script {
          sh 'docker build -t myserver:latest .'
        }
      }
    }
    stage('Scan') {
      steps {
        script {
          sh 'trivy image --no-progress myserver:latest'
        }
      }
    }
  }
}
