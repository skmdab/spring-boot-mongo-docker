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
                withCredentials([string(credentialsId: 'DOCKER_CREDS', variable: 'DOCKER_PASSWORD')]) {
                   sh "docker login -u skmdab -p ${DOCKER_PASSWORD}"
                   sh "docker push skmdab/springboot"
                }
            }
        }   

        stage('Push springboot.yaml file into k8s cluster'){
            steps{
                sshagent(['ubuntu_creds']) {
                    sh "scp -o StrictHostKeyChecking=no springBootMongo.yml ubuntu@13.127.219.130:/home/ubuntu/"
                }
            }
        }

        stage('Deploying Springboot app to K8s cluster'){
            steps{
                withCredentials([file(credentialsId: 'pemfile', variable: 'PEMFILE')]) {
                   sh "ssh -i ${PEMFILE} ubuntu@13.127.219.130 kubectl apply -f springBootMongo.yml"
                }
            }
        }
    }
}
