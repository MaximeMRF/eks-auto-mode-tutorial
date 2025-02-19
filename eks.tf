module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.31"

  cluster_name    = var.cluster.name
  cluster_version = var.cluster.version

  cluster_endpoint_public_access = var.cluster.endpoint_public_access

  # enable the cluster creator to have admin permissions
  enable_cluster_creator_admin_permissions = true

  cluster_compute_config = {
    # this enable the auto mode for the cluster
    enabled    = true
    node_pools = ["general-purpose"]
  }

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  tags = local.tags
}
