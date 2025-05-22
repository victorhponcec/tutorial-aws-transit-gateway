#EC2 Instances - VPCA
resource "aws_instance" "amazon_linux_vpca" {
  ami                         = "ami-05576a079321f21f8"
  instance_type               = "t2.micro"
  security_groups             = [aws_security_group.ssh_vpca.id]
  subnet_id                   = aws_subnet.public_subnet_vpca.id
  associate_public_ip_address = true
  key_name                    = aws_key_pair.ec2_key.key_name
}
#EC2 Instances - VPCB
resource "aws_instance" "amazon_linux_vpcb" {
  ami                         = "ami-05576a079321f21f8"
  instance_type               = "t2.micro"
  security_groups             = [aws_security_group.ssh_vpcb.id]
  subnet_id                   = aws_subnet.private_subnet_vpcb.id
}
#EC2 Instances - VPCC
resource "aws_instance" "amazon_linux_vpcc" {
  ami                         = "ami-05576a079321f21f8"
  instance_type               = "t2.micro"
  security_groups             = [aws_security_group.ssh_vpcc.id]
  subnet_id                   = aws_subnet.private_subnet_vpcc.id
}