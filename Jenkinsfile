node("master") {
    try {
        def IS_MODIFIED = false

        stage('prepare') {
            git credentialsId: '9960d055-df1c-474a-ac3b-5bfdfbd4d59d', url: 'https://github.com/bkvin/qualite-laravel.git', branch: 'master'
        }

        stage('build'){
            // sh "composer install"
        }

        stage('test') {
            // sh "./vendor/bin/phpunit"
        }

        stage('git'){

            GIT_MERGE = sh(returnStdout: true, script: 'git merge origin/dev').trim()

            if (GIT_MERGE != "Already up-to-date.") {
               IS_MODIFIED = true

                withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: '9960d055-df1c-474a-ac3b-5bfdfbd4d59d', usernameVariable: 'GIT_USERNAME', passwordVariable: 'GIT_PASSWORD']]) {

                    sh('git push https://${GIT_USERNAME}:${GIT_PASSWORD}@github.com/bkvin/qualite-laravel.git')
                }
            }
        }

        stage('deploy'){

            withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'cd435227-8d21-43c6-ad40-7a24dff92abd', usernameVariable: 'FTP_USERNAME', passwordVariable: 'FTP_PASSWORD']]) {

                if(IS_MODIFIED) {
                    sh('git ftp push --user ${FTP_USERNAME} --passwd ${FTP_PASSWORD} ftp://46.105.92.169/test/')
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
