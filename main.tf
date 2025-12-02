resource "vkcs_networking_secgroup" "secgroup" {
  name                 = var.name
  delete_default_rules = var.delete_default_rules
  description          = var.description
  region               = var.region
  sdn                  = var.sdn
  tags                 = var.tags
}

resource "vkcs_networking_secgroup_rule" "rules" {
  for_each = { for idx, rule in var.rules : idx => rule }

  direction         = each.value.direction
  security_group_id = vkcs_networking_secgroup.secgroup.id
  description       = each.value.description
  port_range_max    = each.value.port_range_max != null ? each.value.port_range_max : each.value.port
  port_range_min    = each.value.port_range_min != null ? each.value.port_range_min : each.value.port
  protocol          = each.value.protocol
  region            = var.region
  remote_group_id   = each.value.remote_group_id
  remote_ip_prefix  = each.value.remote_ip_prefix
  sdn               = var.sdn
}
