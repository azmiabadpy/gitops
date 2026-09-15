resource "aws_eks_cluster" "this" {
  name     = "${var.project_name}-eks"
  role_arn = var.eks_cluster_role_arn
  version  = var.kubernetes_version

   access_config {
    authentication_mode = "API_AND_CONFIG_MAP"
  }

  vpc_config {
    subnet_ids = var.private_subnet_ids

    endpoint_private_access = true
    endpoint_public_access  = true
  }

  tags = {
    Name = "${var.project_name}-eks"
  }
}


resource "aws_eks_node_group" "this" {
  cluster_name = aws_eks_cluster.this.name

  node_group_name = "${var.project_name}-nodes"

  node_role_arn = var.eks_node_role_arn

  subnet_ids = var.private_subnet_ids

  instance_types = [
    var.node_instance_type
  ]

  capacity_type = "ON_DEMAND"

  scaling_config {
    desired_size = 1
    min_size     = 1
    max_size     = 1
  }

  tags = {
    Name = "${var.project_name}-eks-nodes"
  }

  depends_on = [
    aws_eks_cluster.this
  ]
}