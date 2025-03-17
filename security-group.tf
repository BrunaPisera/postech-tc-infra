# EKS
resource "aws_security_group" "eks_sg" {
  name        = "sg_eks_${var.appName}"
  description = "TC EKS security group"
  vpc_id      = aws_vpc.tc_vpc.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}