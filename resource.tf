resource "aws_instance" "demo_ec2" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = "subnet-0873ab06bdc0f7edc"
  count = var.intance_count
   associate_public_ip_address = true
   
  tags = {
    Name = "ec2-${count.index}"
  }
}

data "aws_vpc" "default" {
  default = true
}


resource "aws_instance" "for_each_demo" {
  ami = var.ami_id
  for_each = var.for_eachdemo
  instance_type = each.value
  key_name = var.key_name
   subnet_id     = "subnet-0873ab06bdc0f7edc"
   tags = {
     Name="ec2-${each.key}"
   }
}