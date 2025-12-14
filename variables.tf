variable "region" {
  type        = string
  description = "The region in which to create module resources."
  default     = null
}

variable "sdn" {
  type        = string
  description = "SDN to use for this module. Must be set if more than one sdn are plugged to the project."
  default     = null
}

variable "tags" {
  type        = set(string)
  description = "Default set of module resources tags."
  default     = []
}

variable "name" {
  type        = string
  description = "Default name for module resources. Used when name is not specified for a resource."
}

variable "description" {
  type        = string
  description = "A description for the security group."
  default     = null
}

variable "delete_default_rules" {
  type        = bool
  description = "Whether or not to delete the default egress security rules."
  default     = false
}

variable "rules" {
  type = list(object({
    description      = optional(string)
    direction        = optional(string, "ingress")
    protocol         = optional(string)
    port             = optional(number)
    port_range_max   = optional(number)
    port_range_min   = optional(number)
    remote_ip_prefix = optional(string)
    remote_group_id  = optional(string)
  }))
  description = <<-EOT
  List of security rules. See `vkcs_networking_secgroup_rule` arguments.
  `port` - could be used for single port rule instead of setting both `port_range_min` and `port_range_max`. Do not use `port` and `port_range_min` with `port_range_max` together.
  EOT
  default     = []

  validation {
    condition = alltrue([
      for idx, rule in var.rules :
      !(rule.port != null && (rule.port_range_min != null || rule.port_range_max != null))
    ])
    error_message = "Use either 'port' or 'port_range_min' and 'port_range_max', not both."
  }
}
