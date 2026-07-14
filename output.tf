output "ec2_details" {
value = { 
ec2_id= aws_instance.demo_ec2[*].id
ec2_publicIP = aws_instance.demo_ec2[*].public_ip
ec2_privateIP=aws_instance.demo_ec2[*].private_ip
vpc_id = data.aws_vpc.default.id
}
}

