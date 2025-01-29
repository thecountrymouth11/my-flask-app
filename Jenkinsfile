pipeline {
	agent any
	
	stages {
		stage('Checkout') {
			steps {
				git url: 'https://github.com/thecountrymouth11/my-flask-app.git', branch: 'main'
			}
		}
		stage('Install Dependencies') {
			steps {
				sh 'pip install -r requirements.txt'
			}
		}
		stage('Run Tests') {
			steps {
				sh 'pytest tests/ --verbose'
			}
		}
		stage('Build Docker Image') {
			when {
				expression { env.GIT_BRANCH == 'main' }
			}
			steps {
				script {
					docker.build("my-flask-app:${env.BUILD_ID}")
				}
			}	
		}
		stage('Deploy') {
			when {
				expression { env.GIT_BRANCH == 'main' }
			}
			steps {
				sh 'docker run -d -p 5000:5000 my-flask-app:${BUILD_ID}'
			}
		}
	}
}
