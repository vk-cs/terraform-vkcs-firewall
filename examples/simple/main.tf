module "firewall_all" {
  source = "../../"

  name = "all-tf-example"

  rules = [{
    remote_ip_prefix = "0.0.0.0/0"
  }]
}
