
variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-051bfa33df3949860"
}

variable "mub-region-ami-id" {
  description = "ami-id for mumbai region"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Name of the existing EC2 key pair"
  type        = string
}

variable "mumb-region-key" {
  description = "this is the mumb region key-pair"
  type        = string
}

variable "instance_name" {
  description = "Tag name for the EC2 instance"
  type        = string
}

variable "intance_count" {
  type    = number
  default = 2
}

variable "for_eachdemo" {
  type = map(string)
  default = {
    qa  = "t3.micro"
    dev = "t3.small"
  }
}