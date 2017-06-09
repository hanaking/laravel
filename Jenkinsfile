node("master") {
    try {
        def IS_Tested = false

        stage('Checkout') {
            sh 'git config --global user.email "stephane.guillaume71@gmail.com"'
            sh 'git config --global user.name "hanaking"'
            git credentialsId: 'b132cde9-73a0-4bbc-9fe4-7404b9575489', url: 'https://github.com/hanaking/laravel.git', branch: 'master'
        }

        stage('Install dependencies'){
              sh "composer install"
              sh 'php artisan config:cache'
        }

        stage('test') {
              sh " ./vendor/bin/phpunit"
        }
        stage('verif duplicate code') {
              sh " ./vendor/bin/phpcpd app"
        }
        stage('behat') {
  //  if test phpunit oki alor deploiement
             sh "./vendor/bin/behat"
        }
        stage('documentation') {
            sh('php phpDocumentor.phar -d app -t public/documentations --template="responsive-twig"')
        }
        stage('metrics') {
            sh 'php ./vendor/bin/phpmetrics --report-html=./public/metrics ./app'
        }

        stage('mise à jour git'){
          sh 'git add -A && git commit -m "documentation"'
          withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'b132cde9-73a0-4bbc-9fe4-7404b9575489', usernameVariable: 'GIT_USERNAME', passwordVariable: 'GIT_PASSWORD']]) {
              sh('git push https://${GIT_USERNAME}:${GIT_PASSWORD}@github.com/hanaking/laravel.git')
            }
        }
        stage('deploiement'){
        //  if test phpunit oki alor deploiement

              IS_Tested = true

            withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: '12840de8-64c4-4f14-a675-ddeab6631ebd', usernameVariable: 'FTP_USERNAME', passwordVariable: 'FTP_PASSWORD']]) {

              if(IS_Tested) {
                sh "git config git-ftp.url ftp://192.168.33.20/"
                sh "git config git-ftp.user ${FTP_USERNAME}"
                sh "git config git-ftp.password ${FTP_PASSWORD}"

                try{
                    sh "git ftp push"
                }catch(error) {
                    sh "git ftp init"
                }
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
