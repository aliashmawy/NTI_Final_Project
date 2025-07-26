# Jenkins CI/CD Pipelines

## 📂 Navigation
- [Jenkinsfile_app](./Jenkinsfile_app): Application CI/CD pipeline
- [Jenkinsfile_terraform](./Jenkinsfile_terraform): Infrastructure as Code (IaC) pipeline

---

## 🎯 Directory Purpose

This directory contains Jenkins pipeline definitions for automating both application delivery and infrastructure provisioning. Jenkins orchestrates the build, test, security scan, deployment, and GitOps workflows for the project.

---

## 🛠️ Pipeline Overviews

### 🚀 Application Pipeline ([Jenkinsfile_app](./Jenkinsfile_app))
A full CI/CD pipeline for the Node.js/React application, including:
- **Source Checkout**: Clones the repository
- **Change Detection**: Triggers only on application code changes
- **Build**: Installs dependencies and builds frontend/backend
- **Code Quality**: Runs SonarQube analysis and enforces quality gates
- **Security**: Scans Docker images with Trivy
- **Dockerization**: Builds multi-stage Docker images for frontend and backend
- **Push to ECR**: Pushes images to AWS Elastic Container Registry
- **GitOps Deployment**:
  - Updates deployment manifests in the `argocd` directory with new image tags
  - Commits and pushes updated manifests to GitHub
  - Triggers ArgoCD to deploy the new version to Kubernetes

#### 🔗 Integrations
- **SonarQube**: Static code analysis and quality gate enforcement
- **Trivy**: Container image vulnerability scanning
- **AWS ECR**: Secure image storage and distribution
- **ArgoCD**: GitOps-based continuous deployment

---

### 🏗️ Infrastructure Pipeline ([Jenkinsfile_terraform](./Jenkinsfile_terraform))
Automates Infrastructure as Code (IaC) using Terraform:
- **Workspace Clean**: Ensures a fresh environment
- **Source Checkout**: Clones the repository
- **Change Detection**: Runs only if Terraform files have changed
- **Terraform Init/Validate/Plan/Apply**: Provisions or updates AWS infrastructure automatically

#### 🔗 Integrations
- **Terraform**: Infrastructure provisioning and management
- **AWS**: Uses credentials for secure cloud automation

---

## 💡 Key Features
- **Separation of Concerns**: Application and infrastructure pipelines are managed independently
- **Security & Quality**: Automated code quality checks and vulnerability scans
- **GitOps Workflow**: All deployments are driven by version-controlled manifests
- **Cloud-Native**: Integrates with AWS services for both application and infrastructure

---

## 📝 Usage
- Configure Jenkins with the required credentials (GitHub, AWS, SonarQube)
- Set up pipeline jobs pointing to these Jenkinsfiles
- Monitor pipeline runs for build, test, deploy, and infrastructure automation

---

## 📋 Prerequisites
- Jenkins server with required plugins (Pipeline, Git, Docker, SonarQube, Trivy, AWS CLI)
- AWS credentials and ECR repositories
- SonarQube server and project key
- ArgoCD set up for GitOps deployment 