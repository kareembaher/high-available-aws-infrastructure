/*Internet Gateway*/
resource "aws_internet_gateway" "EU1-gw" {
  vpc_id = aws_vpc.app.id

  tags = {
    Name = "Internet Gateway"
  }
}

/*Nat Gateway*/
resource "aws_eip" "nat-eip" {
  vpc = true
}

resource "aws_nat_gateway" "EU1-nat-gw" {
  allocation_id = aws_eip.nat-eip.id
  subnet_id     = aws_subnet.EU1-Pub1.id
  depends_on    = [aws_internet_gateway.EU1-gw]
}

/*Public Route*/
resource "aws_route_table" "public-route" {
  vpc_id = aws_vpc.app.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.EU1-gw.id
  }

  tags = {
    Name = "Public route"
  }
}

/*Private Route*/
resource "aws_route_table" "private-route" {
  vpc_id = aws_vpc.app.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.EU1-nat-gw.id
  }

  tags = {
    Name = "Private route"
  }
}