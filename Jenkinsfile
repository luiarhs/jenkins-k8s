pipeline {
    agent {
        kubernetes {
            inheritFrom 'jmeter-agent'
        }
    }

    environment {
        REMOTE_NAME = 'postest'
        REMOTE_HOST = "172.22.13.75" // IP address 4690
        // REMOTE_HOST = "172.22.70.34" // IP address Linux
        REMOTE_PATH = '/opt/vx4690/fuse/m_drive'  // Path where the files will be stored and extracted
    }

    stages {
        stage('Prepare Files') {
            steps {
                container('jmeter') {
                    script {
                        // sh "zip -r ${zipFile} scripts/*"
                        sh 'ls -l'
                        sh 'jmeter --version'
                    }
                }
            }
        }
        stage('Transfer Files') {
            steps {
                container('jmeter') {
                    script {
                        // Configure the remote details
                        withCredentials([usernamePassword(credentialsId: 'POS_4690_QA', usernameVariable: 'REMOTE_USER', passwordVariable: 'REMOTE_PASSWORD')]) {
                            def remote = configureRemote(REMOTE_NAME, REMOTE_HOST, REMOTE_USER, REMOTE_PASSWORD)

                            // Transfer the files to the remote host
                            transferFile(remote, 'bundle.zip', REMOTE_PATH)
                        }
                    }
                }
            }
        }
        stage('Run JMeter Test') {
            steps {
                container('jmeter') {
                    script {
                        // Define the path to your JMeter test script
                        def jmeterTestFile = 'JMeter/Scripts/4690UnzipVer.jmx'
                        def resultFile = 'result.jtl'

                        // Run JMeter test using shell command (assumes JMeter is installed on the agent)
                        sh """
                            jmeter -n -t ${jmeterTestFile} -l ${resultFile} -Djava.awt.headless=true
                        """
                    }
                }
            }
        }
        stage('Sleep') {
            steps {
                script {
                    print('I am sleeping for a while')
                    sleep(30)    
                }
                
            }
        }
        stage('Publish Performance Report') {
            steps {
                script {
                    sh 'cat TestLog.log'
                    // Publish the performance report using the Performance plugin
                    perfReport errorFailedThreshold: 0, // Set this to your acceptable failure threshold (e.g., response time)
                               errorUnstableThreshold: 0, 
                               sourceDataFiles: 'result.jtl' // Point to the JMeter results file
                }
            }
        }
        // stage('Archive JMeter Results') {
        //     steps {
        //         // Archive the JMeter result file and the test script
        //         archiveArtifacts artifacts: 'result.jtl, test.jmx', allowEmptyArchive: true
        //     }
        // }
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

// Helper function to configure the remote details
def configureRemote(name, host, user, password) {
    return [
        name: name,
        host: host,
        user: user,
        password: password,
        allowAnyHosts: true,
        logLevel: 'INFO'
    ]
}

// Helper function to execute SSH command
def executeSSH(remote, command) {
    try {
        sshCommand remote: remote, command: command
        log("Command executed successfully on ${remote.host}")
    } catch (Exception e) {
        error("SSH command failed on ${remote.host}: ${e.message}")
    }
}

// Helper function to transfer files via sshPut
def transferFile(remote, localFilePath, remoteFilePath) {
    try {
        sshPut remote: remote, from: localFilePath, into: remoteFilePath, failOnError: false
        log("File transferred successfully from ${localFilePath} to ${remote.host}:${remoteFilePath}")
    } catch (Exception e) {
        error("File transfer failed to ${remote.host}: ${e.message}")
    }
}