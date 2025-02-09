resource "aws_instance" "web" {
  ami                    = var.my_ami
  instance_type          = var.ins_type
  vpc_security_group_ids = [aws_security_group.my-websg.id]
  subnet_id = var.web-subnet.id
  associate_public_ip_address = true
  tags = {
    Name = "webserver"
  }
  key_name = "mytf-key1"
   
}
resource "aws_security_group" "my-websg" {
  name   = "my-websg"
  vpc_id = var.vpc_id
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
  }
}