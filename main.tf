provider "aws" {
  region = "ap-south-1"

}

#Creating VPC
resource "aws_vpc" "my-vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name="My-VPC"
    }
}
#Crating IGW
resource "aws_internet_gateway" "my-igw" {
    vpc_id = aws_vpc.my-vpc.id
    tags = {
      Name="My-IGW"
    }
  
}

#Creating route table
resource "aws_route_table" "route-table" {
    vpc_id = aws_vpc.my-vpc.id
    tags = {
      Name="my-route-table"
    }
}

#route the route table
resource "aws_route" "routing-igw" {
    route_table_id = aws_route_table.route-table.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw.id
  
}

#creating subnets
resource "aws_subnet" "subnet-1" {
    vpc_id = aws_vpc.my-vpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "ap-south-1a"
    tags = {
      Name="Subnet-1"
    }
  
#Creating subnet 2  
}
resource "aws_subnet" "subnet-2" {
    vpc_id = aws_vpc.my-vpc.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "ap-south-1b"
    tags = {
      Name="Subnet-2"
    }
  
}

#Subnet associations with route table
resource "aws_route_table_association" "Subnet-association" {
    route_table_id = aws_route_table.route-table.id
    subnet_id = aws_subnet.subnet-1.id
  
}
