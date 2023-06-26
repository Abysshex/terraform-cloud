resource "aws_vpc" "vpc_virginia" {
  cidr_block = var.virgina_cidr
  tags = {
    Name = "VPC_Virgina-${local.sufix}"
  }

}


// VPC para Workspaces DEV o PRD con LOOKUP//

# resource "aws_vpc" "vpc_virginia" {
#   cidr_block = lookup(var.virgina_cidr,terraform.workspace)
#   tags = {
#     Name = "VPC_Virgina"
#   }
# }

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc_virginia.id
  cidr_block              = var.subnets[0]
  map_public_ip_on_launch = true
  tags = {
    Name = "Public Subnet-${local.sufix}"
  }


}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.vpc_virginia.id
  cidr_block = var.subnets[1]
  tags = {
    Name = "Private Subnet-${local.sufix}"
  }
  depends_on = [aws_subnet.public_subnet]


}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_virginia.id

  tags = {
    Name = "igw vpc virginia-${local.sufix}"
  }
}

resource "aws_route_table" "public_crt" {
  vpc_id = aws_vpc.vpc_virginia.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }


  tags = {
    Name = "public custom route table-${local.sufix}"
  }
}

resource "aws_route_table_association" "customroute_public_subnet" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_crt.id
}

resource "aws_security_group" "sg-public-instance" {
  name        = "public instance SG"
  description = "Allow SSH  inbound traffic and all egress traffic"
  vpc_id      = aws_vpc.vpc_virginia.id


  //security groups con dynamic blocks//

  dynamic "ingress" {
    for_each = var.ingress_ports_list
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = [var.sg_ingress_cidr]
    }

  }




  // ingress sin dynamic blocks//


  # ingress {
  #   description = "SSH over Internet"
  #   from_port   = 22
  #   to_port     = 22
  #   protocol    = "tcp"
  #   cidr_blocks = [var.sg_ingress_cidr]
  # }


  # ingress {
  #   description = "http over Internet"
  #   from_port   = 80
  #   to_port     = 80
  #   protocol    = "tcp"
  #   cidr_blocks = [var.sg_ingress_cidr]
  # }


  # ingress {
  #   description = "https over Internet"
  #   from_port   = 443
  #   to_port     = 443
  #   protocol    = "tcp"
  #   cidr_blocks = [var.sg_ingress_cidr]
  # }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls-${local.sufix}"
  }
}

module "mybucket" {
  source      = "./Modulos/s3"
  bucket_name = "hastaquelamuertelossepare"
}


output "s3_arn" {
  value = module.mybucket.s3_bucket_arn
}