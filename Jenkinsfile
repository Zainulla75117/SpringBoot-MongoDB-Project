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
            sh "docker build -t zain75117/springupdate ."
        }
    }
    stage('DockerPush'){
        steps{
            sh "docker push zain75117/springupdate"
        }
    }
    stage('K8s Deploy'){
        steps{
            script {
                    withCredentials([file(credentialsId: 'Kubernetes-Secret', variable: 'KUBECONFIG')]) {
                        sh '''
                        kubectl --kubeconfig=$KUBECONFIG apply -f deployment.yaml
                        kubectl --kubeconfig=$KUBECONFIG apply -f services.yaml
                        '''
        }
    }
        }
    }

}//stages

}//pipeline