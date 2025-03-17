resource "aws_eks_node_group" "tc_eks_node_group" {
  cluster_name    = aws_eks_cluster.tc_eks_cluster.name
  node_group_name = "ng-${var.appName}"
  node_role_arn   = data.aws_iam_role.labrole.arn

  subnet_ids = [
    aws_subnet.private_subnet_1.id,
    aws_subnet.private_subnet_2.id
  ]

  capacity_type  = "ON_DEMAND"
  instance_types = [var.eksInstanceType]

  scaling_config {
    desired_size = 1
    max_size     = 3
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  # Allow external changes without Terraform plan diff
  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }
}