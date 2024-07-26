pipeline {
    agent any
    
    stages {
        stage('Clone Project') {
            steps {
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'github-token', url: 'https://github.com/sanciajerin/Petclinic.git']])
            }
        }
        stage('Build Project') {
            steps {
                sh 'mvn package'
            }
        }
        stage('Code Review') {
            steps {
                withSonarQubeEnv('sonar-server 10.6') {
                    sh 'mvn clean package sonar:sonar'
                }
            }
        }
        stage('Upload to Artifacts') {
            steps {
                nexusArtifactUploader artifacts: [[artifactId: 'spring-framework-petclinic', classifier: '', file: 'target/petclinic.war', type: 'war']], credentialsId: 'nexus-repo', groupId: 'devops-project', nexusUrl: 'localhost:8081', nexusVersion: 'nexus3', protocol: 'http', repository: 'devops-project', version: '01-SNAPSHOT'
            }
        }
        stage('Build and Push to Docker Image') {
            steps {
                script{
                    withDockerRegistry(credentialsId: 'Docker-hub', toolName: 'Docker-24') {
                        sh 'docker build -t New-Petclinic -f docker/Dockerfile .'
                        sh 'docker tag New-Petclinic jerinvarghese1993/New-Petclinic'
                        sh 'docker push jerinvarghese1993/New-Petclinic'
                    }
                }
                
            }
        }
    }
}
