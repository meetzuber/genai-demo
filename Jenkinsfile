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
          sh 'trivy image --format json --no-progress myserver:latest > trivy.json'
          def trivyReport = readJSON file: 'trivy.json'
          echo "Vulnerabilities found: ${trivyReport.Vulnerabilities.length}"
          if (trivyReport.Vulnerabilities.length > 0) {
            error 'Vulnerabilities found in the image'
          }
        }
      }
    }
  }
}
