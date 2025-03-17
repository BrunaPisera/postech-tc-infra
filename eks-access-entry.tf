resource "aws_eks_access_entry" "access-entry" {
  cluster_name      = aws_eks_cluster.tc_eks_cluster.name
  principal_arn     = var.principalArn
  kubernetes_groups = ["tc"]
  type              = "STANDARD"
}