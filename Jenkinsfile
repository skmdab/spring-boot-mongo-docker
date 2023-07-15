pipeline{
    
    agent any


    stages{
        stage('Checkout the code'){
            steps{
                git branch: 'testing', url: 'https://github.com/skmdab/spring-boot-mongo-docker.git'
            }
        }

        stage('Build docker image'){
            steps{
                sh "docker build -t skmdab/springboot ."
            }
        }

        stage('Push docker image to dockerhub'){
            steps{
                withCredentials([usernameColonPassword(credentialsId: 'DOCKER_CREDS', variable: 'DOCKER_PASSWORD')]) {
                   sh "docker login -u skmdab -p ${DOCKER_PASSWORD}"
                   sh "docker push skmdab/springboot"
                }
            }
        }   

        stage('Deploying springboot app into k8s cluster'){
            steps{
                sh "kubectl apply -f springBootMongo.yml"
            }
        }
    }
}
