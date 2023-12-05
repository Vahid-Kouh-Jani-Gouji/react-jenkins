resource "aws_security_group" "ec2_sg" {
  name        = "ec2_security_group"
  description = "Security Group for EC2 Instance"

  ingress {
    description = "Allow SSH"
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "http for jenkins"
    from_port = 8080
    to_port   = 8080
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "http for all"
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    description = "Allow all outbound traffic"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_key_pair" "kp_react" {
  key_name   = "ec2 key react"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_instance" "ec2_instance" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  security_groups = [aws_security_group.ec2_sg.name]
  key_name        = aws_key_pair.kp_react.key_name
  iam_instance_profile = var.instance_profile == "" ? null : var.instance_profile
  user_data=var.instance_userdata
  
#    user_data = (templatefile("bootstrap.sh.tpl",{}))
# user_data = file("bootstrap.sh")

}

