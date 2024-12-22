module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "worker-vpc"
  cidr = "10.0.0.0/16"

  azs            = ["us-east-1a"]
  public_subnets = ["10.0.101.0/24"]

}