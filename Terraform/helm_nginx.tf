resource "helm_release" "nginx-ingress-controller" {
  name       = "nginx-ingress-controller"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx-ingress-controller"
  values     = [file("${path.module}/values_nginx.yaml")]

  set = [
    {
      name  = "service.type"
      value = "LoadBalancer"
    },
    {
      name  = "service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-type"
      value = "nlb"
    }
  ]

}

data "kubernetes_service" "nginx_ingress_service" {
  metadata {
    name      = helm_release.nginx-ingress-controller.name
    namespace = "default"
  }

  depends_on = [helm_release.nginx-ingress-controller]
}



