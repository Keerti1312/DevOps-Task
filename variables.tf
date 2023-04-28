variable "project-id"{
    type = string
    default = "es-devops-sb"
}

variable "vpc-name" {
    type = string
    default = "task-vpc-network"
}

variable "firewall-name" {
    type = string
    default = "task-firewall"
}

variable "subnet-name" {
    type = string
    default = "task-subnet"
}

variable "subnet-cidr" {
    type = string
    default = "10.20.0.0/24"
}

variable "region" {
    type = string
    default = "us-central1"
}

variable "cluster_name" {
    type = string
    default = "task-cluster"
  
}

variable "zone" {
    type = string
    default = "us-central1-a"
  
}

variable "pods-ip" {
    type = string
    default = "10.1.0.0/16"
}

variable "services-ip" {
    type = string
    default = "10.2.0.0/20"
  
}

