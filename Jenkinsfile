pipeline{

agent any

tools{
    maven 'maven-3.9.8'
}

stages{
    stage('CodeCheckOut'){
        steps{
            checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[credentialsId: 'Github_Credentials', url: 'https://github.com/Zainulla75117/spring-boot-mongo-docker.git']])
        }
    }
    stage('Build'){
        steps{
            sh "mvn clean package"
        }
    }
    stage('DockerBuild'){
        steps{
            sh "docker build -t zain75117/springupdate:${env.BUILD_NUMBER} ."
        }
    }
    stage('DockerPush'){
        steps{
            sh "docker push zain75117/springupdate:${env.BUILD_NUMBER}"
        }
    }
    stage('K8s Deploy'){
        steps{
            sh "kubectl apply -f deployment.yaml"
            sh "kubectl apply -f services.yaml"
        }
    }
    stage('Know Details'){
        steps{
            sh "kubectl get all -o wide -n prac-ns"
        }
    }
        
    

}//stages

}//pipeline