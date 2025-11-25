module "firewall-admin" {
  source = "../"

  name        = "admin-tf-example"
  description = "Admin access"
  tags        = ["firewall", "example", "admin"]

  rules = [
    {
      description      = "SSH rule"
      direction        = "ingress"
      protocol         = "tcp"
      port_range_max   = 22
      port_range_min   = 22
      remote_ip_prefix = "0.0.0.0/0"
    },
    {
      description      = "Ping rule"
      direction        = "ingress"
      protocol         = "icmp"
      remote_ip_prefix = "0.0.0.0/0"
    }
  ]
}

module "firewall-http" {
  source = "../"

  name        = "http-tf-example"
  description = "HTTP access"
  tags        = ["firewall", "example", "http"]

  rules = [
    {
      description    = "HTTP rule"
      direction      = "ingress"
      protocol       = "tcp"
      port_range_max = 80
      port_range_min = 80
      # Allow access from application network only
      remote_ip_prefix = vkcs_networking_subnet.app.cidr
    },
    {
      description      = "Alternative HTTP rule"
      direction        = "ingress"
      protocol         = "tcp"
      port_range_max   = 8080
      port_range_min   = 8080
      remote_ip_prefix = vkcs_networking_subnet.app.cidr
    }
  ]
}

module "firewall-etcd" {
  source = "../"

  name        = "etcd-tf-example"
  description = "ETCD service"
  tags        = ["firewall", "example", "etcd"]

  rules = [
    {
      description      = "etcd app clients rule"
      direction        = "ingress"
      protocol         = "tcp"
      port_range_max   = 2379
      port_range_min   = 2379
      remote_ip_prefix = vkcs_networking_subnet.app.cidr
    },
    {
      description      = "etcd db clients rule"
      direction        = "ingress"
      protocol         = "tcp"
      port_range_max   = 2379
      port_range_min   = 2379
      remote_ip_prefix = vkcs_networking_subnet.db.cidr
    },
    {
      description     = "etcd peer communication rule"
      direction       = "ingress"
      protocol        = "tcp"
      port_range_max  = 2380
      port_range_min  = 2380
      remote_group_id = module.firewall-etcd.secgroup_id
    }
  ]
}