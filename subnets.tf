# public
resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.tc_vpc.id
  cidr_block              = "10.0.0.0/19"
  availability_zone       = "${var.defaultRegion}a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.tc_vpc.id
  cidr_block              = "10.0.32.0/19"
  availability_zone       = "${var.defaultRegion}b"
  map_public_ip_on_launch = true
}

# private
resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.tc_vpc.id
  cidr_block        = "10.0.64.0/19"
  availability_zone = "${var.defaultRegion}a"
  tags = {
    Name = "private_subnet"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.tc_vpc.id
  cidr_block        = "10.0.96.0/19"
  availability_zone = "${var.defaultRegion}b"
  tags = {
    Name = "private_subnet"
  }
}