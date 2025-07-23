resource "helm_release" "prometheus" {
  name       = "prometheus"
  namespace  = "monitoring"
  chart      = "kube-prometheus-stack"
  repository = "https://prometheus-community.github.io/helm-charts"
  version    = "57.0.2"

  create_namespace = true

  set = [
    {
      name  = "alertmanager.persistentVolume.storageClass"
      value = "gp2"
    },

    {
      name  = "server.persistentVolume.storageClass"
      value = "gp2"
    },
        {
      name  = "alertmanager.config.receivers[0].name"
      value = "slack-notifications"
    },
    {
      name  = "alertmanager.config.receivers[0].slack_configs[0].channel"
      value = var.slack_channel
    },
    {
      name  = "alertmanager.config.receivers[0].slack_configs[0].api_url"
      value = var.slack_webhook
    },
    {
      name  = "alertmanager.config.route.receiver"
      value = "slack-notifications"
    },
    {
      name  = "alertmanager.config.route.group_wait"
      value = "30s"
    },
    {
      name  = "alertmanager.config.route.group_interval"
      value = "5m"
    },
    {
      name  = "alertmanager.config.route.repeat_interval"
      value = "3h"
    }

  ]
}

data "external" "grafana_password" {
  program = ["bash", "${path.module}/grafana_pass.sh"]
}