pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        script {
          sh 'docker build -t myserver .'
        }
      }
    }
    stage('Scan') {
      steps {
        script {
          sh 'trivy --quiet --ignore-unfixed --severity CRITICAL --format table --no-progress myserver:latest'
        }
      }
    }
  }
}
