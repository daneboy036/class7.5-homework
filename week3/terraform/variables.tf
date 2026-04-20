variable "project_id" {
  description = "GCP project id (student supplies)"
  type        = string
}

variable "region" {
  type    = string
  default = "us-central1"
}

variable "zone" {
  type    = string
  default = "us-central1-a"
}

variable "student_name" {
  type    = string
  default = "Anonymous Padawan (temporarily)"
}

variable "vm_name" {
  type    = string
  default = "week2-lab"
}
