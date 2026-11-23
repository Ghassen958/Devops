
pipeline {
    agent any

    stages {
        stage('1 - Checkout') {
            steps {
                echo 'Recuperation du code GitHub'
                checkout scm
            }
        }

        stage('2 - Build et Package') {
            steps {
                dir('backend') {
                    echo 'Nettoyage et generation du JAR'
                    sh 'mvn clean package -DskipTests'
                }
            }
        }
    }

    post {
        success {
            echo 'BUILD SUCCESS - JAR genere avec succes'
        }

        failure {
            echo 'BUILD FAILURE - Verifier les erreurs'
        }
    }
}
