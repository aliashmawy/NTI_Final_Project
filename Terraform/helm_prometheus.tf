resource "helm_release" "prometheus" {
  name       = "prometheus"
  namespace  = "monitoring"
  chart      = "kube-prometheus-stack"
  repository = "https://prometheus-community.github.io/helm-charts"
  version    = "57.0.2" # optional: pick specific version

  create_namespace = true

  set = [
    {
      name  = "alertmanager.persistentVolume.storageClass"
      value = "gp2"
    },

    {
      name  = "server.persistentVolume.storageClass"
      value = "gp2"
    }
  ]
}

data "external" "grafana_password" {
  program = ["bash", "${path.module}/grafana_pass.sh"]
}