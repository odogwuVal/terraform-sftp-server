resource "aws_transfer_server" "sftp" {
  logging_role = aws_iam_role.sftp_transfer_logging.arn
  endpoint_type = var.endpoint_type
  

  tags = {
    Name = "DevOps-Sftp"
  }
}

resource "aws_iam_role" "sftp_transfer" {
  name               = "sftp_transfer"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "transfer.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY

  tags = merge(var.tags)
}

resource "aws_iam_role_policy" "sftp_transfer" {
  name = "sftp_transfer"
  role = aws_iam_role.sftp_transfer.id

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket",
                "s3:GetBucketLocation"
            ],
            "Resource": "${aws_s3_bucket.sftp_transfer[0].arn}"
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:DeleteObject"
            ],
            "Resource": "${aws_s3_bucket.sftp_transfer[0].arn}/*"
        }
    ]
}
POLICY
}

