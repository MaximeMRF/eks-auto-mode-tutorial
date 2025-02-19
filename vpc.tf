module "vpc" {

  source  = "terraform-aws-modules/vpc/aws"
  version = ">=5.17.0"

  name            = "${local.prefix}-vpc"
  cidr            = var.network.cidr
  azs             = var.network.azs
  private_subnets = var.network.private_subnets
  public_subnets  = var.network.public_subnets

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  public_subnet_tags = {
    "Name"                   = "${local.prefix}-public-subnet"
    "kubernetes.io/role/elb" = "1"
  }

  private_subnet_tags = {
    "Name"                            = "${local.prefix}-private-subnet"
    "kubernetes.io/role/internal-elb" = "1"
  }

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
