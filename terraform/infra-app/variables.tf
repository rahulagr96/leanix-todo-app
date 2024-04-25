variable "env" {
  type        = string
  description = "Region location"
  default     = "dev"
}

variable "location" {
  type        = string
  description = "Region location"
  default     = "North Europe"
}

variable "administrator_login" {
  type        = string
  description = "db administrator login username"
}

variable "administrator_login_password" {
  type        = string
  description = "db administrator login password"
}