resource "aws_iam_role" "lambda" {
  name               = "lambda-basic-example"
  assume_role_policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "lambda.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
  }
  EOF
}

resource "aws_iam_role_policy_attachment" "lambda_role" {
  role       = "${aws_iam_role.lambda.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

data "null_data_source" "lambda_file" {
  inputs = {
    filename = "lambda/main.py"
  }
}

data "null_data_source" "lambda_archive" {
  inputs = {
    filename = "lambda/main.zip"
  }
}

data "archive_file" "lambda_filename" {
  type        = "zip"
  source_file = "${data.null_data_source.lambda_file.outputs.filename}"
  output_path = "${data.null_data_source.lambda_archive.outputs.filename}"
}

module "lambda_custom" {
  source                 = "JousP/lambda-function/aws"
  version                = "~> 1.0"
  function_name          = "custom-example"
  description            = "custom-example function"
  create_alias           = true
  filename               = "${data.archive_file.lambda_filename.output_path}"
  source_code_hash       = "${data.archive_file.lambda_filename.output_base64sha256}"
  handler                = "main.handler"
  role                   = "${aws_iam_role.lambda.arn}"
  runtime                = "python3.6"
  memory_size            = 512
  timeout                = 15
  publish                = true
  vpc_subnet_ids         = ["${aws_subnet.aza.id}", "${aws_subnet.azb.id}"]
  vpc_security_group_ids = ["${aws_security_group.sg.id}"]
  environment_variables  = "${map("test", "1")}"
  permission_principal   = "events.amazonaws.com"
  tags                   = "${local.tags}"
}

output "lambda_custom_arn" {
  description = "The Amazon Resource Name (ARN) identifying your Lambda Function."
  value       = "${module.lambda_custom.arn}"
}

output "lambda_custom_qualified_arn" {
  description = "The Amazon Resource Name (ARN) identifying your Lambda Function Version (if versioning is enabled via publish = true)."
  value       = "${module.lambda_custom.qualified_arn}"
}

output "lambda_custom_qualifier" {
  description = "The name identifying your Lambda Function Version (if versioning is enabled via publish = true)."
  value       = "${module.lambda_custom.qualifier}"
}

output "lambda_custom_invoke_arn" {
  description = "The ARN to be used for invoking Lambda Function from API Gateway to be used in aws_api_gateway_integration's uri"
  value       = "${module.lambda_custom.invoke_arn}"
}

output "lambda_custom_version" {
  description = "Latest published version of your Lambda Function."
  value       = "${module.lambda_custom.version}"
}

output "lambda_custom_last_modified" {
  description = "The date this resource was last modified."
  value       = "${module.lambda_custom.last_modified}"
}

output "lambda_custom_source_code_hash" {
  description = "Base64-encoded representation of raw SHA-256 sum of the zip file provided either via filename or s3_* parameters."
  value       = "${module.lambda_custom.source_code_hash}"
}

output "lambda_custom_alias_arn" {
  description = "The Amazon Resource Name (ARN) identifying the Lambda function alias."
  value       = "${module.lambda_custom.alias_arn}"
}

output "lambda_custom_log_group_arn" {
  description = "The Amazon Resource Name (ARN) specifying the log group for the lambda function."
  value       = "${module.lambda_custom.log_group_arn}"
}

output "lambda_custom_log_group_name" {
  description = "The Name of the log group for the lambda function."
  value       = "${module.lambda_custom.log_group_name}"
}

output "lambda_custom_log_group_retention_in_days" {
  description = "The number of days log events are retained in the log group for the lambda function."
  value       = "${module.lambda_custom.log_group_retention_in_days}"
}

output "lambda_custom_log_group_tags" {
  description = "Tags associated with the log group for the lambda function."
  value       = "${module.lambda_custom.log_group_tags}"
}
