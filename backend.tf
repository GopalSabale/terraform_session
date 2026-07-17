terraform {
  backend "s3" {
    region = "us-east-1"
    bucket = "terraform-demo001"
    key    = "demo/terraform.tfstate"
  }
}
