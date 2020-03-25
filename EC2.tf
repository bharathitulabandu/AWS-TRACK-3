CREATING EC2 INSTANCE USING TERRAFORM:

provider "aws" {
  region = "us-west-2"
}

data "aws_ami" "linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["linux/images/hvm-ssd/linux-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = "${data.aws_ami.linux.id}"
  instance_type = "t2.micro"

  tags = {
    Name = "HelloWorld"
  }
}