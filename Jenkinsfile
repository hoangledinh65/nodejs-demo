pipeline {
    agent any

    // tools { 
    //     maven 'my-maven' 
    //     jdk 'my-jdk' 
    // }

    environment {
        DOCKERHUB_CREDENTIALS=credentials('dockerhub')
    }
    stages {

        stage('Initialize') {
            steps {
                sh '''
                    echo "PATH = ${PATH}"
                    echo "M2_HOME = ${M2_HOME}"
                ''' 
            }
        }
        stage ('Test app.js file') {
            agent {
                docker { 
                    image 'node:latest'
                }
            }

            steps {
                sh 'echo test stage'
                sh 'npm install -y'
                sh 'node app.js &'
                sh 'node --version'
            }
        }
        stage('Build') {
            steps {
                echo 'Building nodejs image..'
                sh 'docker build -t hoangledinh65/nodejs-image:1.0 .'
                
            }
        }
        stage('Pushing image') {
            steps {
                echo 'Start pushing.. with credential'
                sh 'echo $DOCKERHUB_CREDENTIALS'
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
                sh 'docker push hoangledinh65/nodejs-image:1.0'
                
            }
        }
        stage('Deploying and Cleaning') {
            steps {
                echo 'Deploying and cleaning'
                sh 'docker image rm hoangledinh65/nodejs-image:1.0 || echo "this image does not exist" '
                sh 'docker container stop my-demo-nodejs || echo "this container does not exist" '
                sh 'docker network create jenkins || echo "this network exists"'
                sh 'echo y | docker container prune '
                sh 'echo y | docker image prune'
                sh 'docker container run -d --rm --name my-demo-nodejs -p 3000:8080 --network jenkins hoangledinh65/nodejs-image:1.0'
            }
        }
    }
}