module "documentdb_cluster" {
  source                  = "cloudposse/documentdb-cluster/aws"
  version                 = "0.30.1"
  name                    = var.db_name
  cluster_size            = 1
  master_username         = "master"
  master_password         = aws_secretsmanager_secret_version.secret.secret_string
  instance_class          = "db.t3.medium"
  vpc_id                  = module.vpc.vpc_id
  subnet_ids              = module.vpc.private_subnets
  allowed_security_groups = [module.eks.node_security_group_id]
}