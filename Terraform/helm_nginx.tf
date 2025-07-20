resource "helm_release" "nginx-ingress-controller" {
  name       = "nginx-ingress-controller"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx-ingress-controller"

  set = [
    {
      name  = "service.type"
      value = "LoadBalancer"
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



