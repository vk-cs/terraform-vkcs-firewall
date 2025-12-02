variable "region" {
  type        = string
  description = "The region in which to obtain the networking client."
  default     = null
}

variable "sdn" {
  type        = string
  description = "SDN to use for this resource."
  default     = null
}

variable "name" {
  type        = string
  description = "A name for the security group."
}

variable "tags" {
  type        = set(string)
  description = "Tags for the security group."
  default     = []
}

variable "delete_default_rules" {
  type        = bool
  description = "Whether or not to delete the default egress security rules."
  default     = false
}

variable "description" {
  type        = string
  description = "A description for the security group."
  default     = null
}

variable "rules" {
  type = list(object({
    direction        = optional(string, "ingress")
    description      = optional(string)
    port             = optional(number)
    port_range_max   = optional(number)
    port_range_min   = optional(number)
    protocol         = optional(string)
    remote_group_id  = optional(string)
    remote_ip_prefix = optional(string)
  }))
  description = <<-EOT
  List of security rules. See `vkcs_networking_secgroup_rule` arguments.
  Use `port` or `port_range_min` and `port_range_max`.
  EOT
  default     = []

  validation {
    condition = alltrue([
      for idx, rule in var.rules :
      !(rule.port != null && (rule.port_range_min != null || rule.port_range_max != null))
    ])
    error_message = "Use either 'port' OR 'port_range_min' and 'port_range_max', not both."
  }
}
