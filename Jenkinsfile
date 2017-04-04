stage('test') {
  node {
    docker.image('appuio/shop-example-users-builder').inside {
      echo "testing..."
      sh "ls -la"
      sh "pwd"
    }
  }
}

stage('compile') {
  node {
    docker.image('appuio/shop-example-users-builder').inside {
      echo "compiling..."
    }
  }
}

stage('build') {
  node {
    def image = docker.build 'shop-example-users:latest'
  }
}
