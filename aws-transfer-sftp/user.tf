data "aws_key_pair" "example" {
  key_name = "odogwu"
}

resource "aws_transfer_user" "sftp-user" {
  for_each = var.sftp-user

  server_id      = aws_transfer_server.sftp.id
  user_name      = each.key
  role           = aws_iam_role.sftp_transfer.arn
  home_directory = "/${aws_s3_bucket.sftp_transfer[0].bucket}"
  
}


resource "aws_transfer_ssh_key" "all" {
  for_each = var.sftp-user

  server_id  = aws_transfer_server.sftp.id
  user_name  = each.key
  body       = each.value
}

# data.aws_key_pair.example.key_name