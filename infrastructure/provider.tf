terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         	   = "terraform-workshop-mlreply"
    key              	   = "mlops_handson/<your_name_goes_here>_terraform.tfstate"
    region         	   = "eu-central-1"
  }
}

