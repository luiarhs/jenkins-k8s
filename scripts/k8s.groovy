```
pipeline {
    agent {
        kubernetes {
            inheritFrom 'gcloud-spot'
            yaml"""
            spec:
                serviceAccount: ${environmentVariables[environment()]["PIPELINE_K8S_SA"]}
            """
        }
    }

    stages {

        stage ("Set Environment Variables") {
            when { branch pattern: "dev|qas|pro|feat/cicd", comparator: "REGEXP" }
            steps {
                script {
                    env.environment = environment()
                }
            }
            post {
                unsuccessful {
                    script{
                        googleChat.unsuccessfullNotification('google-chat-wh')
                    }
                }
            }
        }

        stage ("Docker Build") {
            when { branch pattern: "dev|qas|pro|feat/cicd", comparator: "REGEXP" }
            steps {
                container ('docker') {
                    script{
                        gcpUtils.loginArtifactRegistry(environmentVariables[env.environment]["IMAGE_REGISTRY"])
                        env.imageTag = "${environmentVariables[env.environment]["IMAGE_REGISTRY"]}/${environmentVariables[env.environment]["IMAGE_REPOSITORY"]}/${environmentVariables[env.environment]["IMAGE_NAME"]}:${GIT_COMMIT[0..7]}"
                    }
                    sh (
                        w
                    )
                    sh (
                        label: "Docker Push",
                        script: "docker push $env.imageTag"
                    )
                    sh (
                        label: "Clean docker",
                        script: "docker rmi -f $env.imageTag"
                    )
                }
            }
            post {
                unsuccessful {
                    script{
                        googleChat.unsuccessfullNotification('google-chat-wh')
                    }
                }
            }
        }

        stage ("Render Cloud Run manifest") {
            when { branch pattern: "dev|qas|pro|feat/cicd", comparator: "REGEXP" }
            steps {
                container ('envsubst') {
                    sh (
                        label: "Render Cloud Run manifest",
                        script: '''
                            envsubst < cicd/environments/$environment/cloudrun.yaml > cloudrun.yaml
                        '''
                    )
                    sh ("cat cloudrun.yaml")
                }
            }
            post {
                unsuccessful {
                    script{
                        googleChat.unsuccessfullNotification('google-chat-wh')
                    }
                }
            }
        }

        stage ("Deploy Cloud Run") {
            when { branch pattern: "dev|qas|pro|feat/cicd", comparator: "REGEXP" }
            steps {
                container ('gcloud') {
                    sh (
                        label: "Validación Cloud Run",
                        script: """
                            gcloud run services replace cloudrun.yaml \
                            --region ${environmentVariables[env.environment]["SERVICE_REGION"]} \
                            --project ${environmentVariables[env.environment]["SERVICE_PROJECT"]} --dry-run
                        """
                    )
                    sh (
                        label: "Despliegue Cloud Run",
                        script: """
                            gcloud run services replace cloudrun.yaml \
                            --region ${environmentVariables[env.environment]["SERVICE_REGION"]} \
                            --project ${environmentVariables[env.environment]["SERVICE_PROJECT"]}
                        """
                    )
                }
            }
            post {
                success {
                    script{
                        googleChat.successfullNotification('google-chat-wh')
                    }
                }
                unsuccessful {
                    script{
                        googleChat.unsuccessfullNotification('google-chat-wh')
                    }
                }
            }
        }

    }
}
```

