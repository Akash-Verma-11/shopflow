variable "project_name" {
  type    = string
  default = "shopflow"
}
variable "environment" {
  type    = string
  default = "dev"
}
variable "aws_region" {
  type    = string
  default = "ap-south-1"
}
variable "db_password" {
  type      = string
  sensitive = true
}
