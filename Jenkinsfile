
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

        stage('3 - Docker Build') {
            steps {
                echo 'Construction de l image Docker'
                sh 'docker build -t studentmang-app:latest .'
            }
        }

        stage('4 - Docker Push') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'dockerhub-credentials',
                        usernameVariable: 'DOCKERHUB_USER',
                        passwordVariable: 'DOCKERHUB_TOKEN'
                    )
                ]) {
                    sh '''
                        set +x
                        echo "$DOCKERHUB_TOKEN" | docker login -u "$DOCKERHUB_USER" --password-stdin
                        docker tag studentmang-app:latest "$DOCKERHUB_USER/studentmang-app:latest"
                        docker push "$DOCKERHUB_USER/studentmang-app:latest"
                        docker logout
                    '''
                }
            }
        }
    }

    post {
        success {
            echo 'BUILD SUCCESS - Image Docker publiee'

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
                    <p>Le JAR a ete genere et l'image Docker publiee sur Docker Hub.</p>
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
