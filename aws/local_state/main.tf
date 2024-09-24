# Define the provider
provider "aws" {
  region = "ap-southeast-2"  # Specify the region
}

# Define an EC2 security group to allow SSH access
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Replace with your IP for more security
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Define EC2 instances
resource "aws_instance" "example" {
  count = 3  # Create 3 EC2 instances

  ami           = "ami-0bfe89c8e3d79ad82"  # Replace with your desired AMI ID
  instance_type = "t2.micro"               # Instance type
  key_name      = "LEO.pem"            # Replace with your key pair name

  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  tags = {
    Name = "Terraform-EC2-Instance-${count.index + 1}"
  }
}

# Output public IPs of the instances
output "instance_public_ips" {
  description = "The public IPs of the EC2 instances"
  value       = aws_instance.example[*].public_ip
}


