locals {
  lambda_zip_location = "output/lambda_function.zip"
}


data "archive_file" "lambda_function" {
  type        = "zip"
  source_file = "${path.module}/lambda_function.py"
  output_path = local.lambda_zip_location
}

resource "aws_lambda_function" "my_lambda" {
  filename      = local.lambda_zip_location
  function_name = "lambda_function"
  role          = aws_iam_role.lambda-role.arn
  handler       = "lambda_function.lambda_handler"

  
#   source_code_hash = filebase64sha256("lambda_function_payload.zip")

  runtime = "python3.9"
}