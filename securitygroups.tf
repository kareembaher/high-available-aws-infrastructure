/***************************/
/*Utilities Secuirity Group*/
/***************************/
resource "aws_security_group" "Utilities-SG" {
  name        = "Utilities_SG"
  description = "Security Group for Utilities"
  vpc_id      = aws_vpc.app.id

  /*SSH*/
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "Utilities-SG"
  }
}

/*********************/
/*ALB Secuirity Group*/
/*********************/
resource "aws_security_group" "appALB" {
  name = "appALB"
  description = "Security group for the ALB"
  vpc_id      = aws_vpc.app.id

  /*Ingress Rules*/
  ingress {
    description = "app-ssl"
    from_port   = "443"
    to_port     = "443"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  /*egress Rules*/
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

    tags = {
    Name = "appALB"
  }
}

/**********************/
/*App Secuirity Group*/
/**********************/
resource "aws_security_group" "app-SG" {
  name        = "app_SG"
  description = "Security Group for app"
  vpc_id      = aws_vpc.app.id

  /*Load Balancer to EC2*/
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    self        = true
    description = "Self"
  }

  /*SSH*/
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  /*HTTPS*/
  ingress {
    description = "vpay-ssl from ALB"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_security_group.appALB.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

/************************/
/*DB Secuirity Group*/
/************************/
resource "aws_security_group" "db-SG" {
  name        = "db_SG"
  description = "Security Group for db"
  vpc_id      = aws_vpc.app.id

  /*db*/
  ingress {
    description = "db"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "db-SG"
  }
}

/************************/
/*EFS Secuirity Group*/
/************************/
resource "aws_security_group" "appEFS" {
  name = "appEFS"
  tags = {
    Name = "appEFS"
  }
  description = "appEFS"
  vpc_id      = aws_vpc.app.id

  /*Ingress Rules*/
  ingress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["10.1.0.0/21"]
  }

  /*egress Rules*/
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}