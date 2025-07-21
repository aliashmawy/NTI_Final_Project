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