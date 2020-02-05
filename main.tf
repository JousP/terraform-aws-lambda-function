# Create the Lambda Function
resource "aws_lambda_function" "main" {
  count                          = "${var.enabled}"
  filename                       = "${var.filename}"
  function_name                  = "${var.function_name}"
#  dead_letter_config            = ["${var.dead_letter_config}"]
  handler                        = "${var.handler}"
  role                           = "${var.role}"
  description                    = "${var.description}"
  memory_size                    = "${var.memory_size}"
  runtime                        = "${var.runtime}"
  timeout                        = "${var.timeout}"
  reserved_concurrent_executions = "${var.reserved_concurrent_executions}"
  publish                        = "${var.publish}"
  vpc_config {
    subnet_ids                   = ["${var.vpc_subnet_ids}"]
    security_group_ids           = ["${var.vpc_security_group_ids}"]
  }
  environment {
    variables                    = "${var.environment_variables}"
  }
  kms_key_arn                    = "${var.kms_key_arn}"
  source_code_hash               = "${var.source_code_hash}"
  tags                           = "${var.tags}"
  lifecycle {
    ignore_changes               = ["last_modified", "filename"]
  }
}

# Creates a Lambda function alias.
resource "aws_lambda_alias" "main" {
  count            = "${var.enabled * var.create_alias}"
  name             = "${var.alias_name}"
  description      = "${var.function_name} ${var.alias_name} version"
  function_name    = "${aws_lambda_function.main.arn}"
  function_version = "${var.alias_function_version}"
}

# Allow `permission_principal` to Trigger Lambda Execution
locals {
  lambda_permission = "${var.permission_principal == "" ? 0 : 1}"
}

resource "aws_lambda_permission" "main" {
  count         = "${var.enabled * local.lambda_permission}"
  function_name = "${aws_lambda_function.main.arn}"
  action        = "${var.permission_action}"
  principal     = "${var.permission_principal}"
  statement_id  = "${var.function_name}_${element(split(".", var.permission_principal), 0)}"
  source_arn    = "${var.permission_source_arn}"
}

resource "aws_lambda_permission" "alias" {
  count         = "${var.enabled * var.create_alias * local.lambda_permission}"
  function_name = "${aws_lambda_function.main.arn}"
  action        = "${var.permission_action}"
  principal     = "${var.permission_principal}"
  statement_id  = "${var.function_name}_${element(split(".", var.permission_principal), 0)}"
  qualifier     = "${var.alias_name}"
  source_arn    = "${var.permission_source_arn}"
  depends_on    = ["aws_lambda_alias.main"]
}

# Lambda functions automaticly logs... place some retention policy
resource "aws_cloudwatch_log_group" "lambda" {
  count             = "${var.enabled}"
  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = "${var.log_group_retention_in_days}"
  tags              = "${var.tags}"
}
