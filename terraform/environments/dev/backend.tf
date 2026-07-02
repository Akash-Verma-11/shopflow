terraform {
  backend "s3" {
    bucket       = "shopflow-terraform-state-282538118471"
    key          = "shopflow/dev/terraform.tfstate"
    region       = "ap-south-1"
    use_lockfile = true
    encrypt      = true
  }
}
