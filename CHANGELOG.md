# VKCS Firewall Terraform module's changelog

#### v0.0.3
- Use natural keys for rules instead of indexes. **Note**: This is breaking change. All rules will be recreated.
  Also you must provide `resource_key` for rules with `remote_group_id` specified.

#### v0.0.2
- Load module from zip archive for examples

#### v0.0.1
- Initial release
