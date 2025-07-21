resource "aws_s3_bucket" "logs_prod" {
  bucket = var.s3_log_bucket_name
}

resource "aws_s3_bucket_policy" "logs_prod_policy" {
  bucket = aws_s3_bucket.logs_prod.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${var.account_id}:root"
      },
      "Action": "s3:PutObject",
      "Resource": "arn:aws:s3:::final-project-access-log-bucket/my-app/AWSLogs/${var.account_id}/*"
    }
  ]
}
POLICY
}