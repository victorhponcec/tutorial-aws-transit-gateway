#Retrieve AWS AZ Information
data "aws_region" "current" {}

output "current_region" {
  value = data.aws_region.current.name
}

output "instance_public_ip_vpca" {
  value = aws_instance.amazon_linux_vpca.public_ip
}
output "instance_private_ip_vpca" {
  value = aws_instance.amazon_linux_vpca.private_ip
}

output "instance_private_ip_vpcb" {
  value = aws_instance.amazon_linux_vpcb.private_ip
}

output "instance_private_ip_vpcc" {
  value = aws_instance.amazon_linux_vpcc.private_ip
}