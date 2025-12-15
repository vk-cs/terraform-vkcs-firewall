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

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (>= 1.3)

- <a name="requirement_vkcs"></a> [vkcs](#requirement\_vkcs) (>= 0.13.1, < 1.0.0)

## Resources

The following resources are used by this module:

- [vkcs_networking_secgroup.secgroup](https://registry.terraform.io/providers/vk-cs/vkcs/latest/docs/resources/networking_secgroup) (resource)
- [vkcs_networking_secgroup_rule.rules](https://registry.terraform.io/providers/vk-cs/vkcs/latest/docs/resources/networking_secgroup_rule) (resource)

## Required Inputs

The following input variables are required:

### <a name="input_name"></a> [name](#input\_name)

Description: Default name for module resources. Used when name is not specified for a resource.

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_region"></a> [region](#input\_region)

Description: The region in which to create module resources.

Type: `string`

Default: `null`

### <a name="input_sdn"></a> [sdn](#input\_sdn)

Description: SDN to use for this module. Must be set if more than one sdn are plugged to the project.

Type: `string`

Default: `null`

### <a name="input_tags"></a> [tags](#input\_tags)

Description: Default set of module resources tags.

Type: `set(string)`

Default: `[]`

### <a name="input_description"></a> [description](#input\_description)

Description: A description for the security group.

Type: `string`

Default: `null`

### <a name="input_delete_default_rules"></a> [delete\_default\_rules](#input\_delete\_default\_rules)

Description: Whether or not to delete the default egress security rules.

Type: `bool`

Default: `false`

### <a name="input_rules"></a> [rules](#input\_rules)

Description: List of security rules. See `vkcs_networking_secgroup_rule` arguments.

`port` - could be used for single port rule instead of setting both `port_range_min` and `port_range_max`. Do not use `port` and `port_range_min` with `port_range_max` together.

Type:

```hcl
list(object({
    description      = optional(string)
    direction        = optional(string, "ingress")
    protocol         = optional(string)
    port             = optional(number)
    port_range_max   = optional(number)
    port_range_min   = optional(number)
    remote_ip_prefix = optional(string)
    remote_group_id  = optional(string)
  }))
```

Default: `[]`

## Outputs

The following outputs are exported:

### <a name="output_secgroup_id"></a> [secgroup\_id](#output\_secgroup\_id)

Description: Security group ID.
<!-- END_TF_DOCS -->