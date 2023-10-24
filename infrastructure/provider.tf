terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         	   = "terraform-workshop-mlreply"
    key              	   = "raza/terraform.tfstate"
    region         	   = "eu-central-1"
  }
}

