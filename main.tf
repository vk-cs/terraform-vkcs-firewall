resource "vkcs_networking_secgroup" "secgroup" {
  region               = var.region
  sdn                  = var.sdn
  tags                 = var.tags
  name                 = var.name
  description          = var.description
  delete_default_rules = var.delete_default_rules
}

resource "vkcs_networking_secgroup_rule" "rules" {
  for_each = local.rules

  security_group_id = vkcs_networking_secgroup.secgroup.id
  region            = var.region
  sdn               = var.sdn
  description       = each.value.description
  direction         = each.value.direction
  protocol          = each.value.protocol
  port_range_max    = each.value.port_range_max
  port_range_min    = each.value.port_range_min
  remote_ip_prefix  = each.value.remote_ip_prefix
  remote_group_id   = each.value.remote_group_id
}
