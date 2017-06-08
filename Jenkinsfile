node("master") {
    try {
        def IS_MODIFIED = false

        stage('Checkout') {
            git credentialsId: '6ded69f4-030c-4cf1-b82b-39b744a0063f', url: 'https://github.com/hanaking/laravel.git', branch: 'master'
        }

        stage('Install dependencies'){
             // sh "composer install"
        }

        stage('test') {
             // sh "./vendor/bin/phpunit"
        }
        stage('deploiement'){
        //  if test phpunit oki alor deploiement

            withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'cd435227-8d21-43c6-ad40-7a24dff92abd', usernameVariable: 'FTP_USERNAME', passwordVariable: 'FTP_PASSWORD']]) {

            if(IS_MODIFIED) {
                sh('git ftp push --user ${FTP_USERNAME} --passwd ${FTP_PASSWORD} ftp://192.168.33.20/Dev/')
            }
        }




 }

    } catch(error) {
        throw error
    } finally {

        stage('cleanup') {
            // Recursively delete all files and folders in the workspace
            // using the built-in pipeline command
            deleteDir()
        }
    }
}
