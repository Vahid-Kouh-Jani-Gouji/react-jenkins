variable "ami_id" {
  type = string
  default = "ami-06dd92ecc74fdfb36" #ubuntu
}

variable "instance_type" {
  type = string
  default = "t2.small"
}

variable "instance_profile" {
  type = string
  default = ""
}

variable "instance_userdata" {
  type = string
  
}