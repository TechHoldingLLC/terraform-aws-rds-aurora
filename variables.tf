# ------------------------------------------------------------------------------
# REQUIRED VARIABLES
# ------------------------------------------------------------------------------

variable "backup_window" {
  description = "When to perform DB backups"
  type        = string
}

variable "backup_retention_period" {
  description = "Backup retention period"
  type        = number
}

variable "database_name" {
  description = "Database name"
  type        = string
}

variable "db_port" {
  description = "RDS port"
  type        = number
  default     = "5432"
}

variable "deletion_protection" {
  description = "Deletion protection"
  type        = bool
  default     = true
}

variable "engine" {
  description = "RDS db engine"
  type        = string
}

variable "engine_version" {
  description = "RDS db engine version"
  type        = string
}

variable "enabled_cloudwatch_logs_exports" {
  description = "Enabled cloudwatch logs export"
  type        = list(any)
}

variable "instance_count" {
  description = "Minimum instance for scaling"
  type        = number
}

variable "instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.medium"
}

variable "master_username" {
  description = "RDS Master username"
  type        = string
}

variable "master_password" {
  description = "RDS Master password"
  type        = string
}

variable "name" {
  description = "RDS name"
  type        = string
}

variable "subnets" {
  description = "RDS subnet group"
  type        = list(any)
}

variable "vpc_id" {
  description = "VPC id"
  type        = string
}

# ------------------------------------------------------------------------------
# OPTIONAL VARIABLES
# ------------------------------------------------------------------------------

variable "auto_minor_version_upgrade" {
  description = "Auto minor version upgradation during maintainance window"
  type        = bool
  default     = false
}

variable "apply_immediately" {
  description = "Apply changes imediately"
  type        = bool
  default     = false
}

variable "cluster_custom_parameters" {
  description = "RDS cluster custom parameter group"
  type        = list(any)
  default     = []
}

variable "cloudwatch_log_group_retention_in_days" {
  description = "The number of days to retain CloudWatch logs for the DB instance"
  type        = number
  default     = 30
}

variable "instance_custom_parameters" {
  description = "RDS db custom parameter group"
  type        = list(any)
  default     = []
}

variable "engine_mode" {
  description = "RDS DB engine mode"
  type        = string
  default     = "provisioned"
}

variable "egress" {
  description = "Outbound traffic for security group"
  type        = list(any)
  default     = []
}

variable "ingress" {
  description = "Inbound traffic for security group"
  type        = list(any)
  default     = []
}

variable "maintenance_window" {
  description = "When to perform DB maintenance"
  type        = string
  default     = "sun:05:00-sun:06:00"
}

variable "enhanced_monitoring_interval" {
  description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60."
  type        = number
  default     = 0
}

variable "monitoring_role_arn" {
  description = "The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs. Must be specified if monitoring_interval is non-zero."
  type        = string
  default     = null
}

variable "create_monitoring_role" {
  description = "Create IAM role with a defined name that permits RDS to send enhanced monitoring metrics to CloudWatch Logs."
  type        = bool
  default     = false
}

variable "publicly_accessible" {
  description = "Publicaly accessible"
  type        = bool
  default     = false
}

variable "performance_insights_enabled" {
  description = "Specifies whether Performance Insights are enabled"
  type        = bool
  default     = false
}

variable "performance_insights_retention_period" {
  description = "The amount of time in days to retain Performance Insights data. Either 7 (7 days) or 731 (2 years)."
  type        = number
  default     = 7
}

variable "performance_insights_kms_key_id" {
  description = "The ARN for the KMS key to encrypt Performance Insights data."
  type        = string
  default     = null
}

variable "skip_final_snapshot" {
  description = "Skip final snapshot"
  type        = bool
  default     = false
}

variable "storage_encrypted" {
  description = "Skip final snapshot"
  type        = bool
  default     = true
}