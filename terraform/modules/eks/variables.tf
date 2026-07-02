variable "project_name" {
  type = string
}
variable "environment" {
  type = string
}
variable "cluster_version" {
  type    = string
  default = "1.30"
}
variable "private_subnet_ids" {
  type = list(string)
}
variable "public_subnet_ids" {
  type = list(string)
}
variable "eks_cluster_role_arn" {
  type = string
}
variable "eks_nodes_role_arn" {
  type = string
}
variable "cluster_sg_id" {
  type = string
}
variable "node_sg_id" {
  type = string
}
variable "node_instance_types" {
  type    = list(string)
  default = ["t3.medium"]
}
variable "node_desired_size" {
  type    = number
  default = 2
}
variable "node_min_size" {
  type    = number
  default = 2
}
variable "node_max_size" {
  type    = number
  default = 6
}
variable "node_disk_size" {
  type    = number
  default = 30
}
