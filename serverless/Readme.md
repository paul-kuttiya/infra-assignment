# AWS Lambda Function Deployment

This guide provides step-by-step instructions to deploy an AWS Lambda function and associated infrastructure using Terraform.

## Prerequisites

Before you begin, make sure you have the following tools installed on your local machine:

- [AWS CLI](https://aws.amazon.com/cli/) (Command-Line Interface)
- [Terraform](https://www.terraform.io/downloads.html)

## Getting Started

### Step 1: Clone the Repository and cd into serverless

```bash
clone repo

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
