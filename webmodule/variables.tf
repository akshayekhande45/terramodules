variable "ins_type" {
   type = string
   default ="t2.micro"
}
variable "my_ami" {
   type = string
   default ="ami-0672fd5b9210aa093"
}
variable "web-subnet" { }
variable "vpc_id" { }