provider "aws"{
    region="us-east-1"
}
resource "aws_key_pair" "key"{
    key_name=""
    public_key=""

}
resource "aws_security_group" "allow_http"{
    name="allow_http"
    description ="Allow HTTP Traffic"
    ingress{
        from_port=80
        to_port=80
        protocol ="tcp"
        cidr_blocks =["0.0.0.0/0"]
    } 
    ingress{
        from_port=22
        to_port=22
        protocol ="tcp"
        cidr_blocks =["0.0.0.0/0"]
}

resource "aws_instance" "app" {
  ami           = "ami-0c55b159cbfafe1f0"  # Replace with the latest Ubuntu AMI ID
  instance_type = "t2.micro"                # Instance type (free tier eligible)
  key_name      = aws_key_pair.key.key_name # Reference to the key pair created above
  security_groups = [aws_security_group.allow_http.name] # Use the security group created above

  tags = {
    Name = "Terraform-Instance"  # Tag for easier identification
  }
}
}