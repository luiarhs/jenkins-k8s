pipeline {
    agent {
        kubernetes {
            yaml """
            apiVersion: v1
            kind: Pod
            spec:
              containers:
              - name: jmeter
                image: luiarhs/jmeter:latest  # Using your custom JMeter image
                command:
                - cat
                tty: true
                volumeMounts:
                - name: workspace-volume
                  mountPath: "/home/jenkins/agent"
              volumes:
              - name: workspace-volume
                emptyDir: {}
            """
        }
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
