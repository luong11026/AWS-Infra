resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr

  tags = merge({ Name = "demo-vpc" }, var.common_tags)
}

resource "aws_subnet" "public_subnets" {
  for_each = var.public_subnets

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, each.value)
  availability_zone = tolist(data.aws_availability_zones.current.names)[each.value - 1]

  tags = merge({ Name = each.key }, var.common_tags)
}

resource "aws_subnet" "private_subnets" {
  for_each = var.private_subnets

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, each.value + 100)
  availability_zone = tolist(data.aws_availability_zones.current.names)[each.value - 1]

  tags = merge({ Name = each.key }, var.common_tags)

}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = merge({ Name = "public_route_table" }, var.common_tags)
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = merge({ Name = "private_route_table" }, var.common_tags)
}

resource "aws_route_table_association" "public" {
  depends_on     = [aws_subnet.public_subnets]
  route_table_id = aws_route_table.public_route_table.id
  for_each       = aws_subnet.public_subnets
  subnet_id      = each.value.id
}

resource "aws_route_table_association" "private" {
  depends_on     = [aws_subnet.private_subnets]
  route_table_id = aws_route_table.private_route_table.id
  for_each       = aws_subnet.private_subnets
  subnet_id      = each.value.id
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = merge({ Name = "internet_gateway" }, var.common_tags)
}

resource "aws_eip" "nat_gateway_eip" {
  depends_on = [aws_internet_gateway.internet_gateway]
  tags       = merge({ Name = "NAT_gateway_eip" }, var.common_tags)
}

resource "aws_nat_gateway" "nat_gateway" {
  #   vpc        = true
  depends_on    = [aws_subnet.public_subnets]
  subnet_id     = aws_subnet.public_subnets["public_subnet_1"].id
  allocation_id = aws_eip.nat_gateway_eip.id
  tags          = merge({ Name = "NAT_gateway" }, var.common_tags)
}



