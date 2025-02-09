resource "aws_db_instance" "my-rds" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = "admin"
  password             = "Pass1234"
  vpc_security_group_ids = [aws_security_group.my-dbsg.id]
  db_subnet_group_name = aws_db_subnet_group.my-subnet-grp.name
  skip_final_snapshot  = true
}
resource "aws_db_subnet_group" "my-subnet-grp" {
  name       = "my-sub-grp"
  subnet_ids = [var.db-subnet.id,var.app-subnet.id]
  
  tags = {
    Name = "My DB subnet group"
  }
}
resource "aws_security_group" "my-dbsg" {
  name   = "my-dbsg"
  vpc_id = var.vpc_id
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    cidr_blocks = ["10.0.0.0/16"]
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
  }
  ingress {
    cidr_blocks = ["10.0.16.0/20"]
    from_port   = 3306
    protocol    = "tcp"
    to_port     = 3306
  }
}