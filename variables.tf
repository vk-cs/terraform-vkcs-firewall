variable "name" {
  type        = string
  description = "A name for the security group."

  validation {
    condition     = length(var.name) > 0
    error_message = "Security group name cannot be empty."
  }
}

variable "delete_default_rules" {
  type        = bool
  description = "Whether or not to delete the default egress security rules."
  default     = false
}

variable "description" {
  type        = string
  description = "A description for the security group."
  default     = ""
}

variable "region" {
  type        = string
  description = "The region in which to obtain the networking client."
  default     = null
}

variable "sdn" {
  type        = string
  description = " SDN to use for this resource. Must be one of following: neutron, sprut."
  default     = null

  validation {
    condition     = var.sdn == null || contains(["neutron", "sprut"], var.sdn)
    error_message = "SDN must be either 'neutron' or 'sprut'."
  }
}

variable "tags" {
  type        = set(string)
  description = "Tags for the security group."
  default     = []
}

variable "rules" {
  type = list(object({
    direction        = string
    description      = optional(string)
    port_range_max   = optional(number)
    port_range_min   = optional(number)
    protocol         = optional(string)
    remote_group_id  = optional(string)
    remote_ip_prefix = optional(string)
  }))
  description = "List of security rules."
  default     = []

  validation {
    condition = alltrue([
      for rule in var.rules : contains(["ingress", "egress"], rule.direction)
    ])
    error_message = "Direction must be either 'ingress' or 'egress'."
  }

  validation {
    condition = alltrue([
      for rule in var.rules : rule.remote_group_id == null || rule.remote_ip_prefix == null
    ])
    error_message = "Only one of remote_group_id or remote_ip_prefix can be specified per rule."
  }
}

