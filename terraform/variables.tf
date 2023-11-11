variable "location" {

  default = "us-east-1"

}

variable "os-name" {
    default = "ami-053b0d53c279acc90"

}

variable "instance-type"{
    default = "t2.micro"
}

variable "key"{
    default = "test-server-key"
}

variable "vpc-cidr"{
    default = "10.10.0.0/16"
}

variable "subnet1-cidr"{
    default = "10.10.0.0/24"
}