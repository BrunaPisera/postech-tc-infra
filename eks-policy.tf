resource "aws_eks_access_policy_association" "tc_eks_policy" {
  cluster_name  = aws_eks_cluster.tc_eks_cluster.name
  policy_arn    = var.eksAdminPolicy
  principal_arn = var.principalArn

  access_scope {
    type = "cluster"
  }
}