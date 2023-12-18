provider "aws" {
  region = "us-east-1"
}

resource "aws_lambda_function" "epoch_time_lambda" {
  function_name = "epoch-time-lambda"
  handler       = "index.lambda_handler"
  runtime       = "python3.8"
  filename      = "../lambda_function.zip"

  role = aws_iam_role.lambda_exec_role.arn

  source_code_hash = filebase64("../lambda_function.zip")

  environment {
    variables = {}
  }
}

resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda-exec-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "lambda.amazonaws.com",
          "apigateway.amazonaws.com"
        ]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_apigatewayv2_api" "api" {
  name          = "epoch-time-api"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "lambda_integration" {
  api_id             = aws_apigatewayv2_api.api.id
  integration_type   = "AWS_PROXY"
  integration_method = "POST"
  integration_uri    = aws_lambda_function.epoch_time_lambda.invoke_arn
}

resource "aws_apigatewayv2_route" "route" {
  api_id    = aws_apigatewayv2_api.api.id
  route_key = "GET /"

  target = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
}

resource "aws_apigatewayv2_stage" "stage" {
  api_id      = aws_apigatewayv2_api.api.id
  name        = var.environment
  auto_deploy = true
}

resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name              = "/aws/lambda/${aws_lambda_function.epoch_time_lambda.function_name}"
  retention_in_days = 3
}


# IAM policy for CloudWatch Logs
resource "aws_iam_policy" "lambda_logs_policy" {
  name        = "lambda-logs-policy"
  description = "IAM policy to allow Lambda to create log streams and put log events"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "${aws_cloudwatch_log_group.lambda_log_group.arn}:*"
    }
  ]
}
EOF
}

# Attach the IAM policy to the Lambda execution role
resource "aws_iam_role_policy_attachment" "lambda_logs_attachment" {
  policy_arn = aws_iam_policy.lambda_logs_policy.arn
  role       = aws_iam_role.lambda_exec_role.name
}

resource "aws_lambda_permission" "allow_execution_from_apigateway" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.epoch_time_lambda.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.api.execution_arn}/*/*/${replace(aws_apigatewayv2_route.route.route_key, "GET /", "")}"
}
