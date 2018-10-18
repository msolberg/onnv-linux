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
        stage('Package') {
            steps {
                sh 'make clean'
                sh 'make tarball'
                sh 'make rpm'
                sh 'rpmbuild --define "_topdir ${WORKSPACE}/rpm" --define "build_num ${BUILD_NUMBER}" -ta onnv-linux-1.0.tar.gz'
            }
        }
    }
    
    post {
        always {
            archiveArtifacts artifacts: 'cake-output.zip'
            archiveArtifacts artifacts: 'memcheck.log'
            archiveArtifacts artifacts: 'rpm/RPMS/x86_64/*'
            archiveArtifacts artifacts: 'rpm/SRPMS/*'
            deleteDir()
        }
    }
}
