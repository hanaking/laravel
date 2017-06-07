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

        stage('git'){

            GIT_MERGE = sh(returnStdout: true, script: 'git merge origin/dev').trim()

            if (GIT_MERGE != "Already up-to-date.") {
               IS_MODIFIED = true

                withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: '6ded69f4-030c-4cf1-b82b-39b744a0063f', usernameVariable: 'GIT_USERNAME', passwordVariable: 'GIT_PASSWORD']]) {

                    sh('git push https://${GIT_USERNAME}:${GIT_PASSWORD}@github.com/hanaking/laravel.gi')
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
