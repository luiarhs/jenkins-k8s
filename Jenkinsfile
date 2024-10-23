pipeline {
    agent {
        kubernetes {
            inheritFrom 'jmeter-agent'
        }
    }
    options {
        timeout(time: 3, unit: 'MINUTES')  // Set a higher timeout for the job
    }
    stages {
        stage('Transfer Files') {
            steps {
                container('jmeter') {
                    script {
                        sh 'jmeter --version'
                    }
                }
            }
        }
    }
    post {
        always {
            echo 'Pipeline finished execution.'
        }
        success {
            echo 'Pipeline completed successfully.'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}
