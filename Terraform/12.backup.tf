###### AWS_backup_plan ######
resource "aws_backup_plan" "jenkins" {
  name = "jenkins_daily_plan"

  rule {
    rule_name         = "jenkins_daily_rule"
    target_vault_name = aws_backup_vault.jenkins.name
    #Everyday at 8am
    schedule = "cron(0 8 * * ? *)"

    lifecycle {
      delete_after = 14
    }
  }
}

###### KMS key ######
data "aws_kms_key" "by_alias" {
  key_id = "21cab0bf-e4c0-48d3-a708-ec18dc3761b1"
}

###### AWS backup vault ######
resource "aws_backup_vault" "jenkins" {
  name        = "example_backup_vault"
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
  name               = "example"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "backup_ec2" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
  role       = aws_iam_role.backup_ec2.name
}

resource "aws_backup_selection" "backup_ec2" {
  iam_role_arn = aws_iam_role.backup_ec2.arn
  name         = "jenkins_backup_selection"
  plan_id      = aws_backup_plan.jenkins.id

  resources = [
    aws_instance.jenkins.arn,
  ]
}

