# Terraform Infrastructure as Code

## 🎯 Directory Purpose
This directory contains all Terraform code for provisioning and managing the cloud infrastructure required for the To-Do web application. It automates the setup of AWS resources, Kubernetes add-ons, monitoring, secrets, and more.

---

## 🛠️ Key Features & Components

### 🔐 Secrets Management
- **AWS Secrets Manager** is used to securely store and manage sensitive data, such as the master password for Amazon DocumentDB.
- The password is referenced in the `documentdb.tf` and managed via `secretsmanager.tf`.

### ☸️ Kubernetes Add-ons via Helm
- **ArgoCD**: Deployed using a Helm release (`helm_argocd.tf`) with custom configuration in `values_argocd.yaml`.
  - The Helm chart sets up ArgoCD and its Application resource for GitOps-based deployment.
- **NGINX Ingress Controller**: Deployed via Helm (`helm_nginx.tf`) with configuration in `values_nginx.yaml`.
  - S3 access logs are enabled for the load balancer, providing audit and access visibility.
- **Prometheus & Grafana**: Deployed using the `kube-prometheus-stack` Helm chart (`helm_prometheus.tf`).
  - **Slack Integration**: Alertmanager is configured with a Slack incoming webhook for real-time notifications.
  - All configuration is managed via Helm `set` blocks and variables.

### 📦 Application Infrastructure
- **EKS Cluster**: Provisions an AWS Elastic Kubernetes Service (EKS) cluster and managed node groups.
- **VPC, IAM, S3, and more**: All supporting AWS resources are defined for a secure, scalable environment.
- **DocumentDB**: Managed MongoDB-compatible database, with credentials stored in Secrets Manager.
- **Jenkins & SonarQube EC2 Instances**: Standalone instances for CI/CD and code quality analysis.

### 📝 Outputs
- Exposes endpoints for NGINX, ArgoCD, SonarQube, and Jenkins.
- Outputs the initial admin passwords for ArgoCD and Grafana, retrieved securely via external scripts.

### 🧩 SonarQube Instance Automation
- The SonarQube EC2 instance is provisioned with a user data script (`sonarqube.sh`) that:
  - Installs Java 17
  - Downloads and configures SonarQube 9
  - Sets up PostgreSQL as the backend database
  - Configures and enables the SonarQube service
  - Installs and configures NGINX as a reverse proxy

---

## 📂 File Highlights
- **managed_node_group.tf, eks.tf, vpc.tf, IAM_roles.tf**: Core AWS infrastructure
- **documentdb.tf, secretsmanager.tf**: Secure database provisioning
- **helm_argocd.tf, values_argocd.yaml**: ArgoCD GitOps setup
- **helm_nginx.tf, values_nginx.yaml**: NGINX Ingress with S3 access log support
- **helm_prometheus.tf**: Prometheus & Grafana with Slack alerting
- **output.tf**: Exposes key endpoints and credentials
- **sonarqube.sh**: Automated SonarQube and Java 17 installation

---

## 📋 Prerequisites
- AWS CLI and credentials
- Terraform installed
- Proper IAM permissions for all AWS resources
- Slack webhook for alerting (if using Prometheus/Grafana integration)
