variable "region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-east-1"
}

variable "name" {
  description = "Prefix for resource names"
  type        = string
  default     = "cloud-pipeline"
}

variable "instance_type" {
  description = "EC2 instance size"
  type        = string
  default     = "t3.micro"
}

variable "image" {
  description = "Container image to run (must be public)"
  type        = string
  default     = "ghcr.io/ok-22/cloud-pipeline:latest"
}

variable "allowed_cidr" {
  description = "Who may reach the web port"
  type        = string
  default     = "0.0.0.0/0"
}
