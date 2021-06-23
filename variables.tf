variable "function_name" {
  description = "(Required) A unique name for your Lambda Function."
  type        = string
}

variable "role" {
  description = "(Required) IAM role attached to the Lambda Function. This governs both who / what can invoke your Lambda Function, as well as what resources our Lambda Function has access to. See Lambda Permission Model for more details."
  type        = string
}

variable "code_signing_config_arn" {
  description = "(Optional) To enable code signing for this function, specify the ARN of a code-signing configuration. A code-signing configuration includes a set of signing profiles, which define the trusted publishers for this function."
  type        = string
  default     = null
}

variable "description" {
  description = "(Optional) Description of what your Lambda Function does."
  type        = string
  default     = null
}

variable "filename" {
  description = "(Optional) Path to the function's deployment package within the local filesystem. Conflicts with image_uri, s3_bucket, s3_key, and s3_object_version."
  type        = string
  default     = null
}

variable "handler" {
  description = "(Optional) Function entrypoint in your code."
  type        = string
  default     = null
}

variable "image_uri" {
  description = "(Optional) ECR image URI containing the function's deployment package. Conflicts with filename, s3_bucket, s3_key, and s3_object_version."
  type        = string
  default     = null
}

variable "kms_key_arn" {
  description = "(Optional) Amazon Resource Name (ARN) of the AWS Key Management Service (KMS) key that is used to encrypt environment variables. If this configuration is not provided when environment variables are in use, AWS Lambda uses a default service key. If this configuration is provided when environment variables are not in use, the AWS Lambda API does not save this configuration and Terraform will show a perpetual difference of adding the key. To fix the perpetual difference, remove this configuration."
  type        = string
  default     = null
}

variable "layers" {
  description = "(Optional) List of Lambda Layer Version ARNs (maximum of 5) to attach to your Lambda Function. See Lambda Layers"
  type        = list(string)
  default     = null
}

variable "memory_size" {
  description = "(Optional) Amount of memory in MB your Lambda Function can use at runtime. Defaults to 128. See Limits"
  type        = number
  default     = null
}

variable "package_type" {
  description = "(Optional) Lambda deployment package type. Valid values are Zip and Image. Defaults to Zip."
  type        = string
  default     = null
}

variable "publish" {
  description = "(Optional) Whether to publish creation/change as new Lambda Function Version. Defaults to false."
  type        = bool
  default     = null
}

variable "reserved_concurrent_executions" {
  description = "(Optional) Amount of reserved concurrent executions for this lambda function. A value of 0 disables lambda from being triggered and -1 removes any concurrency limitations. Defaults to Unreserved Concurrency Limits -1. See Managing Concurrency"
  type        = number
  default     = null
}

variable "runtime" {
  description = "(Optional) Identifier of the function's runtime. See Runtimes for valid values."
  type        = string
  default     = null
}

variable "s3_bucket" {
  description = "(Optional) S3 bucket location containing the function's deployment package. Conflicts with filename and image_uri. This bucket must reside in the same AWS region where you are creating the Lambda function."
  type        = string
  default     = null
}

variable "s3_key" {
  description = "(Optional) S3 key of an object containing the function's deployment package. Conflicts with filename and image_uri."
  type        = string
  default     = null
}

variable "s3_object_version" {
  description = "(Optional) Object version containing the function's deployment package. Conflicts with filename and image_uri."
  type        = string
  default     = null
}

variable "source_code_hash" {
  description = "(Optional) Used to trigger updates. Must be set to a base64-encoded SHA256 hash of the package file specified with either filename or s3_key. The usual way to set this is filebase64sha256(\"file.zip\") (Terraform 0.11.12 and later) or base64sha256(file(\"file.zip\")) (Terraform 0.11.11 and earlier), where \"file.zip\" is the local filename of the lambda function source archive."
  type        = string
  default     = null
}

variable "timeout" {
  description = "(Optional) Amount of time your Lambda Function has to run in seconds. Defaults to 3. See Limits."
  type        = number
  default     = null
}

variable "dead_letter_config" {
  description = "A map to configure the function's dead letter queue. It must contain one argument called `target_arn`- The ARN of an SNS topic or SQS queue to notify when an invocation fails. If this option is used, the function's IAM role must be granted suitable access to write to the target object, which means allowing either the sns:Publish or sqs:SendMessage action on this ARN, depending on which service is targeted."
  type = object({
    target_arn = string
  })
  default = null
}

variable "environment" {
  description = "A map that defines the Lambda environment's configuration settings. The map must have on attribute `variables` - A map that defines environment variables for the Lambda function."
  type = object({
    variables = map(string)
  })
  default = null
}

variable "file_system_config" {
  description = "(Optional) Connection settings for an EFS file system."
  type = object({
    arn              = string
    local_mount_path = string
  })
  default = null
}

variable "image_config" {
  description = "(Optional) Container image configuration values that override the values in the container image Dockerfile."
  type = object({
    command           = string
    entry_point       = string
    working_directory = string
  })
  default = null
}

