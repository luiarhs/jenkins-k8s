pipeline {
    agent {
        kubernetes {
            inheritFrom 'jmeter-agent'
        }
    }

    environment {
        REMOTE_NAME = 'postest'
        REMOTE_HOST = "172.22.13.75" // IP address 4690
        REMOTE_PATH = "M:"  // Path where the files will be stored and extracted
    }

    stages {
        stage('Prepare Files') {
            steps {
                container('jmeter') {
                    script {
                        // Zip all the files in the app folder using the Pipeline Utility Steps plugin
                        sh 'zip -r -9 bundle.zip bridgep3Ant/*'
                    }
                }
            }
        }
        stage('Transfer Files') {
            steps {
                container('jmeter') {
                    script {
                        // Use scp to transfer the files to the remote host
                        withCredentials([usernamePassword(credentialsId: 'POS_QA', usernameVariable: 'REMOTE_USER', passwordVariable: 'REMOTE_PASSWORD')]) {
                            sh """
                                sshpass -p '${REMOTE_PASSWORD}' sftp -o HostKeyAlgorithms=+ssh-rsa,ssh-dss \
                                -o Ciphers=+aes128-cbc \
                                -o KexAlgorithms=+diffie-hellman-group1-sha1 \
                                ${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_PATH} << EOF
                                put bundle.zip
                                EOF
                            """
                        }
                    }
                }
            }
        }
        stage('Clean Remote') {
            steps {
                container('jmeter') {
                    script {
                        def path = '4690-clean.jmx'
                        sh """
                            jmeter -n -t ${path} -l result.jtl -Djava.awt.headless=true
                        """
                        sh 'cat jmeter.log'
                    }
                }
            }
        }
        stage('Unzip Files') {
            steps {
                container('jmeter') {
                    script {
                        def path = '4690-unzip.jmx'
                        sh """
                            jmeter -n -t ${path} -l result.jtl -Djava.awt.headless=true
                        """
                        sh 'cat jmeter.log'
                    }
                }
            }
        }
        stage('Memory Reload') {
            steps {
                container('jmeter') {
                    script {
                        def path = '4690-regen.jmx'
                        sh """
                            jmeter -n -t ${path} -l result.jtl -Djava.awt.headless=true
                        """
                        sh 'cat jmeter.log'
                    }
                }
            }
        }
        stage('Send Load') {
            steps {
                container('jmeter') {
                    script {
                        def path = '4690-load.jmx'
                        sh """
                            jmeter -n -t ${path} -l result.jtl -Djava.awt.headless=true
                        """
                        sh 'cat jmeter.log'
                    }
                }
            }
        }
        stage('Publish Performance Report') {
            steps {
                script {
                    // Publish the performance report using the Performance plugin
                    perfReport errorFailedThreshold: 0, // Set this to your acceptable failure threshold (e.g., response time)
                               errorUnstableThreshold: 0, 
                               sourceDataFiles: 'result.jtl' // Point to the JMeter results file
                }
            }
        }
        stage('Archive JMeter Results') {
            steps {
                // Archive the JMeter result file and the test script
                archiveArtifacts artifacts: 'result.jtl, test.jmx, bundle.zip', allowEmptyArchive: true
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