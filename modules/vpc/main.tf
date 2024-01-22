# resource "aws_vpc" "main" {
#   cidr_block = "10.0.0.0/16"
#   tags = {
#     Name = "${var.environment}-vpc"
#   }
# }

# resource "aws_subnet" "subnet" {
#   vpc_id                  = aws_vpc.main.id
#   cidr_block              = "10.0.${count.index + 1}.0/24"
#   availability_zone       = element(data.aws_availability_zones.available.names, count.index)
#   map_public_ip_on_launch = true

#   tags = {
#     Name = "${var.environment}-subnet-${count.index + 1}"
#   }
# }

# data "aws_availability_zones" "available" {
#   state = "available"
# }

# resource "aws_internet_gateway" "main" {
#   vpc_id = aws_vpc.main.id

#   tags = {
#     Name = "${var.environment}-igw"
#   }
# }


# resource "aws_route_table" "public" {
#   vpc_id = aws_vpc.main.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.main.id
#   }

#   tags = {
#     Name = "${var.environment}-public-rt"
#   }
# }

# resource "aws_subnet_route_table_association" "public_association" {
#   count          = var.availability_zones
#   subnet_id      = aws_subnet.subnet[count.index].id
#   route_table_id = aws_route_table.public.id
# }

resource "aws_vpc" "vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "${environment}-vpc"
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.environment}-igw"
  }
}

data "aws_availability_zones" "available_zones" {}

resource "aws_subnet" "public_subnet_az1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.public_subnet_az1_cidr
  availability_zone = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.environment}-subnet-az1"
  }
}

resource "aws_subnet" "public_subnet_az2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.public_subnet_az2_cidr
  availability_zone = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.environment}-subnet-az2"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "${var.environment}-route-table"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public_subnet_az1
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public_subnet_az2
  route_table_id = aws_route_table.public_route_table.id
}