variable "region" {
  default = "us-east-1"
}

variable "zone" {
  default = "us-east-1a"
}

variable "user" {
  default = "ubuntu"
}

variable "environment" {
  default = "development"
}

variable "subnet" {
  default = ""
}

variable "image" {
  default = "ami-0557a15b87f6559cf"
}
#ami-0557a15b87f6559cf -- UBUNTU

variable "ssh" {
  default = ""
}

variable "security-group" {
  default = ""
}

variable "source_script" {
  default = ""
}

variable "destination_loc" {
  default = ""
}

variable public-key {
    default = ""
}

variable private-key {
    default = ""
}

variable "myip" {
  default = ""
}
