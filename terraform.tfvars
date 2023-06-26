virgina_cidr = "10.10.0.0/16"
# public_subnet = "10.10.0.0/24"
# private_subnet = "10.10.1.0/24"

subnets = ["10.10.0.0/24", "10.10.1.0/24"]

tags = {

  env         = "dev"
  owner       = "luly"
  Cloud       = "AWS"
  IAC         = "Terraform"
  IAC_Version = "1.4.6"
  project     = "Mitocondrion"
  region      = "Virginia"

}

sg_ingress_cidr = "0.0.0.0/0"

ec2_specs = {
  "ami"           = "ami-022e1a32d3f742bd8"
  "instance_type" = "t2.micro"
}

ingress_ports_list = [22, 80, 443]
