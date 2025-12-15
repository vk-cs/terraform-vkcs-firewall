<!-- BEGIN_TF_DOCS -->
![Beta Status](https://img.shields.io/badge/Status-Beta-yellow)

# VKCS Firewall Terraform module
A Terraform module for `Firewall` in VKCS.

This modules makes it easy to setup security group in VKCS.

It supports creating:
- security group
- security group rules

## Usage
### Enable all traffic
```hcl
module "firewall_all" {
  source = "../../"

  name = "all-tf-example"

  rules = [{
    remote_ip_prefix = "0.0.0.0/0"
  }]
}
```

## Examples
You can find examples in the [`examples`](./examples) directory on [GitHub](https://github.com/vk-cs/terraform-vkcs-firewall/tree/v0.0.1/examples).

Running an example:
- Clone [GitHub repository](https://github.com/vk-cs/terraform-vkcs-firewall/v0.0.1/main)
- [Install Terraform](https://cloud.vk.com/docs/en/tools-for-using-services/terraform/quick-start). **Note**: You do not need `vkcs_provider.tf` to run module example.
- [Init Terraform](https://cloud.vk.com/docs/en/tools-for-using-services/terraform/quick-start#terraform_initialization) from the example folder.
- [Run Terraform](https://cloud.vk.com/docs/en/tools-for-using-services/terraform/quick-start#creating_resources_via_terraform) to create example resources.
- Check example output and explore created resources with `terraform show`, management console, CLI and API requests.
- Remove example resources with `terraform destroy -auto-approve --refresh=false`

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_vkcs"></a> [vkcs](#requirement\_vkcs) | >= 0.13.1, < 1.0.0 |

## Resources

| Name | Type |
|------|------|
| [vkcs_networking_secgroup.secgroup](https://registry.terraform.io/providers/vk-cs/vkcs/latest/docs/resources/networking_secgroup) | resource |
| [vkcs_networking_secgroup_rule.rules](https://registry.terraform.io/providers/vk-cs/vkcs/latest/docs/resources/networking_secgroup_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_region"></a> [region](#input\_region) | The region in which to create module resources. | `string` | `null` | no |
| <a name="input_sdn"></a> [sdn](#input\_sdn) | SDN to use for this module. Must be set if more than one sdn are plugged to the project. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Default set of module resources tags. | `set(string)` | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | Default name for module resources. Used when name is not specified for a resource. | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | A description for the security group. | `string` | `null` | no |
| <a name="input_delete_default_rules"></a> [delete\_default\_rules](#input\_delete\_default\_rules) | Whether or not to delete the default egress security rules. | `bool` | `false` | no |
| <a name="input_rules"></a> [rules](#input\_rules) | List of security rules. See `vkcs_networking_secgroup_rule` arguments.<br/>`port` - could be used for single port rule instead of setting both `port_range_min` and `port_range_max`. Do not use `port` and `port_range_min` with `port_range_max` together. | <pre>list(object({<br/>    description      = optional(string)<br/>    direction        = optional(string, "ingress")<br/>    protocol         = optional(string)<br/>    port             = optional(number)<br/>    port_range_max   = optional(number)<br/>    port_range_min   = optional(number)<br/>    remote_ip_prefix = optional(string)<br/>    remote_group_id  = optional(string)<br/>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_secgroup_id"></a> [secgroup\_id](#output\_secgroup\_id) | Security group ID. |
<!-- END_TF_DOCS -->