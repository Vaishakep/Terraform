provider "aws" {
    access_key = "AKIAQQU4xxxPMMABKVJD"
    secret_key = "ZXp1hVGKC7QqxxxxxxUqQsgrWBiUnUK45Yj8l"
    region = "us-west-2"
}


resource "aws_key_pair" "sshkey" {
  key_name   = "terraform-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABxxxxxxx7KmGatuIhaq6P8FKNOFnMJRmcYx1gg3yH40Mvd+R3YT9HFLvEirYvYnT0bYvAnPabLGPwxZDkCayA/LvQe0/BxlhzVONgghGGoNLhUwSQ7SjUjJBuEmYLKhs7qp213OY8LVN78piG3Ida5ppj7Y+oxM9vDRFuQmyvv3wRJRYyU3+M4/ZwzpUr+fLNBRgB3boTTTiyXW17FIWd/T+zubVIo3I3U0hBoRFhrE3pEFCdXaq2Nc/0UmjfgygyjZTHqwgmOJPBrB4Mr1Dus8oJQyeoK1xHpKREIJSnkbSSMWoclN4LaTnn0Yj7IOvT3NjENNCUufgc6R root@MSI"
}

resource "aws_security_group" "terraform-security" {
     name            = "terraform-security"
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
        Name = "terraform-security"
    }
}
