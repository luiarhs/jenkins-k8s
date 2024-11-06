pipeline {
    agent {
        kubernetes {
            inheritFrom 'jmeter-agent'
        }
    }

    environment {
        REMOTE_NAME = 'postest'
        REMOTE_HOST = "172.22.13.75" // IP address 4690
        REMOTE_PATH = '/opt/vx4690/fuse/c_drive'  // Path where the files will be stored and extracted
    }

    stages {
        stage('Prepare Files') {
            steps {
                container('jmeter') {
                    script {
                        // Zip all the files in the app folder using the Pipeline Utility Steps plugin
                        zip zipFile: 'bundle.zip', archive: false, dir: 'app'
                    }
                }
            }
        }
        stage('Transfer Files') {
            steps {
                container('jmeter') {
                    script {
                        def path = 'jmeter/scripts/4690.jmx'
                        sh """
                            jmter -n -t ${path} -l result.jtl -Djava.awt.headless=true
                        """
                    }
                }
            }
        }
        // stage('Transfer Files') {
        //     steps {
        //         container('jmeter') {
        //             script {
        //                 // Use scp to transfer the files to the remote host
        //                 withCredentials([usernamePassword(credentialsId: 'POS_QA', usernameVariable: 'REMOTE_USER', passwordVariable: 'REMOTE_PASSWORD')]) {
        //                     def remote = configureRemote(REMOTE_NAME, REMOTE_HOST, REMOTE_USER, REMOTE_PASSWORD)
        //                     // Transfer the files to the remote host
        //                     transferFile(remote, 'bundle.zip', REMOTE_PATH)
        //                 }
        //             }
        //         }
        //     }
        // }
        // stage('Run JMeter Test') {
        //     steps {
        //         container('jmeter') {
        //             script {
        //                 // Define the path to your JMeter test script
        //                 def jmeterTestFile = 'test.jmx'
        //                 def resultFile = 'result.jtl'

        //                 // Run JMeter test using shell command
        //                 sh """
        //                     jmeter -n -t ${jmeterTestFile} -l ${resultFile} -Djava.awt.headless=true
        //                 """
        //             }
        //         }
        //     }
        // }
        stage('Sleep') {
            steps {
                script {
                    echo 'I am sleeping for a while'
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
        stage('Archive JMeter Results') {
            steps {
                // Archive the JMeter result file and the test script
                archiveArtifacts artifacts: 'result.jtl, test.jmx', allowEmptyArchive: true
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
// Helper function to configure the remote details
def configureRemote(name, host, user, password) {
    return [
        name: name,
        host: host,
        user: user,
        password: password,
        allowAnyHosts: true,
        config: [
            'server_host_key': 'ssh-rsa,ssh-dss'
        ]
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