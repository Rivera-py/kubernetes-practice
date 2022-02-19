resource "aws_instance" "k8s_server" {
  ami = var.ami_id
  instance_type = var.instance_type
  key_name = var.key_pair_name
}