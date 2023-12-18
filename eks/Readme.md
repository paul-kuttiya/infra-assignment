# Amazon EKS
This guide provides step-by-step instructions to set up EKS and deploy the project. Deployment time is approximately 15-20 minutes.

- [Prerequisites](#prerequisites)
- [Quick Start Guide](#quick-start-guide)
- [Detailed Steps](#detailed-steps)
- [Usage](#usage)
- [Cleaning Up](#cleaning-up)
- [Resources](#resources)

## Prerequisites

Before you begin, ensure that you have the following tools installed on your local machine:

- [Docker](https://www.docker.com/get-started)
- [eksctl](https://eksctl.io/)
- [Helm](https://helm.sh/docs/intro/install/)
- [AWS CLI](https://aws.amazon.com/cli/) (Command-Line Interface)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) (Kubernetes Command-Line Tool)

> Ensure that you have the necessary AWS permissions, including Administrator access.

## Quick start guide
Makefile Targets

| Target              | Description                                          |
|---------------------|------------------------------------------------------|
| `create-cluster`    | Creates an EKS cluster named "infra-api" in the "us-east-1" region with specified configurations. |
| `install-helm`      | Installs the Helm chart named "epoch-api" located in the "helm" directory.                        |
| `get-deployment`    | Retrieves information about the Kubernetes deployment named "epoch-api".                         |
| `get-services`      | Retrieves information about the Kubernetes services associated with "epoch-api".                |
| `destroy`           | Deletes the EKS cluster named "infra-api" in the "us-east-1" region.                             |
| `docker-build`      | Builds a Docker image tagged with the specified repository and tag.                              |
| `docker-push`       | Pushes the Docker image to the specified Docker repository.                                      |
| `make-request`      | Makes a request to the deployed service, retrieving the ELB hostname and using cURL to make a request to port 8080. |


## Detailed steps

### Step 1: cd into eks

```bash
cd eks
```

### Step 2: Deploy an EKS Cluster and Install Helm
Set up an Amazon EKS cluster named "infra-api" in the us-east-1 region. A specific node group will be created for the cluster, and Helm will be installed within the default namespace of the cluster nodes.
```bash
make deploy
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

## Resources
Table for resources that will be created
| Resource Type         | Resource Name | Description                                      |
|-----------------------|---------------|--------------------------------------------------|
| **EKS Cluster**       | `infra-api`      | Amazon EKS Cluster named "infra-api" in the `us-east-1` region with a node group named "infra-api-nodegroup" using `t3.medium` instances. |
| **Service**           | `epoch-api` | Kubernetes Service with type LoadBalancer, exposing port 8080 and forwarding to port 5000. |
| **Deployment**        | `epoch-api` | Kubernetes Deployment with 3 replicas, using the container image `pkuttiya/epoch-time-api:latest` and exposing port 5000. |
