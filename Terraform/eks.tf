module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "final-project"
  cluster_version = "1.31"
  # Use only Addons managed by AWS
  bootstrap_self_managed_addons = false

  cluster_addons = {
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  # Optional: Makes the Kubernetes API publicly accessible so you can kubectl from your local.
  cluster_endpoint_public_access = true

  # Optional: Adds the current caller identity (Currnet IAM user) as an administrator via cluster access entry
  # Cluster role binding
  enable_cluster_creator_admin_permissions = true

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.private_subnets

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    instance_types = ["t3.medium"]
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
  node_security_group_tags = {
    "kubernetes.io/cluster/final-project" = null
  }
}

# CoreDNS addon (must be after node groups)
resource "aws_eks_addon" "coredns" {
  cluster_name                = module.eks.cluster_name
  addon_name                  = "coredns"
  addon_version               = "v1.11.4-eksbuild.14"
  resolve_conflicts_on_update = "PRESERVE"

  depends_on = [
    module.eks_managed_node_group
  ]
}
data "aws_eks_cluster_auth" "eks" {
  name = module.eks.cluster_name
}