/*Public Subnet EU1-Pub1*/
resource "aws_subnet" "EU1-Pub1" {
  vpc_id     = aws_vpc.app.id
  cidr_block = var.EU1-Pub1

  tags = {
    Name = "EU1-Pub1"
  }
}

resource "aws_route_table_association" "EU1-RTA-Pub1" {
  subnet_id      = aws_subnet.EU1-Pub1.id
  route_table_id = aws_route_table.public-route.id
}

/*Public Subnet EU1-Pub2*/
resource "aws_subnet" "EU1-Pub2" {
  vpc_id     = aws_vpc.app.id
  cidr_block = var.EU1-Pub2

  tags = {
    Name = "EU1-Pub2"
  }
}

resource "aws_route_table_association" "EU1-RTA-Pub2" {
  subnet_id      = aws_subnet.EU1-Pub2.id
  route_table_id = aws_route_table.public-route.id
}

/*Public Subnet EU1-Pri1*/
resource "aws_subnet" "EU1-Pri1" {
  vpc_id     = aws_vpc.app.id
  cidr_block = var.EU1-Pri1

  tags = {
    Name = "EU1-Pri1"
  }
}

resource "aws_route_table_association" "EU1-RTA-Pri1" {
  subnet_id      = aws_subnet.EU1-Pri1.id
  route_table_id = aws_route_table.private-route.id
}

/*Public Subnet EU1-Pri2*/
resource "aws_subnet" "EU1-Pri2" {
  vpc_id     = aws_vpc.app.id
  cidr_block = var.EU1-Pri2

  tags = {
    Name = "EU1-Pri2"
  }
}

resource "aws_route_table_association" "EU1-RTA-Pri2" {
  subnet_id      = aws_subnet.EU1-Pri2.id
  route_table_id = aws_route_table.private-route.id
}

/*DB Subnet Group*/
resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "subnet-group"
  subnet_ids = [aws_subnet.EU1-Pub1.id, aws_subnet.EU1-Pub2.id]

  tags = {
    Name = "Subnet-Group"
  }
}
