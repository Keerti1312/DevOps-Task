pipeline{
    agent any
    stages{
        stage('Terraform init'){
            steps{
                sh 'terraform init'
            }
        }

        stage('Terraform plan'){
            steps{
                sh 'terraform plan'
            }
        }

        stage('Terraform action'){
            steps{
                echo "the action from the parameter is ${action}"
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


