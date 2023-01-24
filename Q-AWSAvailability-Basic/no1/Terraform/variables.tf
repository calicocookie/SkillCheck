variable "vpc_id" {
  default = "vpc-0123abcd"
}

variable "igw_id" {
  default = "igw-abcdefgh"
}

variable "subnet" {
  default = {
    "public_c"  = "10.110.1.0/24"
    "public_d"  = "10.110.2.0/24"
    "private_c" = "10.110.3.0/24"
    "private_d" = "10.110.4.0/24"
  }
}

variable "region" {
  default = "ap-northeast-1"
}

variable "availability_1" {
  default = "ap-northeast-1c"
}

variable "availability_2" {
  default = "ap-northeast-1d"
}

variable "alb_sg_ips" {
  description = "サービスの利用者のアクセス元の IP アドレス"
  default = [
    "123.123.123.12/32",
  ]
}

variable "dns_zone_id" {
  default = "ABCDEFGH"
}

variable "ami_id" {
  default = "ami-abcdef"
}

variable "app_certificate_arn" {
  default = "arn:aws:acm:ap-northeast-1:123456789012:certificate/abcde-1234"
}
