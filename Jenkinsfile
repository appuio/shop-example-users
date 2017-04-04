pipeline {
  agent any

  stages {

    stage('test') {
      steps {
        echo "testing..."
        sh "ls -la"
        sh "pwd"
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
