output "function_name" {
  description = "Unique name for your Lambda Function."
  value       = aws_lambda_function.main.function_name
}

output "role" {
  description = "of the function's execution role. The role provides the function's identity and access to AWS services and resources."
  value       = aws_lambda_function.main.role
}

output "code_signing_config_arn" {
  description = "To enable code signing for this function, specify the ARN of a code-signing configuration. A code-signing configuration includes a set of signing profiles, which define the trusted publishers for this function."
  value       = aws_lambda_function.main.code_signing_config_arn
}

output "dead_letter_config" {
  description = "Configuration block. Detailed below."
  value       = aws_lambda_function.main.dead_letter_config
}

output "description" {
  description = "Description of what your Lambda Function does."
  value       = aws_lambda_function.main.description
}

output "environment" {
  description = "Configuration block. Detailed below."
  value       = aws_lambda_function.main.environment
}

output "file_system_config" {
  description = "Configuration block. Detailed below."
  value       = aws_lambda_function.main.file_system_config
}

output "filename" {
  description = "Path to the function's deployment package within the local filesystem. Conflicts with image_uri, s3_bucket, s3_key, and s3_object_version."
  value       = aws_lambda_function.main.filename
}

output "handler" {
  description = "Function entrypoint in your code."
  value       = aws_lambda_function.main.handler
}

output "image_config" {
  description = "Configuration block. Detailed below."
  value       = aws_lambda_function.main.image_config
}

output "image_uri" {
  description = "ECR image URI containing the function's deployment package. Conflicts with filename, s3_bucket, s3_key, and s3_object_version."
  value       = aws_lambda_function.main.image_uri
}

output "kms_key_arn" {
  description = "key that is used to encrypt environment variables. If this configuration is not provided when environment variables are in use, AWS Lambda uses a default service key. If this configuration is provided when environment variables are not in use, the AWS Lambda API does not save this configuration and Terraform will show a perpetual difference of adding the key. To fix the perpetual difference, remove this configuration."
  value       = aws_lambda_function.main.kms_key_arn
}

output "layers" {
  description = "to attach to your Lambda Function. See Lambda Layers"
  value       = aws_lambda_function.main.layers
}

output "memory_size" {
  description = "Amount of memory in MB your Lambda Function can use at runtime. Defaults to 128. See Limits"
  value       = aws_lambda_function.main.memory_size
}

output "package_type" {
  description = "Lambda deployment package type. Valid values are Zip and Image. Defaults to Zip."
  value       = aws_lambda_function.main.package_type
}

output "publish" {
  description = "Whether to publish creation/change as new Lambda Function Version. Defaults to false."
  value       = aws_lambda_function.main.publish
}

output "reserved_concurrent_executions" {
  description = "Amount of reserved concurrent executions for this lambda function. A value of 0 disables lambda from being triggered and -1 removes any concurrency limitations. Defaults to Unreserved Concurrency Limits -1. See Managing Concurrency"
  value       = aws_lambda_function.main.reserved_concurrent_executions
}

output "runtime" {
  description = "Identifier of the function's runtime. See Runtimes for valid values."
  value       = aws_lambda_function.main.runtime
}

output "s3_bucket" {
  description = "S3 bucket location containing the function's deployment package. Conflicts with filename and image_uri. This bucket must reside in the same AWS region where you are creating the Lambda function."
  value       = aws_lambda_function.main.s3_bucket
}

output "s3_key" {
  description = "S3 key of an object containing the function's deployment package. Conflicts with filename and image_uri."
  value       = aws_lambda_function.main.s3_key
}

output "s3_object_version" {
  description = "Object version containing the function's deployment package. Conflicts with filename and image_uri."
  value       = aws_lambda_function.main.s3_object_version
}

output "source_code_hash" {
  description = "(Terraform 0.11.11 and earlier), where \"file.zip\" is the local filename of the lambda function source archive."
  value       = aws_lambda_function.main.source_code_hash
}

output "tags" {
  description = "Map of tags to assign to the object. If configured with a provider default_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level."
  value       = aws_lambda_function.main.tags
}

output "timeout" {
  description = "Amount of time your Lambda Function has to run in seconds. Defaults to 3. See Limits."
  value       = aws_lambda_function.main.timeout
}

output "tracing_config" {
  description = "Configuration block. Detailed below."
  value       = aws_lambda_function.main.tracing_config
}

output "vpc_config" {
  description = "Configuration block. Detailed below."
  value       = aws_lambda_function.main.vpc_config
}

