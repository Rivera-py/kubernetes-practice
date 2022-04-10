data "aws_vpc" "default_vpc" {
  default = true
}

resource "aws_security_group" "k8s_security_group" {
  name = "k8s-security-group"
  description = "Allow SSH and internet access."
  vpc_id = data.aws_vpc.default_vpc.id

  ingress {
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "Allow myself to SSH to EC2 instances."
    from_port = 22
    protocol = "TCP"
    to_port = 22
  }

  ingress {
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "Allow myself to access exposed hello-node service."
    from_port = var.service_port
    protocol = "TCP"
    to_port = var.service_port
  }

  egress {
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "All outbound allowed."
    from_port = 0
    protocol = "-1"
    to_port = 0
  }
}

resource "aws_instance" "k8s_server" {
  ami = var.ami_id
  instance_type = var.instance_type
  key_name = var.key_pair_name
  vpc_security_group_ids = [ aws_security_group.k8s_security_group.id ]

  user_data_base64 = filebase64("./scripts/bootstrap.sh")
}

output "instance_public_ip" {
  value = aws_instance.k8s_server.public_ip
}