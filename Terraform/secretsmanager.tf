#Creating the secret itself with name and describtion
resource "aws_secretsmanager_secret" "doc-pass" {
  name        = "master_admin"
  description = "mongo Admin password"

}

resource "aws_secretsmanager_secret_version" "secret" {
  secret_id     = aws_secretsmanager_secret.doc-pass.id
  secret_string = var.db_password
}