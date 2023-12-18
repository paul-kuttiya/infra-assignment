# AWS Serverless Deployment
This guide provides step-by-step instructions to deploy an AWS Lambda function and associated infrastructure using Terraform.

- [Prerequisites](#prerequisites)
- [Quick Start Guide](#quick-start-guide)
- [Detailed Steps](#detailed-steps)
- [Usage](#usage)
- [Cleaning Up](#cleaning-up)
- [Resources](#resources)

## Prerequisites

Before you begin, make sure you have the following tools installed on your local machine:

- [AWS CLI](https://aws.amazon.com/cli/) (Command-Line Interface)
- [Terraform](https://www.terraform.io/downloads.html)

> Ensure that you have the necessary AWS permissions, including Administrator access.

## Quick start guide
Makefile Targets

| Target            | Description                                                  |
|-------------------|--------------------------------------------------------------|
| `deploy`          | Cleans, zips Lambda function code, deploys AWS infrastructure using Terraform, and saves the API endpoint. |
| `aws-deploy`      | Initializes Terraform, plans, and applies the AWS infrastructure. After deployment, removes zip files. |
| `save-api-endpoint`| Saves the API endpoint to a file named `api_endpoint.txt`.    |
| `make-request`    | Makes a request to the saved API endpoint using cURL.        |
| `clean`           | Cleans up by removing the Lambda deployment ZIP file.        |
| `zip`             | Creates a ZIP file for Lambda deployment containing the specified `HANDLER_FILE`. |
| `destroy`         | Cleans, zips Lambda function code, and destroys AWS infrastructure using Terraform. After destruction, removes zip files. |

## Detailed steps

### Step 1: cd into serverless

```bash
cd serverless
```

### Step 2: Deploy AWS Lambda Function and Infrastructure
Create an AWS Lambda function named epoch-time-lambda and associated infrastructure using Terraform.
```bash
make deploy
```

## Usage
The Lambda function and infrastructure are now deployed and ready to use.
Terraform output will also include
```
api_endpoint = api_endpoint
cloudwatch_log_group_url = aws_console_cloudwatch_url
```

### making a request to the endpoint
```bash
# curl to output from endpoint
make make-request
```

## Cleaning Up
Remove all infrastructure.
```bash
make destroy
```

## Resources
Table for resources that will be created

| Resource Type | Resource Name                     | Description                                                                                                                                                 |
|---------------|-----------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `aws_lambda_function` | `epoch_time_lambda`            | AWS Lambda function named "epoch-time-lambda" with Python 3.8 runtime, handling `index.lambda_handler`, and sourced from "../lambda_function.zip".             |
| `aws_iam_role`        | `lambda_exec_role`             | IAM role named "lambda-exec-role" with a trust policy allowing Lambda and API Gateway to assume the role.                                                    |
| `aws_apigatewayv2_api`| `api`                          | API Gateway named "epoch-time-api" with HTTP protocol.                                                                                                      |
| `aws_apigatewayv2_integration` | `lambda_integration`    | Integration between the Lambda function and API Gateway using AWS_PROXY for POST requests.                                                                   |
| `aws_apigatewayv2_route`       | `route`                    | Route for the API Gateway to handle GET requests and forward them to the Lambda integration.                                                                |
| `aws_apigatewayv2_stage`       | `stage`                    | Stage for the API Gateway with an optional environment variable, set to auto-deploy.                                                                         |
| `aws_cloudwatch_log_group`     | `lambda_log_group`          | CloudWatch log group named "/aws/lambda/epoch-time-lambda" for the Lambda function with a retention period of 3 days.                                        |
| `aws_iam_policy`               | `lambda_logs_policy`        | IAM policy named "lambda-logs-policy" allowing the Lambda function to create log streams and put log events in the specified CloudWatch log group.           |
| `aws_iam_role_policy_attachment`| `lambda_logs_attachment`   | Attachment of the IAM policy for Lambda logs to the Lambda execution role.                                                                                    |
| `aws_lambda_permission`        | `allow_execution_from_apigateway` | Lambda permission allowing the API Gateway to invoke the "epoch-time-lambda" function.                                                                   |
