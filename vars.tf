/*Predefined Variables for VPC*/

/*VPC Information*/
variable "vpc-fullcidr" {
  default     = "10.1.0.0/21"
  description = "app vpc cdir"
}

/******************/
/*Public Subnets*/
/******************/
variable "EU1-Pub1" {
  default     = "10.1.1.0/24"
  description = "EU1-Pub1"
}

variable "EU1-Pub2" {
  default     = "10.1.2.0/24"
  description = "EU1-Pub2"
}

/*******************/
/*Private Subnets*/
/*******************/
variable "EU1-Pri1" {
  default     = "10.1.3.0/24"
  description = "EU1-Pri1"
}

variable "EU1-Pri2" {
  default     = "10.1.4.0/24"
  description = "EU1-Pri2"
}

/*SSH Key Name*/
variable "key_name" {
  default     = "EU1-KP"
  description = "app Default SSH Key"
}

/*AMI*/
data "aws_ami" "ami-amazon-linux-2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}

