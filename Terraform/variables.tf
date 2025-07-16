variable "default_tag" {
  type        = string
  description = "A default tag to add to everything"
  default     = "terraform_aws_rds_secrets_manager"
}
# variable "db_password" {
#   type = string
# }

variable "docdb_password" {
  type = string
  description = "The password for the database"
  sensitive = true
}