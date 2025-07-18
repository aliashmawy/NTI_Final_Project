# create a security group for ec2 to allow ssh,http and https
resource "aws_security_group" "Jenkins-instance" {
  name        = "Jenkins-instance"
  description = "HTTP-SSH Jenkins"
  vpc_id      = module.vpc.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4" {
  security_group_id = aws_security_group.Jenkins-instance.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_https_ipv4" {
  security_group_id = aws_security_group.Jenkins-instance.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_8080_ipv4" {
  security_group_id = aws_security_group.Jenkins-instance.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 8080
  ip_protocol       = "tcp"
  to_port           = 8080
}
resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4" {
  security_group_id = aws_security_group.Jenkins-instance.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}
resource "aws_vpc_security_group_ingress_rule" "allow_telnet_ipv4" {
  security_group_id = aws_security_group.Jenkins-instance.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 23
  ip_protocol       = "tcp"
  to_port           = 23
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.Jenkins-instance.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_instance" "Jenkins" {
  ami                         = "ami-020cba7c55df1f615"
  instance_type               = "t3.medium"
  availability_zone           = "us-east-1a"
  key_name                    = "vockey3"
  subnet_id                   = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.Jenkins-instance.id]
  iam_instance_profile        = aws_iam_instance_profile.ec2_instance_profile.name

  tags = {
    Name = "Jenkins"
  }

#   provisioner "local-exec" {
#     environment = {
#       ANSIBLE_CONFIG = "../Ansible/ansible.cfg"
#     }
#     command = <<EOT
#     echo "Waiting 150 seconds for EC2 to initialize..."
#     sleep 120
#     ansible-playbook -i ../Ansible/inventory_Jenkins_aws_ec2.yaml ../Ansible/Jenkins-playbook.yaml
# EOT
#   }
}
resource "aws_eip" "Jenkins_ip" {
  instance = aws_instance.Jenkins.id
  domain   = "vpc"
}



