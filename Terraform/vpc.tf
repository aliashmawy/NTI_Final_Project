module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.21.0"
  name    = "final-project"
  cidr    = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.3.0/24", "10.0.4.0/24"]

  public_subnet_tags = {
    "kubernetes.io/cluster/final-project" = "shared"
    "kubernetes.io/role/elb"              = "1"
  }
  enable_dns_hostnames = true

  private_subnet_tags = {
    "kubernetes.io/cluster/final-project" = "shared"
    "kubernetes.io/role/internal-elb"     = "1"
  }
  enable_nat_gateway = true
  enable_vpn_gateway = false

  tags = {
    "kubernetes.io/cluster/final-project" = "shared"
    Terraform                             = "true"
  }
}
