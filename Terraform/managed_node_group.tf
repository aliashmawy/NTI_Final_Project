module "eks_managed_node_group" {
  source = "terraform-aws-modules/eks/aws//modules/eks-managed-node-group"

  name            = "managed-nodes"
  cluster_name    = module.eks.cluster_name
  cluster_version = module.eks.cluster_version

  subnet_ids = module.vpc.private_subnets

  cluster_primary_security_group_id = module.eks.cluster_primary_security_group_id
  vpc_security_group_ids            = [module.eks.node_security_group_id]

  min_size     = 2
  max_size     = 3
  desired_size = 2

  instance_types = ["t3.medium"]
  capacity_type  = "SPOT"

  cluster_service_cidr = module.eks.cluster_service_cidr

  labels = {
    Environment = "test"
    GithubRepo  = "terraform-aws-eks"
    GithubOrg   = "terraform-aws-modules"
  }

  taints = {}

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
  depends_on = [module.eks]
}