variable "tracing_config" {
  description = "A map that describes the tracing configuration. The map must have one argument `mode` - Can be either PassThrough or Active. If PassThrough, Lambda will only trace the request from an upstream service if it contains a tracing header with \"sampled=1\". If Active, Lambda will respect any tracing header it receives from an upstream service. If no tracing header is received, Lambda will call X-Ray for a tracing decision."
  type = object({
    mode = string
  })
  default = null
}

variable "vpc_config" {
  description = "Provide this to allow your function to access your VPC. See Lambda in VPC. This variable is a map with 2 arguments : `subnet_ids` - (Required) A list of subnet IDs associated with the Lambda function. and `security_group_ids` - (Required) A list of security group IDs associated with the Lambda function."
  type = object({
    subnet_ids         = list(string)
    security_group_ids = list(string)
  })
  default = null
}

variable "alias_name" {
  description = "(Optional) Name of the aws_lambda_alias."
  type        = string
  default     = "latest"
}

variable "alias_function_version" {
  description = "(Optional) Version of the lambda function for the alias."
  type        = string
  default     = "$LATEST"
}

variable "alias_routing_config" {
  description = "(Optional) A map that defines the proportion of events that should be sent to different versions of a lambda function."
  type = object({
    additional_version_weights = map(number)
  })
  default = null
}

variable "permission_action" {
  description = "(Optional) The AWS Lambda action you want to allow in this statement. (e.g. lambda:InvokeFunction)"
  type        = string
  default     = "lambda:InvokeFunction"
}

variable "permission_event_source_token" {
  description = "(Optional) The Event Source Token to validate. Used with Alexa Skills."
  type        = string
  default     = null
}

variable "permission_principal" {
  description = "(Required) The principal who is getting this permission. e.g. s3.amazonaws.com, an AWS account ID, or any valid AWS service principal such as events.amazonaws.com or sns.amazonaws.com."
  type        = string
  default     = null
}

variable "permission_qualifier" {
  description = "(Optional) Query parameter to specify function version or alias name. The permission will then apply to the specific qualified ARN. e.g. arn:aws:lambda:aws-region:acct-id:function:function-name:2"
  type        = string
  default     = null
}

variable "permission_source_account" {
  description = "(Optional) This parameter is used for S3 and SES. The AWS account ID (without a hyphen) of the source owner."
  type        = string
  default     = null
}

variable "permission_source_arn" {
  description = "(Optional) When granting Amazon S3 or CloudWatch Events permission to invoke your function, you should specify this field with the Amazon Resource Name (ARN) for the S3 Bucket or CloudWatch Events Rule as its value. This ensures that only events generated from the specified bucket or rule can invoke the function. API Gateway ARNs have a unique structure described here."
  type        = string
  default     = null
}

variable "permission_statement_id" {
  description = "(Optional) A unique statement identifier. By default generated by Terraform."
  type        = string
  default     = null
}

variable "permission_statement_id_prefix" {
  description = "(Optional) A statement identifier prefix. Terraform will generate a unique suffix. Conflicts with statement_id."
  type        = string
  default     = null
}


variable "alias_permission_action" {
  description = "(Optional) The AWS Lambda action you want to allow in this statement. (e.g. lambda:InvokeFunction)"
  type        = string
  default     = "lambda:InvokeFunction"
}

variable "alias_permission_event_source_token" {
  description = "(Optional) The Event Source Token to validate. Used with Alexa Skills."
  type        = string
  default     = null
}

variable "alias_permission_principal" {
  description = "(Required) The principal who is getting this permission. e.g. s3.amazonaws.com, an AWS account ID, or any valid AWS service principal such as events.amazonaws.com or sns.amazonaws.com."
  type        = string
  default     = null
}

variable "alias_permission_source_account" {
  description = "(Optional) This parameter is used for S3 and SES. The AWS account ID (without a hyphen) of the source owner."
  type        = string
  default     = null
}

variable "alias_permission_source_arn" {
  description = "(Optional) When granting Amazon S3 or CloudWatch Events permission to invoke your function, you should specify this field with the Amazon Resource Name (ARN) for the S3 Bucket or CloudWatch Events Rule as its value. This ensures that only events generated from the specified bucket or rule can invoke the function. API Gateway ARNs have a unique structure described here."
  type        = string
  default     = null
}

variable "alias_permission_statement_id" {
  description = "(Optional) A unique statement identifier. By default generated by Terraform."
  type        = string
  default     = null
}

variable "alias_permission_statement_id_prefix" {
  description = "(Optional) A statement identifier prefix. Terraform will generate a unique suffix. Conflicts with statement_id."
  type        = string
  default     = null
}

variable "log_group_retention_in_days" {
  description = "(Optional) Specifies the number of days you want to retain log events in the specified log group. Default: 7"
  type        = number
  default     = 7
}

variable "tags" {
  description = "(Optional) Map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

### Avoid resources creation
variable "create_alias" {
  description = "Whether to create an aws_lambda_alias"
  type        = bool
  default     = false
}
