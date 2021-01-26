resource "aws_db_instance" "RDS" {
  allocated_storage      = 50
  storage_type           = "gp2"
  engine                 = "postgres"
  engine_version         = "10.5"
  instance_class         = "db.t3.medium"
  identifier             = "db"
  name                   = "db"
  username               = "admin"
  password               = "password"
  vpc_security_group_ids = [aws_security_group.DB-SG.id]
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.id
  publicly_accessible    = true
  deletion_protection    = true 
}
