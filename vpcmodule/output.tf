output "vpc_id" {
    value = aws_vpc.customvpc.id
}
output "web-subnet" {
    value = aws_subnet.web-subnet
}
output "app-subnet" {
    value = aws_subnet.app-subnet
}
output "db-subnet" {
    value = aws_subnet.db-subnet
}
