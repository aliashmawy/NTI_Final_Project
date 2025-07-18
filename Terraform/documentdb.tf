# data "aws_secretsmanager_secret" "doc-pass" {
#   name = "mongo_admin"
#   depends_on = [
#     aws_secretsmanager_secret.doc-pass
#   ]
# }

# data "aws_secretsmanager_secret_version" "secret" {
#   secret_id = data.aws_secretsmanager_secret.doc-pass.id
# }
resource "aws_security_group" "docdb" {
  name        = "docdb-access"
  description = "Allow EKS nodes to access DocumentDB"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port       = 27017
    to_port         = 27017
    protocol        = "tcp"
    security_groups = [module.eks.node_security_group_id]
    description     = "Allow DocumentDB access from EKS nodes"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

module "documentdb_cluster" {
  source = "cloudposse/documentdb-cluster/aws"
  version = "0.30.1"
  name                    = "docdb"
  cluster_size            = 1
  master_username         = "master"
  master_password         = var.docdb_password
  instance_class          = "db.t3.medium"
  vpc_id                  = module.vpc.vpc_id
  subnet_ids              = module.vpc.private_subnets
  allowed_security_groups = [aws_security_group.docdb.id]
  manage_master_user_password = true
}

# resource "aws_docdb_cluster" "docdb" {
#   cluster_identifier      = "final-project-cluster"
#   engine                  = "docdb"
#   master_username         = "master"
#   skip_final_snapshot     = true
#   apply_immediately = true
#   manage_master_user_password = true
#   }

# resource "aws_docdb_cluster_instance" "cluster_instances" {
#   count              = 1
#   identifier         = "docdb-cluster-demo-${count.index}"
#   cluster_identifier = aws_docdb_cluster.docdb.id
#   instance_class     = "db.t3.medium"
# }