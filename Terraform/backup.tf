###### AWS_backup_plan ######
resource "aws_backup_plan" "Jenkins" {
  name = "Jenkins_daily_plan"

  rule {
    rule_name         = "Jenkins_daily_rule"
    target_vault_name = aws_backup_vault.Jenkins.name
    #Everyday at 8am
    schedule = "cron(0 8 * * ? *)"

    lifecycle {
      delete_after = 14
    }
  }
}

###### KMS key ######
data "aws_kms_key" "by_alias" {
  key_id = var.key_id
}

###### AWS backup vault ######
resource "aws_backup_vault" "Jenkins" {
  name        = "jenkins_backup_vault"
  kms_key_arn = data.aws_kms_key.by_alias.arn

}

###### Backup Selection ######
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["backup.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}
resource "aws_iam_role" "backup_ec2" {
  name               = "backup_role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "backup_ec2" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
  role       = aws_iam_role.backup_ec2.name
}

resource "aws_backup_selection" "backup_ec2" {
  iam_role_arn = aws_iam_role.backup_ec2.arn
  name         = "Jenkins_backup_selection"
  plan_id      = aws_backup_plan.Jenkins.id

  resources = [
    aws_instance.Jenkins.arn,
  ]
}

