# Description
Project to demonstrate how to create GKE cluster and deploy container using terraform and jenkins

# Pre-requisites
•	CLI Tools on Jenkins and local 
	• Terraform
	• Docker
	• Kubectl
	• Git

• Terraform files are used to create infrastructure in GCP.
• Dockerfile and index.html files are used to build docker image.
• Deployment in GKE is created using deployment.yaml
• Services in GKE is created using services.yaml
    
# Steps to spin-up infrastructure
1. Create a job of kind pipeline in jenkins.
2. Check the box "This project is parameterized".
3. Select the parameter type as choice
4. Give the name of the parameter as "action" and choices as "apply" and "destroy"
5. Provide the github repository link, branch and jenkinsfile path in the given space. Save.
6. Click build with parameters and select apply.

This will create the infrastructure in GCP.

# Steps to deploy container to GKE and exposing it to internet
1. Create a job of kind pipeline in Jenkins.
2. Provide the github repository link, branch and jenkinsfile path in the given space. Save.
3. Click build

This pipeline builds the docker image, pushes it to GCR, creates a deployment in GKE and exposes it to the internet.
By clicking on the IP address of the service, the static website can be accessed.
