pipeline {
    agent any

    // A few of those parameters could have been stored directly in Jenkins credentials
    environment {
        GIT_REPO = 'https://github.com/shaydevops2024/web-for-assignment.git'
        DOCKER_IMAGE = 'shaydevops2024/docker-leumi'
        K8S_NAMESPACE = 'default'
        K8S_DEPLOYMENT_NAME = 'web-deployment'
        K8S_SERVICE_NAME = 'web-service'
        DOCKER_REGISTRY_CREDENTIALS_ID = 'docker-credentials' //Stored in Jenkins credentials
        KUBECONFIG_PATH = '<PATH-TO-KUBECONFIG>'
        TARGET_INSTANCE = '<IP-OF-SECOND-INSTANCE>'
        SSH_USER = '<USER-OF-INSTANCE>'
        SSH_KEY = '<PATH-TO-SSH-KEY>'
    }

    // Checkout to the Git repo with the web application
    stages {
        stage('Checkout') {
            steps {
                git url: "${GIT_REPO}", branch: 'main'
            }
        }
        // Build the docker image (Dockerfile is in the Git repo)
        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t ${DOCKER_IMAGE} .'
                }
            }
        }
        // Self testing of the wensite to see in the output the it works by using curl
        stage('Test Web App') {
            steps {
                script {
                    sh 'docker run -d -p 80:80 ${DOCKER_IMAGE}'
                    sleep 10 // Wait for the container to start
                    sh 'curl http://localhost:80'
                }
            }
        }
        // push the image to dockerhub, which will be used with k8s
        stage('Push Docker image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'docker-credentials') {
                        sh 'docker push ${DOCKER_IMAGE}'
                    }
                }
            }
        }
        // Deployment and service are created as files first, then it runs them with kubectl
                stage('Deployment on Kubernetes') {
            steps {
                script {
                    writeFile file: 'deployment.yaml', text: """
apiVersion: apps/v1
kind: Deployment
metadata:
    name: ${K8S_DEPLOYMENT_NAME}
    namespace: ${K8S_NAMESPACE}
spec:
    replicas: 1
    selector:
        matchLabels:
            app: web-app
    template:
        metadata:
            labels:
                app: web-app
        spec:
            containers:
            - name: web-app
              image: ${DOCKER_IMAGE}
              ports:
              - containerPort: 80
                    """

                    writeFile file: 'service.yaml', text: """
apiVersion: v1
kind: Service
metadata:
    name: ${K8S_SERVICE_NAME}
    namespace: ${K8S_NAMESPACE}
spec:
    type: LoadBalancer
    ports:
    - port: 443
      targetPort: 80
    selector:
        app: web-app
                    """

                    
                    sh "scp -i ${SSH_KEY} deployment.yaml ${SSH_USER}@${TARGET_INSTANCE}:/tmp/" //Copy the files to the second instance to folder /tmp/
                    sh "scp -i ${SSH_KEY} service.yaml ${SSH_USER}@${TARGET_INSTANCE}:/tmp/"

                    
                    // Deployment the files created to k8s
                    sh "ssh -i ${SSH_KEY} ${SSH_USER}@${TARGET_INSTANCE} 'kubectl --kubeconfig=${KUBECONFIG_PATH} apply --validate=false -f /tmp/deployment.yaml'"
                    sh "ssh -i ${SSH_KEY} ${SSH_USER}@${TARGET_INSTANCE} 'kubectl --kubeconfig=${KUBECONFIG_PATH} apply --validate=false -f /tmp/service.yaml'"
                }
            }
        }
    }

    post { //cleans the workspace after the job finished.
        always {
            cleanWs()
        }
    }
}
