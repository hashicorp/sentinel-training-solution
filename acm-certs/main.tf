variable "domain_1" {
  description = "domain of first Amazon Certificate Manager certificate"
}

variable "domain_2" {
  description = "domain of second Amazon Certificate Manager certificate"
}

data "aws_acm_certificate" "cert_1" {
  domain = "${var.domain_1}"
}

data "aws_acm_certificate" "cert_2" {
  domain = "${var.domain_2}"
}
