provider "aws" {
  region = "ap-southeast-2"  # Change to your preferred region
}

resource "aws_instance" "my_instance" {
  count         = 3  # This creates three instances
  ami           = "ami-0bfe89c8e3d79ad82"  # Replace with your desired AMI ID
  instance_type = "t2.micro"  # Change to your preferred instance type
  key_name      = "LEO.pem"  # Replace with your EC2 key pair name

  tags = {
    Name = "MyInstance-${count.index + 1}"
  }
}

output "instance_ids" {
  value = aws_instance.my_instance[*].id
}


