# create a security group for ec2 to allow ssh,http and https
resource "aws_security_group" "Jenkins-instance" {
  name        = "Jenkins-instance"
  description = "HTTP-SSH Jenkins"
  vpc_id      = module.vpc.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_jenkins" {
  security_group_id = aws_security_group.Jenkins-instance.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_https_jenkins" {
  security_group_id = aws_security_group.Jenkins-instance.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_8080_jenkins" {
  security_group_id = aws_security_group.Jenkins-instance.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 8080
  ip_protocol       = "tcp"
  to_port           = 8080
}
resource "aws_vpc_security_group_ingress_rule" "allow_ssh_jenkins" {
  security_group_id = aws_security_group.Jenkins-instance.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}


resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_jenkins" {
  security_group_id = aws_security_group.Jenkins-instance.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_instance" "Jenkins" {
  #Note this is a Private AMI that has Jenkins, Terraform, Ansible, AWS
  #Note to change the IP in /var/lib/jenkins/jenkins.model.JenkinsLocationConfiguration.xml
  ami                         = "ami-0fe3aab36c37201e0"
  instance_type               = "t3.medium"
  availability_zone           = "us-east-1a"
  key_name                    = var.key_name
  subnet_id                   = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.Jenkins-instance.id]
  iam_instance_profile        = aws_iam_instance_profile.ec2_instance_profile.name

  tags = {
    Name = "Jenkins"
  }
}
resource "aws_eip" "Jenkins_ip" {
  instance = aws_instance.Jenkins.id
  domain   = "vpc"
}



