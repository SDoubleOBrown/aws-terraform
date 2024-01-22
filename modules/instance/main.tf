# resource "aws_instance" "main" {
#   ami           = var.ami  
#   instance_type = var.instance_type
#   key_name      = var.key_name
#   vpc_security_group_ids = [aws_security_group.ec2_security_group.id]
#   subnet_id = element(aws_subnet.subnet[*].id, count.index)

#   user_data     = <<-EOF
#                   #!/bin/bash
#                   sudo apt-get update -y
#                   sudo apt-get install -y ansible docker.io
#                   sudo usermod -aG docker ubuntu
#                   EOF

#   tags = {
#     Name = "${var.environment}-instance"
#   }
# }

resource "aws_instance" "instance" {
    ami = var.ami
    instance_type = var.type
    key_name = var.key_pair
    security_groups = [aws_security_group.security_group.id]
    subnet_id = aws_subnet.public_subnet_az1.id
    availability_zone = data.aws_availability_zones.available_zones.names[0]

        user_data = <<-EOF
                  #!/bin/bash
                  sudo apt-get update -y
                  sudo apt-get install docker.io -y
                  sudo systemctl start docker
                  sudo systemctl enable docker
                  EOF

    tags = {
        Name = "${var.environment}-instance"
        source = "terraform"
    }             
}