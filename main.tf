terraform {
  required_version = "~> 1.1"
  required_providers {
    aws = {
      version = "~>3.1"
    }
  }
}
provider "aws" {
  region     = var.my_region
  access_key = var.access_key
  secret_key = var.secret_key
}
resource "aws_key_pair" "tf-key-pair" {
  key_name   = "mytf-key1"
  public_key = tls_private_key.rsa.public_key_openssh
}
resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "local_file" "tf-key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "mytf-key1"
}

module "vpc" {
  source = "./vpcmodule"
}

module "webmodule" {
  source = "./webmodule"
  vpc_id = module.vpc.vpc_id
  web-subnet = module.vpc.web-subnet
}
module "appmodule" {
  source = "./appmodule"
  vpc_id = module.vpc.vpc_id
  app-subnet = module.vpc.app-subnet
}
module "dbmodule" {
  source = "./dbmodule"
  vpc_id = module.vpc.vpc_id
  app-subnet = module.vpc.app-subnet
  db-subnet = module.vpc.db-subnet
}

