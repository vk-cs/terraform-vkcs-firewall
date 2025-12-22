locals {
  rules = {
    for rule in [
      for rule in var.rules : merge(rule, {
        port_range_max = rule.port_range_max != null ? rule.port_range_max : rule.port
        port_range_min = rule.port_range_min != null ? rule.port_range_min : rule.port
      })
      ] : coalesce(rule.resource_key, format(
        "%s/%s/%s/%s/%s",
        coalesce(rule.direction, "_"),
        coalesce(rule.protocol, "_"),
        coalesce(rule.port_range_min, "_"),
        coalesce(rule.port_range_max, "_"),
        coalesce(rule.remote_ip_prefix, "_"),
    )) => rule
  }
}
