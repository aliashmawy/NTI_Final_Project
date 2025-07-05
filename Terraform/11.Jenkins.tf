# create a security group for ec2 to allow ssh,http and https
resource "aws_security_group" "jenkins-instance" {
  name        = "jenkins-instance"
  description = "HTTP-SSH jenkins"
  vpc_id      = module.vpc.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4" {
  security_group_id = aws_security_group.jenkins-instance.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_https_ipv4" {
  security_group_id = aws_security_group.jenkins-instance.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_8080_ipv4" {
  security_group_id = aws_security_group.jenkins-instance.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 8080
  ip_protocol       = "tcp"
  to_port           = 8080
}
resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4" {
  security_group_id = aws_security_group.jenkins-instance.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.jenkins-instance.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_instance" "jenkins" {
  ami                         = "ami-020cba7c55df1f615"
  instance_type               = "t2.medium"
  availability_zone           = "us-east-1a"
  key_name                    = "vockey3"
  subnet_id                   = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.jenkins-instance.id]
  iam_instance_profile        = aws_iam_instance_profile.ec2_instance_profile.name

  tags = {
    Name = "jenkins"
  }

  provisioner "local-exec" {
    environment = {
      ANSIBLE_CONFIG = "../Ansible/ansible.cfg"
    }
    command = <<EOT
    echo "Waiting 150 seconds for EC2 to initialize..."
    sleep 120
    ansible-playbook -i ../Ansible/inventory_jenkins_aws_ec2.yaml ../Ansible/jenkins-playbook.yaml
EOT
  }
}
resource "aws_eip" "jenkins_ip" {
  instance = aws_instance.jenkins.id
  domain   = "vpc"
}



output "ec2_public_ip" {
  value      = aws_instance.jenkins.public_ip
  depends_on = [aws_eip.jenkins_ip]
}