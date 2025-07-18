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

module "docdb" {
  source  = "dare-global/documentdb/aws"
  version = "1.1.0"

  name_prefix = "final-project-db"

  instance_class = "db.t3.medium"
  instance_count = "1"

  engine         = "docdb"
  engine_version = "5.0.0"

  master_username = "master"
  master_password = var.docdb_password
  apply_immediately = true
  skip_final_snapshot = true

  vpc_id                 = module.vpc.vpc_id
  subnet_ids             = module.vpc.private_subnets
  vpc_security_group_ids = [aws_security_group.docdb.id]


}