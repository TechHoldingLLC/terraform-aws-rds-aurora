###############################################
# rds/main.tf #
###############################################

data "aws_partition" "current" {}

data "aws_kms_key" "rds" {
  key_id = "alias/aws/rds"
}

locals {
  family                   = "${var.engine}${split(".", var.engine_version)[0]}"
  cluster_parameter_group  = length(var.cluster_custom_parameters) > 0 ? aws_rds_cluster_parameter_group.cluster[0].name : "default.${local.family}"
  instance_parameter_group = length(var.instance_custom_parameters) > 0 ? aws_db_parameter_group.instance[0].name : "default.${local.family}"
}

#tfsec:ignore:aws-rds-encrypt-cluster-storage-data
resource "aws_rds_cluster" "db" {
  cluster_identifier              = var.name
  engine                          = var.engine
  engine_version                  = var.engine_version
  engine_mode                     = var.engine_mode
  master_username                 = var.master_username
  master_password                 = var.master_password
  database_name                   = var.database_name
  backup_retention_period         = var.backup_retention_period
  storage_encrypted               = var.storage_encrypted
  kms_key_id                      = data.aws_kms_key.rds.arn
  preferred_backup_window         = var.backup_window
  preferred_maintenance_window    = var.maintenance_window
  skip_final_snapshot             = var.skip_final_snapshot
  copy_tags_to_snapshot           = true
  vpc_security_group_ids          = [module.sg_rds.id]
  db_subnet_group_name            = aws_db_subnet_group.rds.id
  db_cluster_parameter_group_name = local.cluster_parameter_group
  port                            = var.db_port
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  deletion_protection             = var.deletion_protection
  apply_immediately               = var.apply_immediately
  tags = {
    Name = var.name
  }

  lifecycle {
    prevent_destroy = false #true
  }
}

#tfsec:ignore:aws-rds-enable-performance-insights
resource "aws_rds_cluster_instance" "db" {
  count                      = var.instance_count
  identifier                 = "${aws_rds_cluster.db.id}-${count.index + 1}"
  cluster_identifier         = aws_rds_cluster.db.id
  instance_class             = var.instance_class
  db_subnet_group_name       = aws_rds_cluster.db.db_subnet_group_name
  db_parameter_group_name    = local.instance_parameter_group
  engine                     = aws_rds_cluster.db.engine
  engine_version             = aws_rds_cluster.db.engine_version
  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  publicly_accessible        = var.publicly_accessible

  ## Enhanced monitoring
  monitoring_interval = var.enhanced_monitoring_interval
  monitoring_role_arn = var.enhanced_monitoring_interval > 0 ? aws_iam_role.enhanced_monitoring[0].arn : null

  ## Performance insights
  performance_insights_enabled          = var.performance_insights_enabled
  performance_insights_retention_period = var.performance_insights_enabled ? var.performance_insights_retention_period : null
  performance_insights_kms_key_id       = var.performance_insights_enabled ? data.aws_kms_key.rds.arn : null

  lifecycle {
    prevent_destroy = false #true
  }
}

resource "aws_db_subnet_group" "rds" {
  name       = var.name
  subnet_ids = var.subnets
  tags = {
    Name = var.name
  }

  lifecycle {
    prevent_destroy = false #true
  }
}

## Custom cluster parameter group
resource "aws_rds_cluster_parameter_group" "cluster" {
  count  = length(var.cluster_custom_parameters) > 0 ? 1 : 0
  name   = "${var.name}-${var.engine}-cluster-custom"
  family = local.family

  dynamic "parameter" {
    for_each = var.cluster_custom_parameters
    content {
      apply_method = parameter.value.apply_method
      name         = parameter.value.name
      value        = parameter.value.value
    }
  }
  lifecycle {
    create_before_destroy = true
  }
}

## Custom instance/db parameter group
resource "aws_db_parameter_group" "instance" {
  count  = length(var.instance_custom_parameters) > 0 ? 1 : 0
  name   = "${var.name}-${var.engine}-instance-custom"
  family = local.family

  dynamic "parameter" {
    for_each = var.instance_custom_parameters
    content {
      apply_method = parameter.value.apply_method
      name         = parameter.value.name
      value        = parameter.value.value
    }
  }
  lifecycle {
    create_before_destroy = true
  }
}

#######################
## CloudWatch Log Group
#######################
#tfsec:ignore:aws-cloudwatch-log-group-customer-key
#Log group data is always encrypted in CloudWatch Logs. By default, CloudWatch Logs uses server-side encryption for the log data at rest.
resource "aws_cloudwatch_log_group" "rds" {
  for_each          = toset(var.enabled_cloudwatch_logs_exports)
  name              = "/aws/rds/cluster/${var.name}/${each.key}"
  retention_in_days = var.cloudwatch_log_group_retention_in_days
}