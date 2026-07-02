variable "project_name" {
  type = string
}
variable "environment" {
  type = string
}
variable "private_subnet_ids" {
  type = list(string)
}
variable "rds_sg_id" {
  type = string
}
variable "db_name" {
  type    = string
  default = "shopflowdb"
}
variable "db_username" {
  type    = string
  default = "shopflow"
}
variable "db_password" {
  type      = string
  sensitive = true
}
variable "instance_class" {
  type    = string
  default = "db.t3.small"
}
variable "allocated_storage" {
  type    = number
  default = 20
}
variable "multi_az" {
  type    = bool
  default = true
}
variable "backup_retention_days" {
  type    = number
  default = 7
}
variable "postgres_version" {
  type    = string
  default = "16.13"
}
