pipeline{
    agent any
    tools{
        maven 'mvn3.9.9'
    }
    stages{
        stage('Build Maven'){
            steps{
               checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/JAYAKUMARRAMAR/devops-integration']])
               sh 'mvn clean install'
            }
        }
        stage('Build docker image'){
            steps{
                script{
                    sh 'docker build -t jayakumarramar/devops-integration .'
                }
            }
        }
        stage('Push image to Hub'){
            steps{
                script{
                    withCredentials([string(credentialsId: 'dockerhub-pwd', variable: 'dockerhubpwd')]) {
                   sh 'docker login -u jayakumarramar -p ${dockerhubpwd}'
}
                    sh 'docker push jayakumarramar/devops-integration'
                }
            }
        }
    }
}