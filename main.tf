# Create the Lambda Function
resource "aws_lambda_function" "main" {
  count                          = var.enabled ? 1 : 0
  filename                       = var.filename
  s3_bucket                      = var.s3_bucket
  s3_key                         = var.s3_key
  s3_object_version              = var.s3_object_version
  function_name                  = var.function_name
  handler                        = var.handler
  role                           = var.role
  description                    = var.description
  layers                         = var.layers
  memory_size                    = var.memory_size
  runtime                        = var.runtime
  timeout                        = var.timeout
  reserved_concurrent_executions = var.reserved_concurrent_executions
  publish                        = var.publish
  kms_key_arn                    = var.kms_key_arn
  source_code_hash               = var.source_code_hash
  tags                           = var.tags
  dynamic "dead_letter_config" {
    for_each     = var.dead_letter_config == null ? [] : [var.dead_letter_config]
    content {
      target_arn = lookup(dead_letter_config.value, "target_arn", null)
    }
  }
  dynamic "vpc_config" {
    for_each             = var.vpc_config == null ? [] : [var.vpc_config]
    content {
      subnet_ids         = vpc_config.value.subnet_ids
      security_group_ids = vpc_config.value.security_group_ids
    }
  }
  dynamic "environment" {
    for_each    = var.environment == null ? [] : [var.environment]
    content {
      variables = environment.value.variables
    }
  }
  dynamic "tracing_config" {
    for_each = var.tracing_config == null ? [] : [var.tracing_config]
    content {
      mode   = tracing_config.value.mode
    }
  }
  lifecycle {
    ignore_changes = [last_modified, filename]
  }
}

# Creates a Lambda function alias.
resource "aws_lambda_alias" "main" {
  count            = var.enabled && var.create_alias ? 1 : 0
  name             = var.alias_name
  description      = "${var.function_name} ${var.alias_name} version"
  function_name    = aws_lambda_function.main[0].arn
  function_version = var.alias_function_version
}

# Allow `permission_principal` to Trigger Lambda Execution
locals {
  id            = "${var.function_name}_${element(split(".", var.permission_principal), 0)}"
  permission_sid = var.permission_statement_id != null ? var.permission_statement_id : var.permission_statement_id_prefix != null ? var.permission_statement_id : local.id
  alias_id  = "${var.function_name}_${element(split(".", var.alias_permission_principal), 0)}"
  alias_permission_sid = var.alias_permission_statement_id != null ? var.alias_permission_statement_id : var.alias_permission_statement_id_prefix != null ? var.alias_permission_statement_id : local.alias_id
}

resource "aws_lambda_permission" "main" {
  count               = var.enabled && var.permission_principal != "" ? 1 : 0
  function_name       = aws_lambda_function.main[0].arn
  action              = var.permission_action
  event_source_token  = var.permission_event_source_token
  principal           = var.permission_principal
  source_arn          = var.permission_source_arn
  statement_id        = local.permission_sid
  statement_id_prefix = var.permission_statement_id_prefix
}

resource "aws_lambda_permission" "alias" {
  count               = var.enabled && var.create_alias && var.alias_permission_principal != "" ? 1 : 0
  function_name       = aws_lambda_function.main[0].arn
  action              = var.alias_permission_action
  event_source_token  = var.permission_event_source_token
  principal           = var.alias_permission_principal
  qualifier           = var.alias_name
  source_arn          = var.alias_permission_source_arn
  statement_id        = local.alias_permission_sid
  statement_id_prefix = var.alias_permission_statement_id_prefix
  depends_on          = [aws_lambda_alias.main]
}

# Lambda functions automaticly logs... place some retention policy
resource "aws_cloudwatch_log_group" "lambda" {
  count             = var.enabled ? 1 : 0
  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = var.log_group_retention_in_days
  tags              = var.tags
}
