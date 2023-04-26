terraform {
  backend "gcs" {
    bucket = "task-demo-bucket"
    prefix = "terraform/state"
    
  }
}

