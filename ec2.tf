

resource "aws_instance" "Public_Instance" {
  ami                    = var.ec2_specs.ami
  instance_type          = var.ec2_specs.instance_type
  subnet_id              = aws_subnet.public_subnet.id
  key_name               = data.aws_key_pair.tfkey.key_name
  vpc_security_group_ids = [aws_security_group.sg-public-instance.id]
  user_data              = file("userdata.sh")

  tags = {
    Name = "Papudelrock-${local.sufix}"
  }

}

