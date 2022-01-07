pipeline{
    agent any
    environment{
        IMAGE_NAME='devopstrainer/java-mvn-privaterepos:$BUILD_NUMBER'
    }
    stages{
        stage("BUILD THE DOCKER IMAGE"){
            steps{
                script{
                    echo "BUILDING THE DOCKER IMAGE"
                withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                    sh 'sudo yum install docker -y'
                    sh 'sudo systemctl start docker'
                    sh "sudo docker build -t  ${IMAGE_NAME} ."
                    sh 'sudo docker login -u $USER -p $PASS'
                    sh "sudo docker push ${IMAGE_NAME}"
                }
                }
            }
        }
        stage("DEPLOY THE PHP APP"){
            steps{
                script{
                    echo "DEPLOY THE PHP APP THRU DOCKER COMPOSE"
                }
            }
        }
    }
}