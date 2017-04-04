pipeline {
  agent any

  stages {

    stage('test') {
      steps {
        echo "testing..."
        sh "ls -la || true"
        sh "pwd || true"
      }
    }

    stage('compile') {
      steps {
        echo "compiling..."
      }
    }

    stage('build') {
      steps {
        echo "building..."
      }
    }
    
  }
}
