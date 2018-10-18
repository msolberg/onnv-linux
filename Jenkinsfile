pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh 'make clean'
                sh 'make all'
            }
        }
        stage('Analyze') {
            steps {
                sh 'make zipfile'
                sh 'cp cake/extensions/local-platform.cake.xml $JENKINS_HOME/cake/extensions/local-platform.cake.xml'
                sh 'java -jar $JENKINS_HOME/cake/cake-cli.jar -input onnv-linux-1.0.zip -output cake-output -logLevel error'
                sh 'zip -r cake-output.zip cake-output'
            }
        }
        stage('Unit Test') {
            steps {
                sh 'make clean'
                sh 'make test'
                sh 'make memcheck 2> memcheck.log'
            }
        }
    }
}
