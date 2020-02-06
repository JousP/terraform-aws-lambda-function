output "arn" {
  description = "The Amazon Resource Name (ARN) identifying your Lambda Function."
  value       = "${element(concat(aws_lambda_function.main.*.arn, list("")), 0)}"
}

output "qualified_arn" {
  description = "The Amazon Resource Name (ARN) identifying your Lambda Function Version (if versioning is enabled via publish = true)."
  value       = "${element(concat(aws_lambda_function.main.*.qualified_arn, list("")), 0)}"
}

output "qualifier" {
  description = "The Name identifying your Lambda Function Version (if versioning is enabled via publish = true)."
  value       = "latest"
}

output "invoke_arn" {
  description = "The ARN to be used for invoking Lambda Function from API Gateway to be used in aws_api_gateway_integration's uri"
  value       = "${element(concat(aws_lambda_function.main.*.invoke_arn, list("")), 0)}"
}

output "version" {
  description = "Latest published version of your Lambda Function."
  value       = "${element(concat(aws_lambda_function.main.*.version, list("")), 0)}"
}

output "last_modified" {
  description = "The date this resource was last modified."
  value       = "${element(concat(aws_lambda_function.main.*.last_modified, list("")), 0)}"
}

output "source_code_hash" {
  description = "Base64-encoded representation of raw SHA-256 sum of the zip file provided either via filename or s3_* parameters."
  value       = "${element(concat(aws_lambda_function.main.*.source_code_hash, list("")), 0)}"
}

output "alias_arn" {
  description = "The Amazon Resource Name (ARN) identifying the Lambda function alias."
  value       = "${element(concat(aws_lambda_alias.main.*.arn, list("")), 0)}"
}

output "log_group_arn" {
  description = "The Amazon Resource Name (ARN) specifying the log group for the lambda function."
  value       = "${element(concat(aws_cloudwatch_log_group.lambda.*.arn, list("")), 0)}"
}

output "log_group_name" {
  description = "The Name of the log group for the lambda function."
  value       = "${element(concat(aws_cloudwatch_log_group.lambda.*.name, list("")), 0)}"
}

output "log_group_retention_in_days" {
  description = "The number of days log events are retained in the log group for the lambda function."
  value       = "${element(concat(aws_cloudwatch_log_group.lambda.*.retention_in_days, list("")), 0)}"
}

# output "log_group_tags" {
#   description = "Tags associated with the log group for the lambda function."
#   value       = "${aws_cloudwatch_log_group.lambda.*.tags}"
# }
