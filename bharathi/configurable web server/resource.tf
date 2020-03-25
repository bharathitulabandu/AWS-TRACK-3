resource "aws_instance" "web_server" {
ami = "ami-03b5297d565ef30a6"
instance_type = "t2.micro"
vpc_security_group_ids = [aws_security_group.webserverSG.id]
  tags = {
    Name = "single-web server"
  }
  user_data = <<-EOF
            #!/bin/bash
            yum install httpd
            service start httpd
            cd /var/www/html
            echo " hello world " > index.html
            EOF
}

resource "aws_security_group" "websevrerSG" {
  name = "single-web server SG"
  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "public_ip" {
  value       = aws_instance.webserver.public_ip
}
