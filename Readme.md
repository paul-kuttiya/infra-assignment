# Project Setup and Usage Guide

This project is designed to deploy the Flask Epoch API into the cloud, offering two deployment options:

1. **[AWS Serverless Deployment using Terraform:](#aws-serverless-deployment-using-terraform)**
   - Leverages Terraform for infrastructure provisioning, suitable for serverless architecture and simplified scaling.

2. **[Amazon EKS (Elastic Kubernetes Service) Deployment:](#amazon-eks-elastic-kubernetes-service-deployment)**
   - Utilizes Amazon EKS for orchestrating containerized applications,

## Minimum Required Versions Tools
| Tool         | Version   |
|--------------|-----------|
| Docker       | >=24.0.5  |
| kubectl      | >=1.26.2  |
| eksctl       | >=0.166.0 |
| Helm         | >=3.13.3  |
| AWS CLI      | >=2.11.1  |
| Terraform    | >=1.5.7   |

## Quick start guide
> Ensure that you have the necessary AWS permissions, including Administrator access.

### AWS Serverless Deployment using Terraform:
Deployment time apx 5 mins

#### Prerequisites

Before you begin, make sure you have the following tools installed on your local machine:

- [AWS CLI](https://aws.amazon.com/cli/) (Command-Line Interface)
- [Terraform](https://www.terraform.io/downloads.html)

#### Makefile Targets
Run `make` with the specified target below
| Target                  | Description                                        |
|-------------------------|----------------------------------------------------|
| `deploy-serverless`     | Deploys serverless resources.                      |
| `make-request-serverless`| Makes a request to the deployed serverless resources. |
| `destroy-serverless`    | Destroys serverless resources.                     |

#### Documentation
More info: [Documentation](./serverless/Readme.md)

### Amazon EKS (Elastic Kubernetes Service) Deployment:
Deployment time apx 15 mins

#### Prerequisites
Before you begin, ensure that you have the following tools installed on your local machine:

- [Docker](https://www.docker.com/get-started)
- [eksctl](https://eksctl.io/)
- [Helm](https://helm.sh/docs/intro/install/)
- [AWS CLI](https://aws.amazon.com/cli/) (Command-Line Interface)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) (Kubernetes Command-Line Tool)

#### Makefile Targets
Run `make` with the specified target below
| Target                  | Description                                        |
|-------------------------|----------------------------------------------------|
| `deploy-eks`            | Deploys EKS resources.                             |
| `make-request-eks`      | Makes a request to the deployed EKS resources.     |
| `destroy-eks`           | Destroys EKS resources.                            |

#### Documentation
More info: [Documentation](./eks/Readme.md)
