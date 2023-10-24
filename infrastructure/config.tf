variable "aws_region" {
   default = "eu-central-1"
}
data "aws_availability_zones" "available_zones" {
  state = "available"
}
variable "project" {
   default = "mlops-cicd-tf-workshop"
}
variable "log_group_name" {
   default = "ecs/mlops"
}
variable "user_name" {
  default     = "raza" # You can set a default value or provide it when running Terraform.
}
variable "validity" {
   default = "2"
}



