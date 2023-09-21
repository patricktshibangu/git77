provider "aws" {
  region = "us-east-1"  # Update the region to your desired region
}

resource "aws_lightsail_instance" "example" {
  name              = "patrick2-server"
  availability_zone = "us-east-1a"  # Update the availability zone as needed
  blueprint_id      = "centos_7_1901_01"
  bundle_id = "nano_1_0"
  key_pair_name = "week3"

  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y 
    sudo yum install unzip wget httpd -y
    sudo wget https://github.com/utrains/static-resume/archive/refs/heads/main.zip
    sudo unzip main.zip
    sudo rm -rf /var/www/html/*
    sudo cp -r static-resume-main/* /var/www/html/
    sudo systemctl start httpd
    sudo systemctl enable httpd
    EOF
}

output "public_ip" {
  value = aws_lightsail_instance.example.public_ip_address
}