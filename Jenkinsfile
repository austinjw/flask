pipeline {
  agent any
  environment {
    GITHUB_PAT = credentials('github-pat')
  }
  stages {
    stage('Scan') {
      steps {
        sh '''
          /opt/codeql/codeql database create /codeql-dbs/example-repo-multi \
          --db-cluster --language javascript,python --overwrite

          for language in javascript python; do
            /opt/codeql/codeql database analyze "/codeql-dbs/example-repo-multi/$language" \
            "$language-code-scanning.qls" --sarif-category="$language" \
            --format=sarif-latest --output="/tmp/example-repo-$language.sarif"
          done
        '''
      }
    }
    stage('Upload'){
      steps {
        sh '''
          for language in javascript python; do
            echo $GITHUB_PAT | /opt/codeql/codeql github upload-results --ref=refs/heads/main \
              --sarif="/tmp/example-repo-$language.sarif" --github-auth-stdin
          done
        '''
      }
    }
  }
}
