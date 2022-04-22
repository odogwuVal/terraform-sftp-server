provider "aws" {
  region = "us-east-2"
}


module "sftp" {
  source = "./aws-transfer-sftp"

  bucket_name         = "sftp-transfer-20"
  bucket_key          = "incoming/"
  bucket_name_logging = "sftp-transfer-logging"
  endpoint_type       = "PUBLIC"
}

module "lambda" {
  source = "./aws-lambda"
}