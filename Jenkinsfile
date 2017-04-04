stage('test') {
  node {
    // run the wrapped commands inside our builder container
    docker.image('appuio/shop-example-users-builder').inside {
      echo "testing..."
      echo "$dir"
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
