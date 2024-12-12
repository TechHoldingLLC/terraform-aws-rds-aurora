## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.rds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_db_parameter_group.instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group) | resource |
| [aws_db_subnet_group.rds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_iam_role.enhanced_monitoring](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.enhanced_monitoring](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_rds_cluster.db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster) | resource |
| [aws_rds_cluster_instance.db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_instance) | resource |
| [aws_rds_cluster_parameter_group.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_parameter_group) | resource |
| [aws_iam_policy_document.rds_trust_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_kms_key.rds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/kms_key) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_major_version_upgrade"></a> [allow\_major\_version\_upgrade](#input\_allow\_major\_version\_upgrade) | allow\_major\_version\_upgrade | `bool` | `false` | no |
| <a name="input_apply_immediately"></a> [apply\_immediately](#input\_apply\_immediately) | Apply changes imediately | `bool` | `false` | no |
| <a name="input_auto_minor_version_upgrade"></a> [auto\_minor\_version\_upgrade](#input\_auto\_minor\_version\_upgrade) | Auto minor version upgradation during maintainance window | `bool` | `false` | no |
| <a name="input_backup_retention_period"></a> [backup\_retention\_period](#input\_backup\_retention\_period) | Backup retention period | `number` | n/a | yes |
| <a name="input_backup_window"></a> [backup\_window](#input\_backup\_window) | When to perform DB backups | `string` | n/a | yes |
| <a name="input_certificate_identifier"></a> [certificate\_identifier](#input\_certificate\_identifier) | rds certificate identifier | `string` | `"rds-ca-rsa2048-g1"` | no |
| <a name="input_cloudwatch_log_group_retention_in_days"></a> [cloudwatch\_log\_group\_retention\_in\_days](#input\_cloudwatch\_log\_group\_retention\_in\_days) | The number of days to retain CloudWatch logs for the DB instance | `number` | `30` | no |
| <a name="input_cluster_custom_parameters"></a> [cluster\_custom\_parameters](#input\_cluster\_custom\_parameters) | RDS cluster custom parameter group | `list(any)` | `[]` | no |
| <a name="input_create_monitoring_role"></a> [create\_monitoring\_role](#input\_create\_monitoring\_role) | Create IAM role with a defined name that permits RDS to send enhanced monitoring metrics to CloudWatch Logs. | `bool` | `false` | no |
| <a name="input_database_name"></a> [database\_name](#input\_database\_name) | Database name | `string` | `null` | no |
| <a name="input_db_subnet_group_name"></a> [db\_subnet\_group\_name](#input\_db\_subnet\_group\_name) | DB subnet group name | `string` | `""` | no |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | Deletion protection | `bool` | `true` | no |
| <a name="input_enable_http_endpoint"></a> [enable\_http\_endpoint](#input\_enable\_http\_endpoint) | Enable HTTP endpoint (data API). | `bool` | `false` | no |
| <a name="input_enabled_cloudwatch_logs_exports"></a> [enabled\_cloudwatch\_logs\_exports](#input\_enabled\_cloudwatch\_logs\_exports) | Enabled cloudwatch logs export | `list(any)` | `[]` | no |
| <a name="input_engine"></a> [engine](#input\_engine) | RDS db engine | `string` | n/a | yes |
| <a name="input_engine_mode"></a> [engine\_mode](#input\_engine\_mode) | RDS DB engine mode | `string` | `"provisioned"` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | RDS db engine version | `string` | n/a | yes |
| <a name="input_enhanced_monitoring_interval"></a> [enhanced\_monitoring\_interval](#input\_enhanced\_monitoring\_interval) | The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60. | `number` | `0` | no |
| <a name="input_instance_class"></a> [instance\_class](#input\_instance\_class) | RDS instance class | `string` | `"db.t3.medium"` | no |
| <a name="input_instance_count"></a> [instance\_count](#input\_instance\_count) | Minimum instance for scaling | `number` | `0` | no |
| <a name="input_instance_custom_parameters"></a> [instance\_custom\_parameters](#input\_instance\_custom\_parameters) | RDS db custom parameter group | `list(any)` | `[]` | no |
| <a name="input_maintenance_window"></a> [maintenance\_window](#input\_maintenance\_window) | When to perform DB maintenance | `string` | `"sun:05:00-sun:06:00"` | no |
| <a name="input_master_password"></a> [master\_password](#input\_master\_password) | RDS Master password | `string` | `null` | no |
| <a name="input_master_username"></a> [master\_username](#input\_master\_username) | RDS Master username | `string` | `null` | no |
| <a name="input_max_capacity"></a> [max\_capacity](#input\_max\_capacity) | Maximum capacity for an Aurora DB cluster in provisioned DB engine mode. Valid capacity values are in a range of 0.5 up to 128 in steps of 0.5. | `number` | `0` | no |
| <a name="input_min_capacity"></a> [min\_capacity](#input\_min\_capacity) | Minimum capacity for an Aurora DB cluster in provisioned DB engine mode. Valid capacity values are in a range of 0.5 up to 128 in steps of 0.5. | `number` | `0` | no |
| <a name="input_monitoring_role_arn"></a> [monitoring\_role\_arn](#input\_monitoring\_role\_arn) | The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs. Must be specified if monitoring\_interval is non-zero. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | RDS name | `string` | n/a | yes |
| <a name="input_performance_insights_enabled"></a> [performance\_insights\_enabled](#input\_performance\_insights\_enabled) | Specifies whether Performance Insights are enabled | `bool` | `false` | no |
| <a name="input_performance_insights_kms_key_id"></a> [performance\_insights\_kms\_key\_id](#input\_performance\_insights\_kms\_key\_id) | The ARN for the KMS key to encrypt Performance Insights data. | `string` | `null` | no |
| <a name="input_performance_insights_retention_period"></a> [performance\_insights\_retention\_period](#input\_performance\_insights\_retention\_period) | The amount of time in days to retain Performance Insights data. Either 7 (7 days) or 731 (2 years). | `number` | `7` | no |
| <a name="input_port"></a> [port](#input\_port) | RDS port | `number` | `null` | no |
| <a name="input_publicly_accessible"></a> [publicly\_accessible](#input\_publicly\_accessible) | Publicaly accessible | `bool` | `false` | no |
| <a name="input_replication_source_identifier"></a> [replication\_source\_identifier](#input\_replication\_source\_identifier) | ARN of a source DB cluster or DB instance if this DB cluster is to be created as a Read Replica. | `string` | `""` | no |
| <a name="input_scaling_configuration"></a> [scaling\_configuration](#input\_scaling\_configuration) | scaling\_configuration configuration is only valid when engine\_mode is set to serverless | `map(any)` | `{}` | no |
| <a name="input_skip_final_snapshot"></a> [skip\_final\_snapshot](#input\_skip\_final\_snapshot) | Skip final snapshot | `bool` | `false` | no |
| <a name="input_storage_encrypted"></a> [storage\_encrypted](#input\_storage\_encrypted) | Skip final snapshot | `bool` | `true` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | RDS subnet group | `list(any)` | `[]` | no |
| <a name="input_vpc_security_group_ids"></a> [vpc\_security\_group\_ids](#input\_vpc\_security\_group\_ids) | VPC security groups for RDS | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_arn"></a> [cluster\_arn](#output\_cluster\_arn) | n/a |
| <a name="output_cluster_identifier"></a> [cluster\_identifier](#output\_cluster\_identifier) | n/a |
| <a name="output_db_master_password"></a> [db\_master\_password](#output\_db\_master\_password) | n/a |
| <a name="output_db_master_username"></a> [db\_master\_username](#output\_db\_master\_username) | n/a |
| <a name="output_db_name"></a> [db\_name](#output\_db\_name) | n/a |
| <a name="output_db_port"></a> [db\_port](#output\_db\_port) | n/a |
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | n/a |
| <a name="output_instance_arns"></a> [instance\_arns](#output\_instance\_arns) | n/a |
| <a name="output_rds_subnet_group_name"></a> [rds\_subnet\_group\_name](#output\_rds\_subnet\_group\_name) | n/a |
| <a name="output_reader_endpoint"></a> [reader\_endpoint](#output\_reader\_endpoint) | n/a |

## License

Apache 2 Licensed. See [LICENSE](https://github.com/TechHoldingLLC/terraform-aws-rds-aurora/blob/main/LICENSE) for full details.