pipeline{
    agent any
    environment{
        IMAGE_NAME='28141108/java-mvn-privaterepos:php$BUILD_NUMBER'
    }
    stages{
        stage("BUILD THE DOCKER IMAGE"){
            steps{
                script{
                    echo "BUILDING THE DOCKER IMAGE"
                withCredentials([usernamePassword(credentialsId: 'dockhub', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
                    sh 'sudo yum install docker -y'
                    sh 'sudo systemctl start docker'
                    sh "sudo docker build -t  ${IMAGE_NAME} ."
                    sh 'sudo docker login -u $USERNAME -p $PASSWORD'
                    sh "sudo docker push ${IMAGE_NAME}"
                }
                }
            }
        }
        stage("DEPLOY THE PHP APP"){
            steps{
                script{           
    sshagent(['test-server-key']) {
withCredentials([usernamePassword(credentialsId: 'dockhub', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {  
              echo "DEPLOY THE PHP APP THRU DOCKER COMPOSE"
              def ec2Instance = "ec2-user@172.31.12.151"
              def Cmd = "bash ./remote-script.sh ${IMAGE_NAME} ${USERNAME} ${PASSWORD}"
              sh "scp -o StrictHostKeyChecking=no remote-script.sh ${ec2Instance}:/home/ec2-user"
              sh "scp -o StrictHostKeyChecking=no docker-compose.yml ${ec2Instance}:/home/ec2-user"
            sh "ssh -o StrictHostKeyChecking=no ${ec2Instance} ${Cmd}" 
             
           }
            }
        }
    }
}
    }
}