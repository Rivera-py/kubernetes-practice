variable "ami_id" {
  description = "AMI Id to build instances with."
  type = string
  default = "ami-0015a39e4b7c0966f"
}

variable "instance_type" {
  description = "Type of instance to provision."
  type = string
  default = "t2.medium"
}

variable "key_pair_name" {
  description = "Name of the key pair to assign to the instance."
  type = string
  default = "k8s_pair"
}
