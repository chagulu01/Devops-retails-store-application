# VPC

resource "aws_vpc" "dev-vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags                 = merge(var.tags, { Name = "${var.environment_name}-vpc" })
  lifecycle {
    prevent_destroy = false
  }
}

#Internet Gateway

resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.dev-vpc.id
  tags   = merge(var.tags, { Name = "${var.environment_name}-igw" })

  lifecycle {
    prevent_destroy = false
  }
}

#Public Subnets

resource "aws_subnet" "public" {
  for_each                = { for idx, az in local.azs : az => local.public_subnets[idx] }
  vpc_id                  = aws_vpc.dev-vpc.id
  cidr_block              = each.value
  availability_zone       = each.key
  map_public_ip_on_launch = true
  tags                    = merge(var.tags, { Name = "${var.environment_name}-public-${each.key}" })
}

#Private Subnets

resource "aws_subnet" "private" {
  for_each          = { for idx, az in local.azs : az => local.private_subnets[idx] }
  vpc_id            = aws_vpc.dev-vpc.id
  cidr_block        = each.value
  availability_zone = each.key
  tags              = merge(var.tags, { Name = "${var.environment_name}-private-${each.key}" })
}

# EIP for NAT Gateway

resource "aws_eip" "nat_eip" {
  tags = merge(var.tags, { Name = "${var.environment_name}-nat-eip" })

}

# NAT Gateway

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = values(aws_subnet.public)[0].id
  tags          = merge(var.tags, { Name = "${var.environment_name}-nat-gw" })

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.IGW]
}


# Route Table for Public Subnets

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.dev-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }

  tags = merge(var.tags, { Name = "${var.environment_name}-public-rt" })
}

# public route table association

resource "aws_route_table_association" "public_rt_assoc" {
  for_each       = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public_rt.id

}

# Route Table for Private Subnets

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.dev-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = merge(var.tags, { Name = "${var.environment_name}-private-rt" })
}

# private route table association

resource "aws_route_table_association" "private_rt_assoc" {
  for_each       = aws_subnet.private
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private_rt.id

}
