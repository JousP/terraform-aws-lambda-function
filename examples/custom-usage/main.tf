# Create a custom role for the lambda function
module "lambda_role" {
  source              = "JousP/iam-assumeRole/aws"
  version             = "~> 3.2"
  name                = "custom-usage-lambda-role"
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

module "lambda_custom" {
  source           = "JousP/lambda-function/aws"
  version          = "~> 3.1"
  function_name    = "custom-example"
  description      = "custom-example function"
  create_alias     = true
  filename         = data.archive_file.lambda_filename.output_path
  source_code_hash = data.archive_file.lambda_filename.output_base64sha256
  handler          = "main.handler"
  role             = module.lambda_role.arn
  runtime          = "python3.6"
  memory_size      = 512
  timeout          = 15
  publish          = true
  vpc_config = {
    subnet_ids         = [aws_subnet.aza.id, aws_subnet.azb.id]
    security_group_ids = [aws_security_group.sg.id]
  }
  environment = {
    variables = {
      test = "1"
    }
  }
  permission_principal = "events.amazonaws.com"
  tags                 = local.tags
}
