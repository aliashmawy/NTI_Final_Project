output "nginx_endpoint" {
  value = "http://${data.kubernetes_service.nginx_ingress_service.status.0.load_balancer.0.ingress.0.hostname}"
}

output "sonarqube_public_ip" {
  value = aws_instance.sonarqube.public_ip
}

output "ec2_elastic_ip" {
  value = aws_eip.Jenkins_ip
}