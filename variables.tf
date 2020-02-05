variable "function_name" {
  description = "(Required) A unique name for your Lambda Function."
}

variable "description" {
  description = "(Required) Description of what your Lambda Function does."
}

variable "filename" {
  description = "(Required) The path to the function's deployment package within the local filesystem."
}

variable "handler" {
  description = "(Required) The function entrypoint in your code."
}

variable "role" {
  description = "(Required) IAM role attached to the Lambda Function. This governs both who / what can invoke your Lambda Function, as well as what resources our Lambda Function has access to. See Lambda Permission Model for more details."
}

variable "runtime" {
  description = "(Required) See Runtimes for valid values."
}

variable "memory_size" {
  description = "(Optional) Amount of memory in MB your Lambda Function can use at runtime. Defaults to 128. See Limits"
  default     = 128
}

variable "timeout" {
  description = "(Optional) The amount of time your Lambda Function has to run in seconds. Defaults to 3. See Limits"
  default     = 3
}

variable "reserved_concurrent_executions" {
  description = "(Optional) The amount of reserved concurrent executions for this lambda function. Defaults to Unreserved Concurrency Limits. See Managing Concurrency"
  default     = "-1"
}

variable "publish" {
  description = "(Optional) Whether to publish creation/change as new Lambda Function Version. Defaults to false."
  default     = false
}

variable "vpc_subnet_ids" {
  description = "(Optional) Provide this to allow your function to access your VPC. A list of subnet IDs associated with the Lambda function."
  default     = []
  type        = "list"
}

variable "vpc_security_group_ids" {
  description = "(Optional) Provide this to allow your function to access your VPC. A list of security group IDs associated with the Lambda function."
  default     = []
  type        = "list"
}

variable "environment_variables" {
  description = "(Optional) The Lambda environment's configuration settings. A map that defines environment variables for the Lambda function."
  default     = {empty = ""}
  type        = "map"
}

variable "kms_key_arn" {
  description = "(Optional) The ARN for the KMS encryption key."
  default     = ""
}

variable "source_code_hash" {
  description = "(Optional) Used to trigger updates. Must be set to a base64-encoded SHA256 hash of the package file specified with either filename or s3_key. The usual way to set this is ${base64sha256(file("file.zip"))}, where \"file.zip\" is the local filename of the lambda function source archive."
  default     = ""
}

variable "alias_name" {
  description = "(Optional) Name of the aws_lambda_alias."
  default     = "latest"
}

variable "alias_function_version" {
  description = "(Optional) Version of the lambda function for the alias."
  default     = "$LATEST"
}

variable "permission_principal" {
  description = "(Required) The principal who is getting this permission. e.g. s3.amazonaws.com, an AWS account ID, or any valid AWS service principal such as events.amazonaws.com or sns.amazonaws.com."
  default     = ""
}

variable "permission_action" {
  description = "(Optional) The AWS Lambda action you want to allow in this statement. (e.g. lambda:InvokeFunction)"
  default     = "lambda:InvokeFunction"
}

variable "permission_source_account" {
  description = "(Optional) This parameter is used for S3 and SES. The AWS account ID (without a hyphen) of the source owner."
  default     = ""
}

variable "permission_source_arn" {
  description = "(Optional) When granting Amazon S3 or CloudWatch Events permission to invoke your function, you should specify this field with the Amazon Resource Name (ARN) for the S3 Bucket or CloudWatch Events Rule as its value. This ensures that only events generated from the specified bucket or rule can invoke the function. API Gateway ARNs have a unique structure described here."
  default     = ""
}

variable "log_group_retention_in_days" {
  description = "(Optional) Specifies the number of days you want to retain log events in the specified log group."
  default     = 7
}

variable "tags" {
  description = "(Optional) Map of tags to add to all resources"
  type        = "map"
  default     = {}
}

### Avoid resources creation
variable "create_alias" {
  description = "Whether to create an aws_lambda_alias"
  default     = false
}

variable "enabled" {
  description = "Whether resources have to be deployed"
  default     = true
}
