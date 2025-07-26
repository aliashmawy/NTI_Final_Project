# Ansible Automation & Configuration Management

## 🎯 Directory Purpose

This directory contains Ansible playbooks and configurations for automating post-provisioning tasks in our DevOps pipeline. Ansible is used to configure and manage infrastructure components after they are provisioned by Terraform.

---

## 🛠️ Tools & Components

### **ansible.cfg**
- **Purpose**: Main Ansible configuration file
- **Key Settings**:
  - Disables host key checking for automated deployments
  - Sets default inventory to `inventory_Jenkins_aws_ec2.yaml`
  - Enables AWS EC2 and YAML plugins for dynamic inventory
  - Configures remote user as `ubuntu`
  - Specifies private key file for SSH authentication

### **Dynamic Inventory Files**

#### **inventory_Jenkins_aws_ec2.yaml**
- **Purpose**: Dynamic inventory to filter and target only Jenkins instances
- **Filter**: Uses AWS EC2 plugin with tag-based filtering (`tag:Name: Jenkins*`)
- **Region**: Targets instances in `us-east-1`
- **Usage**: Automatically discovers all EC2 instances with names starting with "Jenkins"

#### **inventory_CloudWatch_aws_ec2.yaml**
- **Purpose**: Dynamic inventory to filter instances by specific key-name
- **Filter**: Uses AWS EC2 plugin with key-name filtering (`key-name: vockey3`)
- **Region**: Targets instances in `us-east-1`
- **Usage**: Automatically discovers all EC2 instances using the "vockey3" key pair

### **Playbooks**

#### **jenkins-playbook.yaml**
- **Purpose**: Automates Jenkins installation and configuration
- **Target**: All hosts (uses dynamic inventory)
- **Tasks**:
  - Updates package repositories
  - Installs OpenJDK 17
  - Adds Jenkins repository and GPG key
  - Installs Jenkins package
  - Starts and enables Jenkins service
  - Displays initial admin password for setup

#### **cloudwatch-playbook.yaml**
- **Purpose**: Installs and configures AWS CloudWatch Agent
- **Target**: AWS EC2 instances (filtered by key-name)
- **Tasks**:
  - Downloads CloudWatch Agent installer
  - Installs the agent package
  - Copies and deploys configuration file
  - Starts the CloudWatch Agent service

### **Configuration Files**

#### **config.json**
- **Purpose**: CloudWatch Agent configuration template
- **Features**:
  - Configures metrics collection intervals (60 seconds)
  - Sets up disk usage monitoring (`used_percent`)
  - Configures memory monitoring (`mem_used_percent`)
  - Adds AWS metadata dimensions (InstanceId, InstanceType, etc.)
  - Enables aggregation by InstanceId

---

## 🚀 Usage Examples

### Run Jenkins Installation
```bash
ansible-playbook jenkins-playbook.yaml
```

### Run CloudWatch Agent Installation
```bash
ansible-playbook -i inventory_CloudWatch_aws_ec2.yaml cloudwatch-playbook.yaml
```

### Test Dynamic Inventory
```bash
# List Jenkins instances
ansible-inventory -i inventory_Jenkins_aws_ec2.yaml --list

# List instances with specific key-name
ansible-inventory -i inventory_CloudWatch_aws_ec2.yaml --list
```

---

## 🔧 Key Features

- **Dynamic Inventory**: Automatically discovers AWS EC2 instances based on tags and key-names
- **Idempotent Operations**: Playbooks can be run multiple times safely
- **Automated Configuration**: Post-provisioning setup without manual intervention
- **Monitoring Integration**: CloudWatch agent setup for infrastructure monitoring
- **Security**: Uses SSH key-based authentication with proper user permissions

---

## 📋 Prerequisites

- AWS credentials configured
- Ansible installed with AWS plugins
- Target instances accessible via SSH
- Proper IAM permissions for EC2 instance discovery 