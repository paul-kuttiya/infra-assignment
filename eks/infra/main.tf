provider "aws" {
  region = "us-east-1"
}

data "aws_vpcs" "default" {
}

data "aws_subnet" "subnet_a" {
  count            = length(data.aws_vpcs.default.ids)
  vpc_id           = data.aws_vpcs.default.ids[count.index]
  availability_zone = "us-east-1a"
}

data "aws_subnet" "subnet_b" {
  count            = length(data.aws_vpcs.default.ids)
  vpc_id           = data.aws_vpcs.default.ids[count.index]
  availability_zone = "us-east-1b"
}

# Create IAM role for EKS cluster
resource "aws_iam_role" "eks_cluster_role" {
  name = "eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = ["eks.amazonaws.com", "ec2.amazonaws.com"]
      }
    }]
  })
}

# Attach IAM policy to the role if needed
# For example, to attach AmazonEKSClusterPolicy:
resource "aws_iam_role_policy_attachment" "eks_cluster_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_role.name
}

# Use subnet IDs directly from data block
resource "aws_eks_cluster" "my_cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = concat(data.aws_subnet.subnet_a[*].id, data.aws_subnet.subnet_b[*].id)
  }
}

resource "aws_eks_node_group" "my_node_group" {
  cluster_name    = aws_eks_cluster.my_cluster.name
  node_group_name = "${var.cluster_name}-nodegroup"
  node_role_arn   = aws_iam_role.eks_cluster_role.arn
  subnet_ids = concat(data.aws_subnet.subnet_a[*].id, data.aws_subnet.subnet_b[*].id)

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  instance_types = ["t3.medium"]
}
