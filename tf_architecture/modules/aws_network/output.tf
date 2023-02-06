output "vpc_id" {
  value = aws_default_vpc.mainVPC.id
}

output "public_subnet_id" {
  value = aws_subnet.publicSubnet.id
}
