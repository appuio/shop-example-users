pipeline {
  // agent none
  agent any
  
  stages {
    stage('test') {
      /*agent {
        docker 'appuio/shop-example-users-builder'
      }*/
      steps {
        echo 'Running tests...'
        sh 'pwd'
        // install necessary application packages
        // sh 'mix deps.get' 
        // compile the application
        // sh 'MIX_ENV=prod mix compile'
        // run tests
        // sh 'mix test'
      }
    }

    stage('compile') {
      /* agent {
        docker 'appuio/shop-example-users-builder'
      } */
      steps {
        echo 'Creating release...'
        sh 'pwd'
        // install necessary application packages
        // sh 'mix deps.get'
        // build the application sources
        // sh 'MIX_ENV=prod mix release'
        stash includes: '_build', name: 'release'
      }
    }

    stage('build') {
      // agent any
      steps {
        echo 'Building a container...'
        unstash 'release'
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
