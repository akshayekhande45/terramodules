resource "aws_instance" "app" {
  subnet_id = var.app-subnet.id
  ami                    = var.my_ami
  instance_type          = var.ins_type
  vpc_security_group_ids = [aws_security_group.my-appsg.id]
  tags = {
    Name = "appserver"
 }
  key_name = "mytf-key1"
  
}
resource "aws_security_group" "my-appsg" {
  name   = "my-appsg"
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
    cidr_blocks = ["10.0.0.0/20"]
    from_port   = 9000
    protocol    = "tcp"
    to_port     = 9000
  }
}