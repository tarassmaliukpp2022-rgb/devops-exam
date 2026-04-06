variable "do_token" {
  description = "DigitalOcean API Token"
  type        = string
  sensitive   = true
}

variable "spaces_access_key" {
  description = "DigitalOcean Spaces Access Key (для backend)"
  type        = string
  sensitive   = true
}

variable "spaces_secret_key" {
  description = "DigitalOcean Spaces Secret Key (для backend)"
  type        = string
  sensitive   = true
}

variable "region" {
  description = "DigitalOcean регіон (найближчий до України)"
  type        = string
  default     = "fra1" # Frankfurt — найближчий до України
}

variable "prefix" {
  description = "Префікс для назв ресурсів"
  type        = string
  default     = "smaliuk"
}

variable "ssh_public_key" {
  description = "SSH публічний ключ для доступу до ВМ"
  type        = string
  sensitive   = true
}
