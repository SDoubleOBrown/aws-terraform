output "project_name" {
    value = var.environment
}

output "region" {
    value = var.region
}
 
output "vpc_id" {
    value = aws_vpc.vpc.id
}

output "internet_gateway" {
    value = aws_internet_gateway.internet_gateway
}

output "public_ip" {
    value = aws_instance.instance.public_ip
}

output "message" {
    value = "Resources have been successfully created."
}