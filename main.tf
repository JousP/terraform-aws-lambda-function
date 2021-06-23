# Create the Lambda Function
resource "aws_lambda_function" "main" {
  function_name                  = var.function_name
  role                           = var.role
  code_signing_config_arn        = var.code_signing_config_arn
  description                    = var.description
  filename                       = var.filename
  handler                        = var.handler
  image_uri                      = var.image_uri
  kms_key_arn                    = var.kms_key_arn
  layers                         = var.layers
  memory_size                    = var.memory_size
  package_type                   = var.package_type
  publish                        = var.publish
  reserved_concurrent_executions = var.reserved_concurrent_executions
  runtime                        = var.runtime
  s3_bucket                      = var.s3_bucket
  s3_key                         = var.s3_key
  s3_object_version              = var.s3_object_version
  source_code_hash               = var.source_code_hash != null ? var.source_code_hash : filebase64sha256(var.filename)
  tags                           = var.tags
  timeout                        = var.timeout
  dynamic "dead_letter_config" {
    for_each = var.dead_letter_config == null ? [] : [var.dead_letter_config]
    content {
      target_arn = dead_letter_config.value.target_arn
    }
  }
  dynamic "environment" {
    for_each = var.environment == null ? [] : [var.environment]
    content {
      variables = environment.value.variables
    }
  }
  dynamic "file_system_config" {
    for_each = var.file_system_config == null ? [] : [var.file_system_config]
    content {
      arn              = file_system_config.value.arn
      local_mount_path = file_system_config.value.local_mount_path
    }
  }
  dynamic "image_config" {
    for_each = var.image_config == null ? [] : [var.image_config]
    content {
      command           = image_config.value.command
      entry_point       = image_config.value.entry_point
      working_directory = image_config.value.working_directory
    }
  }
  dynamic "tracing_config" {
    for_each = var.tracing_config == null ? [] : [var.tracing_config]
    content {
      mode = tracing_config.value.mode
    }
  }
  dynamic "vpc_config" {
    for_each = var.vpc_config == null ? [] : [var.vpc_config]
    content {
      subnet_ids         = vpc_config.value.subnet_ids
      security_group_ids = vpc_config.value.security_group_ids
    }
  }
  #  lifecycle {
  #    ignore_changes = [last_modified, filename]
  #  }
}

# Creates a Lambda function alias.
resource "aws_lambda_alias" "main" {
  count            = var.create_alias ? 1 : 0
  name             = var.alias_name
  description      = "${var.function_name} ${var.alias_name} version"
  function_name    = aws_lambda_function.main.arn
  function_version = var.alias_function_version
  dynamic "routing_config" {
    for_each = var.alias_routing_config == null ? [] : [var.alias_routing_config]
    content {
      additional_version_weights = routing_config.value.additional_version_weights
    }
  }
}

# Allow `permission_principal` to Trigger Lambda Execution
locals {
  id                   = "${var.function_name}_${element(split(".", coalesce(var.permission_principal, "default")), 0)}"
  permission_sid       = coalesce(var.permission_statement_id, var.permission_statement_id_prefix, local.id)
  alias_id             = "${var.function_name}_${element(split(".", coalesce(var.alias_permission_principal, "default")), 0)}"
  alias_permission_sid = coalesce(var.alias_permission_statement_id, var.alias_permission_statement_id_prefix, local.alias_id)
}

resource "aws_lambda_permission" "main" {
  count               = var.permission_principal != null ? 1 : 0
  action              = var.permission_action
  event_source_token  = var.permission_event_source_token
  function_name       = aws_lambda_function.main.id
  principal           = var.permission_principal
  qualifier           = var.permission_qualifier
  source_account      = var.permission_source_account
  source_arn          = var.permission_source_arn
  statement_id        = local.permission_sid
  statement_id_prefix = var.permission_statement_id_prefix
}

resource "aws_lambda_permission" "alias" {
  count               = var.create_alias && var.alias_permission_principal != null ? 1 : 0
  action              = var.alias_permission_action
  event_source_token  = var.permission_event_source_token
  function_name       = aws_lambda_function.main.id
  principal           = var.alias_permission_principal
  qualifier           = aws_lambda_alias.main[0].name
  source_account      = var.alias_permission_source_account
  source_arn          = var.alias_permission_source_arn
  statement_id        = local.alias_permission_sid
  statement_id_prefix = var.alias_permission_statement_id_prefix
}

# Lambda functions automaticly logs... place some retention policy
resource "aws_cloudwatch_log_group" "lambda" {
  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = var.log_group_retention_in_days
  tags              = var.tags
}
