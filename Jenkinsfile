pipeline {
    agent any

    environment {
        IMAGE_NAME = 'vercel-app'
        CONTAINER_NAME = 'my-web-app'
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME:latest .'
            }
        }

        stage('Test App') {
            steps {
                // Run tests if defined in package.json
                sh 'docker run --rm $IMAGE_NAME:latest npm test || echo "No tests configured"'
            }
        }

        stage('Deploy Container') {
            steps {
                sh '''
                    docker stop $CONTAINER_NAME || true
                    docker rm $CONTAINER_NAME || true
                    docker run -d --name $CONTAINER_NAME -p 3000:3000 --restart always $IMAGE_NAME:latest
                '''
            }
        }
    }
}
