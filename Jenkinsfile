node('centos') {
  stage('build base image for kafka') {
    deleteDir()
    checkout scm
    def img = docker.build("gk-kafka:base-image-1.1.0", ".")
    docker.withRegistry('https://docker.axosoft.com') {
      img.push "base-image-1.1.0"
    }
    deleteDir()
  }
}