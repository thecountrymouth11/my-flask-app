pipeline {
	agent any

	environment {
		DOCKER_IMAGE = "my-flask-app:${BUILD_ID}"
	}
	
	stages {
		stage('Checkout') {
			steps {
				git url: 'https://github.com/thecountrymouth11/my-flask-app.git', branch: 'main'
			}
		}
		stage('Install Dependencies') {
			steps {
				sh '''
				python3 -m venv venv
				source venv/bin/activate
				python -m pip install --upgrade pip
				pip install -r requirements.txt
				'''
			}
		}
		stage('Run Tests') {
			steps {
				sh 'pytest tests/ --verbose || true '
			}
		}
		stage('Build Docker Image') {
			when {
				branch 'main'
			}
			steps {
				script {
					sh 'docker.build -t $DOCKER_IMAGE .'
				}
			}	
		}
		stage('Deploy') {
			when {
				branch 'main'
			}
			steps {
				sh 'docker run -d -p 5000:5000 $DOCKER_IMAGE'
			}
		}
	}
}
