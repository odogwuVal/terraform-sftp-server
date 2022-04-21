resource "aws_s3_bucket" "sftp_transfer" {
  count  = var.manage_bucket ? 1 : 0
  bucket = var.bucket_name
 
  logging {
    target_bucket = length(aws_s3_bucket.sftp_transfer_s3_logging) > 0 ? aws_s3_bucket.sftp_transfer_s3_logging[0].id : var.bucket_name_logging
    target_prefix = var.bucket_prefix_logging
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

#   lifecycle_rule {
#     enabled = true

#     expiration {
#       days = var.s3_object_expiration_days
#     }
#   }

  tags = merge(var.tags)
}

resource "aws_s3_bucket_public_access_block" "sftp_transfer" {
  count                   = var.manage_bucket ? 1 : 0
  bucket                  = aws_s3_bucket.sftp_transfer[0].id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket" "sftp_transfer_s3_logging" {
  count  = var.manage_bucket_logging ? 1 : 0
  bucket = var.bucket_name_logging
  acl    = "log-delivery-write"

  # lifecycle_rule {
  #   enabled = true

  #   transition {
  #     days          = 30
  #     storage_class = "STANDARD_IA" # or "ONEZONE_IA"
  #   }

  #   transition {
  #     days          = 60
  #     storage_class = "GLACIER"
  #   }

  # }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = merge(var.tags)
}

resource "aws_s3_bucket_public_access_block" "sftp_transfer_s3_logging" {
  count                   = var.manage_bucket ? 1 : 0
  bucket                  = length(aws_s3_bucket.sftp_transfer_s3_logging) > 0 ? aws_s3_bucket.sftp_transfer_s3_logging[count.index].id : ""
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_object" "example" {
  count = length(aws_s3_bucket.sftp_transfer)
  key        = var.bucket_key
  bucket     = aws_s3_bucket.sftp_transfer[count.index].id
}

resource "aws_iam_role" "sftp_transfer_logging" {
  name = "tf-test-transfer-server-iam-role"

  assume_role_policy = <<EOF
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
EOF

  tags = merge(var.tags)
}

resource "aws_iam_role_policy" "sftp_transfer_logging" {
  name = "sftp_transfer_logging"
  role = aws_iam_role.sftp_transfer_logging.id

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
        "Effect": "Allow",
        "Action": [
            "logs:CreateLogStream",
            "logs:DescribeLogStreams",
            "logs:CreateLogGroup",
            "logs:PutLogEvents"
        ],
        "Resource": "*"
        }
    ]
}
POLICY
}
