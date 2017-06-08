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

            withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: '12840de8-64c4-4f14-a675-ddeab6631ebd', usernameVariable: 'FTP_USERNAME', passwordVariable: 'FTP_PASSWORD']]) {

              if(IS_MODIFIED) {
                sh "git config git-ftp.url ftp://192.168.33.20/Dev/"
                sh "git config git-ftp.user ${FTP_USERNAME}"
                sh "git config git-ftp.password ${FTP_PASSWORD}"
                sh "git ftp init"
                sh "git ftp push"

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
