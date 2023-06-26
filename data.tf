data "aws_key_pair" "tfkey" {
  key_name = "silverkey"
}

//esto permite asociar una llave pública creada a la instancia EC2"

data "http" "ip" {
  url = "http://ipv4.icanhazip.com"
}
