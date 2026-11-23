
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

            emailext(
                to: 'barbouch4@gmail.com',
                subject: "SUCCESS: ${env.JOB_NAME} - Build #${env.BUILD_NUMBER}",
                mimeType: 'text/html',
                body: """
                    <h2 style="color:green;">BUILD SUCCESS</h2>
                    <p>Bonjour,</p>
                    <p>Le pipeline <b>${env.JOB_NAME}</b> a ete execute avec succes.</p>
                    <ul>
                        <li>Build : #${env.BUILD_NUMBER}</li>
                        <li>Resultat : SUCCESS</li>
                        <li>Projet : appGestionDesProjets</li>
                    </ul>
                    <p>Le fichier JAR a ete genere avec succes.</p>
                    <p><a href="${env.BUILD_URL}">Consulter le build Jenkins</a></p>
                """
            )
        }

        failure {
            echo 'BUILD FAILURE - Verifier les erreurs'

            emailext(
                to: 'barbouch4@gmail.com',
                subject: "FAILURE: ${env.JOB_NAME} - Build #${env.BUILD_NUMBER}",
                mimeType: 'text/html',
                body: """
                    <h2 style="color:red;">BUILD FAILURE</h2>
                    <p>Bonjour,</p>
                    <p>Le pipeline <b>${env.JOB_NAME}</b> a echoue.</p>
                    <ul>
                        <li>Build : #${env.BUILD_NUMBER}</li>
                        <li>Resultat : FAILURE</li>
                        <li>Projet : appGestionDesProjets</li>
                    </ul>
                    <p>Veuillez verifier les erreurs dans la console Jenkins.</p>
                    <p><a href="${env.BUILD_URL}">Consulter le build Jenkins</a></p>
                """
            )
        }
    }
}
