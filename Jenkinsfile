pipeline {
  agent any

  stages {

    stage('test') {
      docker.image('appuio/shop-example-users-builder').inside {
        echo "testing..."
        sh "ls -la"
        sh "pwd"
      }
    }

    stage('compile') {
      docker.image('appuio/shop-example-users-builder').inside {
        echo "compiling..."
      }
    }

    stage('build') {
      def image = docker.build 'shop-example-users:latest'
    }
    
  }
}
