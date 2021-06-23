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
  version          = "~> 3.0"
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

output "lambda_basic_arn" {
  description = "The Amazon Resource Name (ARN) identifying your Lambda Function."
  value       = module.lambda_basic.arn
}

output "lambda_basic_qualified_arn" {
  description = "The Amazon Resource Name (ARN) identifying your Lambda Function Version (if versioning is enabled via publish = true)."
  value       = module.lambda_basic.qualified_arn
}

output "lambda_basic_invoke_arn" {
  description = "The ARN to be used for invoking Lambda Function from API Gateway to be used in aws_api_gateway_integration's uri"
  value       = module.lambda_basic.invoke_arn
}

output "lambda_basic_version" {
  description = "Latest published version of your Lambda Function."
  value       = module.lambda_basic.version
}

output "lambda_basic_last_modified" {
  description = "The date this resource was last modified."
  value       = module.lambda_basic.last_modified
}

output "lambda_basic_kms_key_arn" {
  description = "The date this resource was last modified."
  value       = module.lambda_basic.kms_key_arn
}

output "lambda_basic_source_code_hash" {
  description = "Base64-encoded representation of raw SHA-256 sum of the zip file provided either via filename or s3_* parameters."
  value       = module.lambda_basic.source_code_hash
}

output "lambda_basic_source_code_size" {
  description = "Base64-encoded representation of raw SHA-256 sum of the zip file provided either via filename or s3_* parameters."
  value       = module.lambda_basic.source_code_size
}

output "lambda_basic_alias_arn" {
  description = "The Amazon Resource Name (ARN) identifying the Lambda function alias."
  value       = module.lambda_basic.alias_arn
}

output "lambda_basic_log_group_arn" {
  description = "The Amazon Resource Name (ARN) specifying the log group for the lambda function."
  value       = module.lambda_basic.log_group_arn
}

output "lambda_basic_log_group_name" {
  description = "The Name of the log group for the lambda function."
  value       = module.lambda_basic.log_group_name
}

output "lambda_basic_log_group_retention_in_days" {
  description = "The number of days log events are retained in the log group for the lambda function."
  value       = module.lambda_basic.log_group_retention_in_days
}

output "lambda_basic_log_group_tags" {
  description = "Tags associated with the log group for the lambda function."
  value       = module.lambda_basic.log_group_tags
}

