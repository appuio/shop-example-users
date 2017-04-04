pipeline {
  agent any

  stages {

    stage('test') {
      steps {
        docker.image('appuio/shop-example-users-builder').inside {
          echo "testing..."
          sh "ls -la"
          sh "pwd"
        }
      }
    }

    stage('compile') {
      steps {
        docker.image('appuio/shop-example-users-builder').inside {
          echo "compiling..."
        }
      }
    }

    stage('build') {
      steps {
        def image = docker.build 'shop-example-users:latest'
      }
    }
    
  }
}
