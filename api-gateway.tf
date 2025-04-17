resource "aws_apigatewayv2_api" "tc_api_gateway" {
  name          = "tc_api_gateway"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "dev" {
  api_id = aws_apigatewayv2_api.tc_api_gateway.id

  name        = "$default"
  auto_deploy = true
}

resource "aws_security_group" "sg_vpc_link" {
  name   = "sg_vpc_link"
  vpc_id = aws_vpc.tc_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.cidrBlocks]
  }
}

resource "aws_apigatewayv2_vpc_link" "tc_vpc_link" {
  name               = "tc_vpc_link"
  security_group_ids = [aws_security_group.sg_vpc_link.id]
  subnet_ids = [
    aws_subnet.private_subnet_1.id,
    aws_subnet.private_subnet_2.id
  ]
}

resource "aws_apigatewayv2_integration" "tc_eks_api_integration_upload" {
  api_id = aws_apigatewayv2_api.tc_api_gateway.id

  integration_uri    = var.loadBalancerUriUpload
  integration_type   = "HTTP_PROXY"
  integration_method = "ANY"
  connection_type    = "VPC_LINK"
  connection_id      = aws_apigatewayv2_vpc_link.tc_vpc_link.id

  request_parameters = {
    "overwrite:path" = "/$request.path.proxy"
  }
}

resource "aws_apigatewayv2_integration" "tc_eks_api_integration_status_tracking" {
  api_id = aws_apigatewayv2_api.tc_api_gateway.id

  integration_uri    = var.loadBalancerUriStatusTracking
  integration_type   = "HTTP_PROXY"
  integration_method = "ANY"
  connection_type    = "VPC_LINK"
  connection_id      = aws_apigatewayv2_vpc_link.tc_vpc_link.id

  request_parameters = {
    "overwrite:path" = "/$request.path.proxy"
  }
}

resource "aws_apigatewayv2_route" "all_upload" {
  api_id = aws_apigatewayv2_api.tc_api_gateway.id

  route_key = "ANY /upload/{proxy+}"
  target    = "integrations/${aws_apigatewayv2_integration.tc_eks_api_integration_upload.id}"
}

resource "aws_apigatewayv2_route" "all_status" {
  api_id = aws_apigatewayv2_api.tc_api_gateway.id

  route_key = "ANY /status/{proxy+}"
  target    = "integrations/${aws_apigatewayv2_integration.tc_eks_api_integration_status_tracking.id}"
}