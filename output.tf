output "ec2_details" {
value = { 
ec2_id= aws_instance.demo_ec2[*].id
qa_ec2_id=aws_instance.for_each_demo["qa"].id
dev_ec2_id=aws_instance.for_each_demo["dev"].id
ec2_publicIP = aws_instance.demo_ec2[*].public_ip
ec2_privateIP=aws_instance.demo_ec2[*].private_ip
vpc_id = data.aws_vpc.default.id
}
}

