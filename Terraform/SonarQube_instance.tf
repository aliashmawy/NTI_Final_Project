# create a security group for ec2 to allow ssh,http and https
resource "aws_security_group" "sonarqube-instance" {
  name        = "sonarqube-instance"
  description = "HTTP-SSH sonarqube"
  vpc_id      = module.vpc.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "allow_9000_sonarqube" {
  security_group_id = aws_security_group.sonarqube-instance.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 9000
  ip_protocol       = "tcp"
  to_port           = 9000
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_sonarqube" {
  security_group_id = aws_security_group.sonarqube-instance.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_sonarqube" {
  security_group_id = aws_security_group.sonarqube-instance.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_instance" "sonarqube" {
  ami                         = "ami-020cba7c55df1f615"
  instance_type               = "t2.medium"
  availability_zone           = "us-east-1a"
  key_name                    = var.key_name
  subnet_id                   = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.sonarqube-instance.id]

  tags = {
    Name = "sonarqube"
  }

  user_data = file("${path.module}/sonarqube.sh")
}




