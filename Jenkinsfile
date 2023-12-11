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
          sh 'docker run --rm -v /var/run/docker.sock:/var/run/docker.sock -v $(pwd):/workspace quay.io/aquasecurity/trivy:latest --quiet --ignore-unfixed --severity CRITICAL --format table --no-progress docker-archive:$(docker build -f Dockerfile . --no-cache --output type=docker | tar -c . | base64)'
        }
      }
    }
  }
}
