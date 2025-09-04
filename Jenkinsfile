pipeline {
    agent any
    environment {
        DOCKER_HUB_REPO = "igosain/studybuddy"
        DOCKER_HUB_CREDENTIALS_ID = "dockerhub-token"
        IMAGE_TAG = "v${BUILD_NUMBER}"
        GROQ_API_KEY = credentials('groq-api-key')
    }
    stages {
        stage('Checkout Github') {
            steps {
                echo 'Checking out code from GitHub...'
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'github-token', url: 'https://github.com/Igosain08/study-buddy-ai.git']])
            }
        }        
        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                script {
                    sh """
                    docker build -t ${DOCKER_HUB_REPO}:${IMAGE_TAG} .
                    docker tag ${DOCKER_HUB_REPO}:${IMAGE_TAG} ${DOCKER_HUB_REPO}:latest
                    """
                }
            }
        }
        stage('Push Image to DockerHub') {
            steps {
                echo 'Pushing Docker image to DockerHub...'
                script {
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-token', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh """
                        echo ${DOCKER_PASSWORD} | docker login -u ${DOCKER_USERNAME} --password-stdin
                        docker push ${DOCKER_HUB_REPO}:${IMAGE_TAG}
                        docker push ${DOCKER_HUB_REPO}:latest
                        """
                    }
                }
            }
        }
        stage('Update Deployment YAML with New Tag') {
            steps {
                script {
                    sh """
                    sed -i 's|image: igosain/studybuddy:.*|image: igosain/studybuddy:${IMAGE_TAG}|' manifests/deployment.yaml
                    """
                }
            }
        }

        stage('Commit Updated YAML') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'github-token', usernameVariable: 'GIT_USER', passwordVariable: 'GIT_PASS')]) {
                        sh '''
                        git config user.name "Igosain08"
                        git config user.email "igosain@ucsd.edu"
                        git add manifests/deployment.yaml
                        git commit -m "Update image tag to ${IMAGE_TAG}" || echo "No changes to commit"
                        git push https://${GIT_USER}:${GIT_PASS}@github.com/Igosain08/study-buddy-ai.git HEAD:main
                        '''
                    }
                }
            }
        }
        stage('Install Kubectl & ArgoCD CLI Setup') {
            steps {
                sh '''
                echo 'Installing Kubectl & ArgoCD CLI...'
                curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
                chmod +x kubectl
                mv kubectl /usr/local/bin/kubectl
                curl -sSL -o /tmp/argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
                chmod +x /tmp/argocd-linux-amd64
                mv /tmp/argocd-linux-amd64 /usr/local/bin/argocd
                '''
            }
        }
        stage('Apply Kubernetes & Sync App with ArgoCD') {
            steps {
                script {
                    withCredentials([file(credentialsId: 'kubeconfig-file', variable: 'KUBECONFIG_FILE')]) {
                        sh '''
                        # Set kubeconfig from file
                        export KUBECONFIG=$KUBECONFIG_FILE
                        
                        # Install ArgoCD CLI
                        curl -sSL -o /tmp/argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
                        chmod +x /tmp/argocd-linux-amd64
                        mv /tmp/argocd-linux-amd64 /usr/local/bin/argocd
                        
                        # Get ArgoCD server details
                        ARGOCD_SERVER=$(kubectl get svc argocd-server -n argocd -o jsonpath='{.spec.clusterIP}')
                        ARGOCD_PORT=$(kubectl get svc argocd-server -n argocd -o jsonpath='{.spec.ports[0].port}')
                        
                        # Login to ArgoCD
                        argocd login $ARGOCD_SERVER:$ARGOCD_PORT --username admin --password $(kubectl get secret -n argocd argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d) --insecure
                        
                        # Apply Kubernetes manifests
                        kubectl apply -f manifests/deployment.yaml
                        kubectl apply -f manifests/service.yaml
                        
                        # Create secret for GROQ API key if it doesn't exist
                        kubectl create secret generic groq-api-secret \
                          --from-literal=GROQ_API_KEY="${GROQ_API_KEY}" \
                          -n argocd --dry-run=client -o yaml | kubectl apply -f -
                        
                        # Sync ArgoCD application
                        argocd app sync studybuddy-app --insecure
                        
                        echo "ArgoCD sync completed successfully!"
                        '''
                    }
                }
            }
        }
    }
}