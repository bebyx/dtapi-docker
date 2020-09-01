pipeline {
    agent any

    stages {
        stage('Prepare') {
            steps {
                // Get some code from a GitHub repository
                git 'https://github.com/bebyx/dtapi_js.git'

                //Install modules
                sh '/usr/bin/npm install'

                // Set environment
                sh 'sed -i "s|https://dtapi.if.ua/api/|http://localhost/api/|" src/environments/environment.ts'
                sh 'sed -i "s|https://dtapi.if.ua/api/|http://localhost/api/|" src/environments/environment.ts'

            }
        }

        //stage('Test') {
        //    steps {
        //        sh '/usr/local/bin/ng test'
        //        sh '/usr/local/bin/ng e2e'
        //    }
        //}

        stage('Build') {
            steps {
                //Build artefacts
                sh '/usr/local/bin/ng build'
                sh 'wget "https://dtapi.if.ua/~yurkovskiy/IF-108/htaccess_example_fe" -O ./dist/IF105/.htaccess'
            }

        }

        stage('Deploy') {
            steps {
                //Run httpd server in docker container
                sh '''
                if docker ps -a | grep fe; then
                    docker rm -vf fe && docker run -dit --name fe -p 8050:80 -v "$PWD/dist/IF105":/usr/local/apache2/htdocs/ httpd:2.4
                else
                    docker run -dit --name fe -p 8050:80 -v "$PWD/dist/IF105":/usr/local/apache2/htdocs/ httpd:2.4
                fi
                '''
            }

        }
    }
}
