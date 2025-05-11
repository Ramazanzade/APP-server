pipeline {
    agent any

    environment {
        REGISTRY = 'ramazanzada'
        TAG = "${new Date().format('yyyyMMddHHmmss')}"
    }

    stages {
        stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                }
            }
        }

        stage('Build & Push Backend') {
            steps {
                dir('backend') {
                    sh """
                    docker build -t ${REGISTRY}/backend:${TAG} .
                    docker tag ${REGISTRY}/backend:${TAG} ${REGISTRY}/backend:latest
                    docker push ${REGISTRY}/backend:${TAG}
                    docker push ${REGISTRY}/backend:latest
                    """
                }

                dir('backend/manifests') {
                    sh """
                    sed -i 's|image: ${REGISTRY}/backend:.*|image: ${REGISTRY}/backend:${TAG}|' deployment.yaml
                    """
                }
            }
        }

        stage('Build & Push Frontend') {
            steps {
                dir('frontend') {
                    sh """
                    docker build -t ${REGISTRY}/frontend:${TAG} .
                    docker tag ${REGISTRY}/frontend:${TAG} ${REGISTRY}/frontend:latest
                    docker push ${REGISTRY}/frontend:${TAG}
                    docker push ${REGISTRY}/frontend:latest
                    """
                }

                dir('frontend/manifests') {
                    sh """
                    sed -i 's|image: ${REGISTRY}/frontend:.*|image: ${REGISTRY}/frontend:${TAG}|' deployment.yaml
                    """
                }
            }
        }

        stage('Build & Push Admin') {
            steps {
                dir('admin') {
                    sh """
                    docker build -t ${REGISTRY}/admin:${TAG} .
                    docker tag ${REGISTRY}/admin:${TAG} ${REGISTRY}/admin:latest
                    docker push ${REGISTRY}/admin:${TAG}
                    docker push ${REGISTRY}/admin:latest
                    """
                }

                dir('admin/manifests') {
                    sh """
                    sed -i 's|image: ${REGISTRY}/admin:.*|image: ${REGISTRY}/admin:${TAG}|' deployment.yaml
                    """
                }
            }
        }

        stage('Git Commit and Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'github-token', usernameVariable: 'GIT_USER', passwordVariable: 'GIT_TOKEN')]) {
                    sh """
                    git config user.email "ci-bot@yourcompany.com"
                    git config user.name "CI/CD Jenkins Bot"
                    git checkout main

                    git add admin/manifests/deployment.yaml frontend/manifests/deployment.yaml backend/manifests/deployment.yaml
                    git commit -m "Update image tags to ${TAG}" || echo "No changes to commit"
                    git remote set-url origin https://${GIT_USER}:${GIT_TOKEN}@github.com/Ramazanzade/APP-server.git
                    git push origin main
                    """
                }
            }
        }
    }

    post {
        success {
            echo "✅ Build və push uğurla tamamlandı!"
        }

        failure {
            echo "❌ Pipeline uğursuz oldu."
        }

        always {
            cleanWs()
        }
    }
}