output "arn" {
  description = "Amazon Resource Name identifying your Lambda Function."
  value       = aws_lambda_function.main.arn
}

output "invoke_arn" {
  description = "ARN to be used for invoking Lambda Function from API Gateway to be used in aws_api_gateway_integration's uri."
  value       = aws_lambda_function.main.invoke_arn
}

output "last_modified" {
  description = "Date this resource was last modified."
  value       = aws_lambda_function.main.last_modified
}

output "qualified_arn" {
  description = "ARN identifying your Lambda Function Version (if versioning is enabled via publish = true)."
  value       = aws_lambda_function.main.qualified_arn
}

output "signing_job_arn" {
  description = "ARN of the signing job."
  value       = aws_lambda_function.main.signing_job_arn
}

output "signing_profile_version_arn" {
  description = "ARN of the signing profile version."
  value       = aws_lambda_function.main.signing_profile_version_arn
}

output "source_code_size" {
  description = "Size in bytes of the function .zip file."
  value       = aws_lambda_function.main.source_code_size
}

output "tags_all" {
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block."
  value       = aws_lambda_function.main.tags_all
}

output "version" {
  description = "Latest published version of your Lambda Function."
  value       = aws_lambda_function.main.version
}

output "vpc_config_vpc_id" {
  description = "ID of the VPC."
  value       = aws_lambda_function.main.vpc_config.*.vpc_id
}

output "alias_name" {
  description = "Name for the alias you are creating. Pattern: (?!^[0-9]+$)([a-zA-Z0-9-_]+)"
  value       = element(concat(aws_lambda_alias.main.*.name, [""]), 0)
}

output "alias_description" {
  description = "Description of the alias."
  value       = element(concat(aws_lambda_alias.main.*.description, [""]), 0)
}

output "alias_function_name" {
  description = "Lambda Function name or ARN."
  value       = element(concat(aws_lambda_alias.main.*.function_name, [""]), 0)
}

output "alias_function_version" {
  description = "Lambda function version for which you are creating the alias. Pattern: (\\$LATEST|[0-9]+)."
  value       = element(concat(aws_lambda_alias.main.*.function_version, [""]), 0)
}

output "alias_routing_config" {
  description = "The Lambda alias' route configuration settings. Fields documented below"
  value       = element(concat(aws_lambda_alias.main.*.routing_config, [""]), 0)
}

output "alias_arn" {
  description = "The Amazon Resource Name identifying your Lambda function alias."
  value       = element(concat(aws_lambda_alias.main.*.arn, [""]), 0)
}

output "alias_invoke_arn" {
  description = "The ARN to be used for invoking Lambda Function from API Gateway to be used in aws_api_gateway_integration's uri"
  value       = element(concat(aws_lambda_alias.main.*.invoke_arn, [""]), 0)
}

output "permission_action" {
  description = "The AWS Lambda action you want to allow in this statement. (e.g. lambda:InvokeFunction)"
  value       = element(concat(aws_lambda_permission.main.*.action, [""]), 0)
}

output "permission_event_source_token" {
  description = "The Event Source Token to validate. Used with Alexa Skills."
  value       = element(concat(aws_lambda_permission.main.*.event_source_token, [""]), 0)
}

output "permission_function_name" {
  description = "Name of the Lambda function whose resource policy you are updating"
  value       = element(concat(aws_lambda_permission.main.*.function_name, [""]), 0)
}

output "permission_principal" {
  description = "The principal who is getting this permission. e.g. s3.amazonaws.com, an AWS account ID, or any valid AWS service principal such as events.amazonaws.com or sns.amazonaws.com."
  value       = element(concat(aws_lambda_permission.main.*.principal, [""]), 0)
}

output "permission_qualifier" {
  description = "Query parameter to specify function version or alias name. The permission will then apply to the specific qualified ARN. e.g. arn:aws:lambda:aws-region:acct-id:function:function-name:2"
  value       = element(concat(aws_lambda_permission.main.*.qualifier, [""]), 0)
}

output "permission_source_account" {
  description = "of the source owner."
  value       = element(concat(aws_lambda_permission.main.*.source_account, [""]), 0)
}

output "permission_source_arn" {
  description = "When the principal is an AWS service, the ARN of the specific resource within that service to grant permission to. Without this, any resource from principal will be granted permission even if that resource is from another account. For S3, this should be the ARN of the S3 Bucket. For CloudWatch Events, this should be the ARN of the CloudWatch Events Rule. For API Gateway, this should be the ARN of the API, as described here."
  value       = element(concat(aws_lambda_permission.main.*.source_arn, [""]), 0)
}

