data "aws_eks_cluster_auth" "main" {
  name = module.eks.cluster_name
}

resource "helm_release" "argocd" {
  depends_on       = [module.eks_managed_node_group]
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = "4.5.2"
  namespace        = "argocd"
  create_namespace = true
  values           = [file("${path.module}/values_argocd.yaml")]
  set = [
    {
      name  = "server.service.type"
      value = "LoadBalancer"
    },


    {
      name  = "server.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-type"
      value = "nlb"
    }
  ]
}


data "kubernetes_service" "argocd_server" {
  metadata {
    name      = "argocd-server"
    namespace = helm_release.argocd.namespace
  }
}

data "external" "argocd_password" {
  program = ["bash", "${path.module}/argocd_pass.sh"]
}