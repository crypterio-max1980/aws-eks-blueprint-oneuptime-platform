
terraform {
  backend "s3" {
    bucket = "apps-terraform-clusters"
    key    = "eks-cluster-btcpay/terraform.tfstate"
    region = "eu-central-1"
  }
}
