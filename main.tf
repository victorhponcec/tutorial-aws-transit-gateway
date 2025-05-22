#Configuring AWS Provider
provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = { Environment = "victor-terraform" }
  }
}

#VPCA
resource "aws_vpc" "vpca" {
  cidr_block = "10.111.0.0/16"
  tags = { Name = "VPCA"}
}
#VPCB
resource "aws_vpc" "vpcb" {
  cidr_block = "10.112.0.0/16"
  tags = { Name = "VPCB"}
}
#VPCC 
resource "aws_vpc" "vpcc" {
  cidr_block = "10.113.0.0/16"
  tags = { Name = "VPCC"}
}

#Subnet Public
resource "aws_subnet" "public_subnet_vpca" {
  vpc_id            = aws_vpc.vpca.id
  cidr_block        = "10.111.1.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "vpcA-public-1"}
}
resource "aws_subnet" "private_subnet_vpcb" {
  vpc_id            = aws_vpc.vpcb.id
  cidr_block        = "10.112.1.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "vpcB-private-1"}
}
resource "aws_subnet" "private_subnet_vpcc" {
  vpc_id            = aws_vpc.vpcc.id
  cidr_block        = "10.113.1.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "vpcC-private-1"}
}

#Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpca.id
}

#Route Tables
#Public Route table - VPCA
resource "aws_route_table" "public_rtb_vpca" {
  vpc_id = aws_vpc.vpca.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  route {
    cidr_block = "10.112.0.0/16" //route to VPCB through TGW
    gateway_id = aws_ec2_transit_gateway.tgw.id
  }
  route {
    cidr_block = "10.113.0.0/16" //route to VPCC through TGW
    gateway_id = aws_ec2_transit_gateway.tgw.id
  }
  depends_on = [aws_ec2_transit_gateway.tgw]
}
#Public Route table - VPCB
resource "aws_route_table" "public_rtb_vpcb" {
  vpc_id = aws_vpc.vpcb.id
  route {
    cidr_block = "10.111.0.0/16" //route to VPCA through TGW
    gateway_id = aws_ec2_transit_gateway.tgw.id
  }
  route {
    cidr_block = "10.113.0.0/16" //route to VPCC through TGW
    gateway_id = aws_ec2_transit_gateway.tgw.id
  }
  depends_on = [aws_ec2_transit_gateway.tgw]
}
#Public Route table - VPCC
resource "aws_route_table" "public_rtb_vpcc" {
  vpc_id = aws_vpc.vpcc.id
  route {
    cidr_block = "10.111.0.0/16" //route to VPCA through TGW
    gateway_id = aws_ec2_transit_gateway.tgw.id
  }
  route {
    cidr_block = "10.112.0.0/16" //route to VPCB through TGW
    gateway_id = aws_ec2_transit_gateway.tgw.id
  }
  depends_on = [aws_ec2_transit_gateway.tgw]
}

#Create route table associations
#Associate public Subnet to public route table - VPCA
resource "aws_route_table_association" "public_vpca" {
  subnet_id      = aws_subnet.public_subnet_vpca.id
  route_table_id = aws_route_table.public_rtb_vpca.id
}
#Associate private Subnet to public route table - VPCB
resource "aws_route_table_association" "public_vpcb" {
  subnet_id      = aws_subnet.private_subnet_vpcb.id
  route_table_id = aws_route_table.public_rtb_vpcb.id
}
#Associate private Subnet to public route table - VPCB
resource "aws_route_table_association" "public_vpcc" {
  subnet_id      = aws_subnet.private_subnet_vpcc.id
  route_table_id = aws_route_table.public_rtb_vpcc.id
}

#SSH Config
#Create PEM File
resource "tls_private_key" "pkey" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private_key_pem" {
  content         = tls_private_key.pkey.private_key_pem
  filename        = "AWSKeySSH.pem"
  file_permission = "0400" #NOT TESTED
}

#AWS SSH EC2 Key Pair | uses tls_private_key to generate public key
resource "aws_key_pair" "ec2_key" {
  key_name   = "AWSKeySSH"
  public_key = tls_private_key.pkey.public_key_openssh

  lifecycle {
    ignore_changes = [key_name] #to ensure it creates a different pair of keys each time
  }
}