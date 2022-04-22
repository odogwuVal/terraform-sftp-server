resource "aws_iam_role_policy" "lambda_policy" {
  name = "lambda_policy"
  role = aws_iam_role.lambda-role.name
  policy = file("aws-lambda/iam/iam-policy.json")

}

resource "aws_iam_role" "lambda-role" {
  name = "lambda_role"
  assume_role_policy = file("aws-lambda/iam/iam-role.json")

}
    
  