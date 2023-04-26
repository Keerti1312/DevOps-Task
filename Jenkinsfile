pipeline{
    agent any
    stages{
        stage('terraform init'){
            steps{
                sh'terraform init'
            }
        }

        stage('terraform plan'){
            steps{
                sh'terraform plan'
            }
        }

        stage('terraform action'){
            steps{
                echo 'terraform action from the parameter is ${action}'
                sh 'terraform ${action} --auto-approve'
            }
        }
    }

    post { 
            success { 
                echo "Build is successfull" 
            } 
            failure { 
                echo "Build failed" 
            }
        }
}


