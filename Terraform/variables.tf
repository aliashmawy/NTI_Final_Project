variable "default_tag" {
  type        = string
  description = "A default tag to add to everything"
  default     = "terraform_aws_rds_secrets_manager"
}
variable "db_password" {
  type        = string
  sensitive   = true
  description = "master password for document db"
}

variable "account_id" {
  type        = string
  description = "my account id"
}
variable "key_id" {
  type        = string
  description = "kms key id for aws backup"
}

variable "db_name" {
  type        = string
  description = "name for db"
}
variable "eks_cluster_name" {
  type        = string
  description = "name for eks cluster"
}

variable "cluster_nodes_name" {
  type        = string
  description = "name for managed node group of eks"
}

variable "s3_log_bucket_name" {
  type        = string
  description = "name for access log s3 bucket"
}

variable "slack_webhook" {
  type = string
  description = "incoming webhook URL for slack"
}

variable "slack_channel" {
  type = string
  description = "name of slack channel"
}

variable "key_name" {
  type = string
  description = "name of private key"
}