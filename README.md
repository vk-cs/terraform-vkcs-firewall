<!-- BEGIN_TF_DOCS -->
![Beta Status](https://img.shields.io/badge/Status-Beta-yellow)

# VKCS Firewall Terraform module
A Terraform module for creating `Firewall` in VKCS.

## Examples
You can find examples in the [`examples`](./examples) directory.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_vkcs"></a> [vkcs](#requirement\_vkcs) | < 1.0.0 |

## Resources

| Name | Type |
|------|------|
| [vkcs_networking_secgroup.secgroup](https://registry.terraform.io/providers/vk-cs/vkcs/latest/docs/resources/networking_secgroup) | resource |
| [vkcs_networking_secgroup_rule.rules](https://registry.terraform.io/providers/vk-cs/vkcs/latest/docs/resources/networking_secgroup_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_delete_default_rules"></a> [delete\_default\_rules](#input\_delete\_default\_rules) | Whether or not to delete the default egress security rules. | `bool` | `false` | no |
| <a name="input_description"></a> [description](#input\_description) | A description for the security group. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | A name for the security group. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region in which to obtain the networking client. | `string` | `null` | no |
| <a name="input_rules"></a> [rules](#input\_rules) | List of security rules. See `vkcs_networking_secgroup_rule` arguments.<br/>Use `port` or `port_range_min` and `port_range_max`. | <pre>list(object({<br/>    direction        = optional(string, "ingress")<br/>    description      = optional(string)<br/>    port             = optional(number)<br/>    port_range_max   = optional(number)<br/>    port_range_min   = optional(number)<br/>    protocol         = optional(string)<br/>    remote_group_id  = optional(string)<br/>    remote_ip_prefix = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_sdn"></a> [sdn](#input\_sdn) | SDN to use for this resource. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for the security group. | `set(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_secgroup_id"></a> [secgroup\_id](#output\_secgroup\_id) | Security group id |
<!-- END_TF_DOCS -->