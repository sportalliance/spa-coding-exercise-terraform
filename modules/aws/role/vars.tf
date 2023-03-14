variable "role_name" {
  description = "Name of the role"
  type        = string
}

variable "policy_name" {
  description = "Name of the policy"
  type        = string
}

variable "policy_arns" {
  description = "Policies to attach"
  type        = set(string)
}

variable "assume_policy_json" {
  description = "Asumme role policy as json string"
  type        = string
}
