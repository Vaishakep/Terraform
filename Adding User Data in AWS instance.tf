:~# cat install-httpd.sh
#!/bin/bash

yum install httpd -y
service httpd restart
chkconfig httpd on
echo "<h1><center>Deployed From Terraform</center></h1>" > /var/www/html/index.html



--------------------------
:~# cat code.tf

provider "aws" {
    access_key = "AKIAxxxxxxxxxxP"
    secret_key = "UOydK+ALeJxxxxxxxxxxUEci90Du/Ec"
    region = "us-east-2"
}

resource "aws_key_pair" "sshkey" {
  key_name   = "terraform-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDLqxhyDlJNcwysPmMBGn/GIfljbE+jwcrEKt4k0QoYEBFAMjW5LPKMuOQBYNgGgAkYUBJ1pWMzAkjSFMUns6ALs6qntVr/NroGCZOP64cm132gTWpGg1nRnuzCjKkA1jV6/y5hNZC4PIo/WWF+YG8cg74mNcKXAyOdE8MDJOZWQ/9bWC3MoMj6MGV5htTnH8ZI+BqS+VMLlu1cKf1JssgBxFUj5e9FcBwqgPNIBKt9jl3hXTWO/YyrfEbe7guZAIe7scZHefe0wBhtYbntDyC8lnE8sgdVGKY0T3TG5GOQcJp1Ap2jisqd9xU7BCbAD7+AVSLJ+ihtelf5gJMsZw5/ root@MSI"
}

resource "aws_security_group" "my-sec" {
     name            = "my-sec"
    description  = "allows 22,80 from all"

    ingress {
        cidr_blocks = ["0.0.0.0/0"]
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
      }

    ingress {
        cidr_blocks = ["0.0.0.0/0"]
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
      }

    ingress {
        cidr_blocks = ["0.0.0.0/0"]
        from_port   = 3306
        to_port     = 3306
        protocol    = "tcp"
      }

    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    tags = {
        Name = "my-sec"
    }
}



resource "aws_instance" "webserver" {

    ami = "ami-00bf61xxxxx6b409"
    instance_type = "t2.micro"
    key_name = "terraform-key"
    user_data = file("install-httpd.sh")
    availability_zone  = "us-east-2a"
    associate_public_ip_address = true
    vpc_security_group_ids = ["${aws_security_group.my-sec.id}"]
    tags = {
        Name = "Webserver"
  }
}
