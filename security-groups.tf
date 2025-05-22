#Security Group - EC2
#Security group to allow SSH - VPCA
resource "aws_security_group" "ssh_vpca" {
  name        = "ssh_vpca"
  description = "allow SSH (for EC2 instance)"
  vpc_id      = aws_vpc.vpca.id
}

#Ingress rule for SSH
resource "aws_vpc_security_group_ingress_rule" "allow_ssh_vpca" {
  security_group_id = aws_security_group.ssh_vpca.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
}
resource "aws_vpc_security_group_ingress_rule" "allow_icmp_vpca" {
  security_group_id = aws_security_group.ssh_vpca.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = -1
  to_port           = -1
  ip_protocol       = "icmp"
}
#Egress rule for SSH
resource "aws_vpc_security_group_egress_rule" "egress_ssh_all_vpca" {
  security_group_id = aws_security_group.ssh_vpca.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
#Security group to allow SSH - VPCB
resource "aws_security_group" "ssh_vpcb" {
  name        = "ssh_vpcb"
  description = "allow SSH (for EC2 instance)"
  vpc_id      = aws_vpc.vpcb.id
}

#Ingress rule for SSH
resource "aws_vpc_security_group_ingress_rule" "allow_ssh_vpcb" {
  security_group_id = aws_security_group.ssh_vpcb.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
}
resource "aws_vpc_security_group_ingress_rule" "allow_icmp_vpcb" {
  security_group_id = aws_security_group.ssh_vpcb.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = -1
  to_port           = -1
  ip_protocol       = "icmp"
}
#Egress rule for SSH
resource "aws_vpc_security_group_egress_rule" "egress_ssh_all_vpcb" {
  security_group_id = aws_security_group.ssh_vpcb.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
#Security group to allow SSH - VPCC
resource "aws_security_group" "ssh_vpcc" {
  name        = "ssh_vpcc"
  description = "allow SSH (for EC2 instance)"
  vpc_id      = aws_vpc.vpcc.id
}

#Ingress rule for SSH
resource "aws_vpc_security_group_ingress_rule" "allow_ssh_vpcc" {
  security_group_id = aws_security_group.ssh_vpcc.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
}
resource "aws_vpc_security_group_ingress_rule" "allow_icmp_vpcc" {
  security_group_id = aws_security_group.ssh_vpcc.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = -1
  to_port           = -1
  ip_protocol       = "icmp"
}
#Egress rule for SSH
resource "aws_vpc_security_group_egress_rule" "egress_ssh_all_vpcc" {
  security_group_id = aws_security_group.ssh_vpcc.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