output "permission_statement_id" {
  description = "A unique statement identifier. By default generated by Terraform."
  value       = element(concat(aws_lambda_permission.main.*.statement_id, [""]), 0)
}

output "permission_statement_id_prefix" {
  description = "A statement identifier prefix. Terraform will generate a unique suffix. Conflicts with statement_id."
  value       = element(concat(aws_lambda_permission.main.*.statement_id_prefix, [""]), 0)
}

output "alias_permission_action" {
  description = "The AWS Lambda action you want to allow in this statement. (e.g. lambda:InvokeFunction)"
  value       = element(concat(aws_lambda_permission.alias.*.action, [""]), 0)
}

output "alias_permission_event_source_token" {
  description = "The Event Source Token to validate. Used with Alexa Skills."
  value       = element(concat(aws_lambda_permission.alias.*.event_source_token, [""]), 0)
}

output "alias_permission_function_name" {
  description = "Name of the Lambda function whose resource policy you are updating"
  value       = element(concat(aws_lambda_permission.alias.*.function_name, [""]), 0)
}

output "alias_permission_principal" {
  description = "The principal who is getting this permission. e.g. s3.amazonaws.com, an AWS account ID, or any valid AWS service principal such as events.amazonaws.com or sns.amazonaws.com."
  value       = element(concat(aws_lambda_permission.alias.*.principal, [""]), 0)
}

output "alias_permission_qualifier" {
  description = "Query parameter to specify function version or alias name. The permission will then apply to the specific qualified ARN. e.g. arn:aws:lambda:aws-region:acct-id:function:function-name:2"
  value       = element(concat(aws_lambda_permission.alias.*.qualifier, [""]), 0)
}

output "alias_permission_source_account" {
  description = "of the source owner."
  value       = element(concat(aws_lambda_permission.alias.*.source_account, [""]), 0)
}

output "alias_permission_source_arn" {
  description = "When the principal is an AWS service, the ARN of the specific resource within that service to grant permission to. Without this, any resource from principal will be granted permission even if that resource is from another account. For S3, this should be the ARN of the S3 Bucket. For CloudWatch Events, this should be the ARN of the CloudWatch Events Rule. For API Gateway, this should be the ARN of the API, as described here."
  value       = element(concat(aws_lambda_permission.alias.*.source_arn, [""]), 0)
}

output "alias_permission_statement_id" {
  description = "A unique statement identifier. By default generated by Terraform."
  value       = element(concat(aws_lambda_permission.alias.*.statement_id, [""]), 0)
}

output "alias_permission_statement_id_prefix" {
  description = "A statement identifier prefix. Terraform will generate a unique suffix. Conflicts with statement_id."
  value       = element(concat(aws_lambda_permission.alias.*.statement_id_prefix, [""]), 0)
}

output "log_group_name" {
  description = "The name of the log group. If omitted, Terraform will assign a random, unique name."
  value       = aws_cloudwatch_log_group.lambda.name
}

output "log_group_name_prefix" {
  description = "Creates a unique name beginning with the specified prefix. Conflicts with name."
  value       = aws_cloudwatch_log_group.lambda.name_prefix
}

output "log_group_retention_in_days" {
  description = "Specifies the number of days you want to retain log events in the specified log group. Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653, and 0. If you select 0, the events in the log group are always retained and never expire."
  value       = aws_cloudwatch_log_group.lambda.retention_in_days
}

output "log_group_kms_key_id" {
  description = "The ARN of the KMS Key to use when encrypting log data. Please note, after the AWS KMS CMK is disassociated from the log group, AWS CloudWatch Logs stops encrypting newly ingested data for the log group. All previously ingested data remains encrypted, and AWS CloudWatch Logs requires permissions for the CMK whenever the encrypted data is requested."
  value       = aws_cloudwatch_log_group.lambda.kms_key_id
}

output "log_group_tags" {
  description = "A map of tags to assign to the resource. If configured with a provider default_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level."
  value       = aws_cloudwatch_log_group.lambda.tags
}

output "log_group_arn" {
  description = "The Amazon Resource Name specifying the log group. Any :* suffix added by the API, denoting all CloudWatch Log Streams under the CloudWatch Log Group, is removed for greater compatibility with other AWS services that do not accept the suffix."
  value       = aws_cloudwatch_log_group.lambda.arn
}

output "log_group_tags_all" {
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block."
  value       = aws_cloudwatch_log_group.lambda.tags_all
}
