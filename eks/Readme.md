# Project Setup and Usage Guide
This guide provides step-by-step instructions to set up EKS and deploy the project. Deployment time is approximately 15-20 minutes.

## Prerequisites

Before you begin, ensure that you have the following tools installed on your local machine:

- [Docker](https://www.docker.com/get-started)
- [eksctl](https://eksctl.io/)
- [Helm](https://helm.sh/docs/intro/install/)
- [AWS CLI](https://aws.amazon.com/cli/) (Command-Line Interface)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) (Kubernetes Command-Line Tool)

## Getting Started

### Step 1: Clone the Repository and cd into eks

```bash
git clone ...
cd eks
```

### Step 2: Create an EKS Cluster
Create an Amazon EKS cluster named infra-api in the us-east-1 region with a specified node group.
```bash
make create-cluster
```

### Step 3: Install Helm Chart in EKS
Install the Helm chart (epoch-api) on the EKS cluster. The Helm chart includes configurations for the application.
```bash
make install-helm
```

### [Optional]: Docker Build and Push
The application image is already hosted on Docker Hub. For updating the code and image:
```bash
# login to docker hub
docker login

make docker-build-push
```

## Usage
The application is now deployed and ready to use

### Check the deployment status:
```bash
make get-deployment
```

### Check the services:
```bash
make get-services
```

### Make a request to the service
```bash
# will return a json reponse
make-request
```

## Cleaning Up
Remove all infrastructure.
```bash
make destroy
```