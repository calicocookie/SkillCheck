data "aws_internet_gateway" "vpc_igw" {
  filter {
    name   = "attachment.vpc-id"
    values = [var.vpc_id]
  }
}

resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  tags = {
    Name = "public"
  }
}

resource "aws_route_table" "private_c" {
  vpc_id = var.vpc_id

  tags = {
    Name = "private c"
  }
}

resource "aws_route_table" "private_d" {
  vpc_id = var.vpc_id

  tags = {
    Name = "private d"
  }
}

resource "aws_route" "igw" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = data.aws_internet_gateway.vpc_igw.id
}

resource "aws_route" "nat_c" {
  route_table_id         = aws_route_table.private_c.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.c.id
}

resource "aws_route" "nat_d" {
  route_table_id         = aws_route_table.private_d.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.d.id
}

resource "aws_subnet" "public_c" {
  vpc_id            = var.vpc_id
  cidr_block        = var.subnet["public_c"]
  availability_zone = var.availability_1

  tags = {
    "Name" = "app public c"
  }
}

resource "aws_subnet" "public_d" {
  vpc_id            = var.vpc_id
  cidr_block        = var.subnet["public_d"]
  availability_zone = var.availability_2

  tags = {
    "Name" = "app public d"
  }
}

resource "aws_subnet" "private_c" {
  vpc_id            = var.vpc_id
  cidr_block        = var.subnet["private_c"]
  availability_zone = var.availability_1

  tags = {
    "Name" = "app private c"
  }
}

resource "aws_subnet" "private_d" {
  vpc_id            = var.vpc_id
  cidr_block        = var.subnet["private_d"]
  availability_zone = var.availability_2

  tags = {
    "Name" = "app private d"
  }
}

resource "aws_route_table_association" "public_c" {
  subnet_id      = aws_subnet.public_c.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_d" {
  subnet_id      = aws_subnet.public_d.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private_c" {
  subnet_id      = aws_subnet.private_c.id
  route_table_id = aws_route_table.private_c.id
}

resource "aws_route_table_association" "private_d" {
  subnet_id      = aws_subnet.private_d.id
  route_table_id = aws_route_table.private_d.id
}

resource "aws_eip" "nat_c" {
  vpc = true
}

resource "aws_eip" "nat_d" {
  vpc = true
}

resource "aws_nat_gateway" "c" {
  allocation_id = aws_eip.nat_c.id
  subnet_id     = aws_subnet.public_c.id

  tags = {
    "Name" = "natgw c"
  }
}

resource "aws_nat_gateway" "d" {
  allocation_id = aws_eip.nat_d.id
  subnet_id     = aws_subnet.public_d.id

  tags = {
    "Name" = "natgw d"
  }
}
