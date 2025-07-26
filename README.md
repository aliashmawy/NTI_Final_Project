# To-Do Web Application on K8s & DocumentDB

## 🎯 Project Overview

- **Cloud Provider:** AWS
- **Containerization:** Docker
- **Kubernetes Cluster:** AWS EKS
- **DB**: Amazon DocumentDB (MongoDB Compatibility)
- **IaC:** Terraform
- **CI/CD:** Jenkins
- **Automation Tools:** Ansible & Bash

---

## 🏗️ Repository Structure

- [Docker Compose (3-tier Node.js)](Docker-Compose/3tier-nodejs/README.md) – Local Docker Compose setup and documentation
- [ArgoCD](argocd/readme.md) – ArgoCD Kubernetes manifests and GitOps deployment
- [Terraform](Terraform/README.md) – Infrastructure as Code for AWS, EKS, Helm, and more
- [Ansible](Ansible/README.md) – Automation and configuration management
- [Jenkins](Jenkins/README.md) – CI/CD pipeline definitions

---

## 🧩 Introduction

This project is a fully containerized **To-Do web application** deployed on a highly available and scalable **Kubernetes cluster** on AWS, using an end-to-end **GitOps-driven CI/CD pipeline**.

The application consists of:

- A **React.js frontend** 
- A **Node.js backend** that handles API requests
- A managed **MongoDB-compatible database** using Amazon DocumentDB

Beyond application deployment, this project demonstrates a complete DevOps lifecycle using industry-standard tools:

- **Docker** is used to containerize both frontend and backend applications.
- **Terraform** provisions the entire cloud infrastructure, including the EKS cluster, IAM roles, VPC, security groups, and DocumentDB.
- **Ansible** is used for post-provisioning automation tasks like configuring Jenkins.
- **Jenkins** is used as the CI/CD orchestrator, executing pipelines that build, scan, and push Docker images to AWS ECR, then commit updated Kubernetes manifests to Git.
- **Argo CD** enables GitOps-based Continuous Deployment, automatically syncing Kubernetes manifests from the Git repo to the cluster.
- **Helm** is used to install and manage third-party components like Prometheus, Grafana, Argo CD, and the NGINX ingress controller.
- **Prometheus & Grafana** monitor application and pod-level metrics.
- **NetworkPolicies, HPAs, and Alerts** are used to implement best practices in Kubernetes.

This project showcases real-world skills in modern cloud-native infrastructure, automation, and application delivery — suitable for production-ready environments.
