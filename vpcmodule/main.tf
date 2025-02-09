resource "aws_vpc" "customvpc" {
  cidr_block       = "10.0.0.0/16"
  tags = {
    Name = "myvpc"
  }
}
resource "aws_internet_gateway" "myigw" {
  vpc_id = aws_vpc.customvpc.id
  tags = {
    Name = "myigw"
  }
}
resource "aws_subnet" "web-subnet" {
  vpc_id     = aws_vpc.customvpc.id
  cidr_block = "10.0.0.0/20"
  availability_zone = "ap-southeast-1a"
  tags = {
    Name = "websubnet"
  }
}
resource "aws_subnet" "app-subnet" {
  vpc_id     = aws_vpc.customvpc.id
  cidr_block = "10.0.16.0/20"
  availability_zone = "ap-southeast-1b"
  tags = {
    Name = "appsubnet"
  }
}
resource "aws_subnet" "db-subnet" {
  vpc_id     = aws_vpc.customvpc.id
  cidr_block = "10.0.32.0/24"
  availability_zone = "ap-southeast-1c"
  tags = {
    Name = "dbsubnet "
  }
}
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.customvpc.id
 
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myigw.id
  }
  tags = {
    Name = "public-RT"
  }
}
resource "aws_route_table" "pvt-rt" {
  vpc_id = aws_vpc.customvpc.id
 
  tags = {
    Name = "pvt-RT"
  }
}
resource "aws_route_table_association" "web-association" {
  subnet_id      = aws_subnet.web-subnet.id
  route_table_id = aws_route_table.public-rt.id
}
resource "aws_route_table_association" "app-association" {
  subnet_id      = aws_subnet.app-subnet.id
  route_table_id = aws_route_table.pvt-rt.id
}
resource "aws_route_table_association" "db-association" {
  subnet_id      = aws_subnet.db-subnet.id
  route_table_id = aws_route_table.pvt-rt.id
}