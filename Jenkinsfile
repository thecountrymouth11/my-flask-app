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
				sh '''
				# Use bash to enable 'source' command
				bash -c "
				python3 -m venv venv
				source venv/bin/activate
				pip install --upgrade pip
				pip install -r requirements.txt
				"
				'''
			}
		}
		stage('Run Tests') {
			steps {
				sh '''
				bash -c "
				source venv/bin/activate
				pytest tests/ --verbose
				"
				'''				
			}
		}
		stage('Build Docker Image') {
			when {
				branch 'main'
			}
			steps {
				script {
					sh 'docker.build -t my-flask-app:${BUILD_ID} .'
				}
			}	
		}
		stage('Deploy') {
			when {
				branch 'main'
			}
			steps {
				sh 'docker run -d -p 5000:5000 my-flask-app:${BUILD_ID}'
			}
		}
	}
}
