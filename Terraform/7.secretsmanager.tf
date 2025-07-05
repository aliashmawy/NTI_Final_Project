# resource "random_password" "password" {
#   length           = 16
# }

# resource "aws_secretsmanager_secret" "doc-pass" {
#   name                    = "mongo_admin"
#   description             = "mongo Admin password"

# }

# resource "aws_secretsmanager_secret_version" "secret" {
#   secret_id     = aws_secretsmanager_secret.doc-pass.id
#   secret_string = var.db_password
# }