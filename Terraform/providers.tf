terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.95.0"
    }
    argocd = {
      source  = "jojand/argocd"
      version = "2.3.2"
    }
  }
  backend "s3" {
    bucket = "final-project-tf-state-ali"
    key    = "project/state.tfstate"
    region = "us-east-1"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

provider "helm" {
  kubernetes = {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    token                  = data.aws_eks_cluster_auth.eks.token
  }
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.eks.token
}

provider "argocd" {
  server_addr = data.kubernetes_service.argocd_server.status[0].load_balancer[0].ingress[0].hostname
  username    = "admin"
  password    = data.external.argocd_password.result["password"]
  insecure    = true
}