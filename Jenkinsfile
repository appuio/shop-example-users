pipeline {
  agent none
  
  stages {
    stage('test') {
      agent {
        docker 'appuio/shop-example-users-builder'
      }
      steps {
        echo 'Running tests...'
        // install necessary application packages
        bash 'mix deps.get' 
        // compile the application
        bash 'MIX_ENV=prod mix compile'
        // run tests
        bash 'mix test'
      }
    }

    stage('compile') {
      agent {
        docker 'appuio/shop-example-users-builder'
      }
      steps {
        echo 'Creating release...'
        // install necessary application packages
        bash 'mix deps.get'
        // build the application sources
        bash 'MIX_ENV=prod mix release'
        stash includes: '_build', name: 'release'
      }
    }

    stage('build') {
      steps {
        echo 'Building a container...'
        unstash 'release'
        bash 'ls -la'
      }
    } 
  }
}

/*
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
*/
