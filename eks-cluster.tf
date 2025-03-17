resource "aws_eks_cluster" "tc_eks_cluster" {
  name     = "eks_${var.appName}"
  role_arn = data.aws_iam_role.labrole.arn

  vpc_config {
    subnet_ids = [
      aws_subnet.private_subnet_1.id,
      aws_subnet.private_subnet_2.id,
    ]
    security_group_ids = [aws_security_group.eks_sg.id]
  }

  access_config {
    authentication_mode = var.authMode
  }
}
