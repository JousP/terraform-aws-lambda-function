# terraform-aws-lambda-function
Terraform module to deploy a lambda function, role and cloudwatch log group

This Module creates:
- 1 aws_lambda_function
- 1 aws_cloudwatch_log_group for the lambda function
- (optionally) 1 aws_lambda_alias
- (optionally) 1 aws_lambda_permission to allow external sources invoking the Lambda function (e.g. CloudWatch Event Rule, SNS or S3).
