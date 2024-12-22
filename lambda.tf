module "lambda_function" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 5.0"

  function_name       = "GetRandomQuote"
  s3_bucket           = aws_s3_bucket.code_storage.id
  s3_existing_package = aws_s3_object.object.key
  runtime             = "python3.10"
  handler             = "lambda_function.lambda_handler"
  create_role         = false
  role                = aws_iam_role.lambda_dynamodb_role.arn

}