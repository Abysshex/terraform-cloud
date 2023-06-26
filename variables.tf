variable "virgina_cidr" {
  description = "CIDR Virgnia"
  type        = string
  sensitive   = false
}


# variable "public_subnet" {
#   description = "CIDR Public Subnet"
#   type = string

# }

# variable "private_subnet" {
# description = "CIDRter Private Subnet"
# type = string 
# }

variable "subnets" {
  description = "Lista de subnets"
  type        = list(string)

}

variable "tags" {
  description = "tags del proyecto"
  type        = map(string)
}

variable "sg_ingress_cidr" {
  description = "CIDR for ingress access"
  type        = string
}

variable "ec2_specs" {
  description = "Parametros de la instancia"
  type        = map(string)

}

variable "ingress_ports_list" {
  description = "Lista de puertos de ingress"
  type        = list(number)

}


variable "acces_key"{
  description = "Access Key AWS"
}

variable "secret_key"{
  description = "Secret Access Key AWS"

}