resource "aws_internet_gateway" "tc_internet_gateway" {
  vpc_id = aws_vpc.tc_vpc.id
}