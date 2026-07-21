resource "aws_instance" "demo_ec2" {
  provider                    = aws.mub1
  ami                         = var.mub-region-ami-id
  instance_type               = var.instance_type
  key_name                    = var.mumb-region-key
  subnet_id                   = "subnet-0f2339166060bc7da"
  count                       = var.intance_count
  associate_public_ip_address = true

  tags = {
    Name = "ec2-${count.index}"
  }
}

data "aws_vpc" "default" {
  default = true
}


resource "aws_instance" "for_each_demo" {
  ami           = var.ami_id
  for_each      = var.for_eachdemo
  instance_type = each.value
  key_name      = var.key_name
  subnet_id     = "subnet-0873ab06bdc0f7edc"
  tags = {
    Name = "ec2-${each.key}"
  }
}

##explict dependancy example #####


resource "aws_vpc" "demo_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "demo_subnet" {
  vpc_id            = aws_vpc.demo_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
}

resource "aws_security_group" "demo_sg" {
  name        = "demo-sg"
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "demo_ec2_1" {
  ami           = var.ami_id
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.demo_subnet.id
  key_name      = var.key_name

  # Explicit dependency
  depends_on = [
    aws_vpc.demo_vpc,
    aws_security_group.demo_sg
  ]

  tags = {
    Name = "demo-ec2_1"
  }
}


##================provisioner=================
##------local-provisioner----------------

resource "aws_instance" "demo_provioner" {
  provider      = aws.mub1
  ami           = var.mub-region-ami-id
  instance_type = var.instance_type
  key_name      = var.mumb-region-key

  provisioner "local-exec" {
    command = "echo Instance ID: ${self.id} >> instance_ids.txt"
  }

  tags = {
    Name = "demo-provisioner-ec2"
  }
}

##======================remote execution================

resource "aws_instance" "demo_ec2-remote-execution" {
  provider                    = aws.mub1
  ami                         = var.mub-region-ami-id
  instance_type               = var.instance_type
  key_name                    = var.mumb-region-key
  associate_public_ip_address = true


  # Remote provisioner runs inside the EC2 instance
  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo amazon-linux-extras install docker -y"
    ]
  }

  # Connection details for SSH
  connection {
    type        = "ssh"
    port        = 22
    user        = "ec2-user"
    private_key = file("C:\\Users\\Gopal Sabale\\Downloads\\mub-region-key-pair.pem")
    host        = self.public_ip
  }

  tags = {
    Name = "demo-ec2-remote_execution"
  }
}
