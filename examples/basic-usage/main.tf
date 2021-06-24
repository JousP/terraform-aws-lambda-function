# Create a custom role for the lambda function
module "lambda_role" {
  source              = "JousP/iam-assumeRole/aws"
  version             = "~> 3.2"
  name                = "basic-usage-lambda-role"
  service_identifiers = ["lambda.amazonaws.com"]
  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"]
}

locals {
  lambda_archive_prefix      = "lambda/main"
  lambda_archive_source_file = join(".", [local.lambda_archive_prefix, "py"])
  lambda_archive_output_path = join(".", [local.lambda_archive_prefix, "zip"])
}

data "archive_file" "lambda_filename" {
  type        = "zip"
  source_file = local.lambda_archive_source_file
  output_path = local.lambda_archive_output_path
}

module "lambda_basic" {
  source           = "JousP/lambda-function/aws"
  version          = "~> 3.1"
  function_name    = "basic-example"
  description      = "basic-example function"
  filename         = data.archive_file.lambda_filename.output_path
  source_code_hash = data.archive_file.lambda_filename.output_base64sha256
  handler          = "main.handler"
  role             = module.lambda_role.arn
  runtime          = "python3.6"
  tags = {
    Name = "basic-example"
  }
}
