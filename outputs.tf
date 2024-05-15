output "cluster_identifier" {
  value = aws_rds_cluster.db.cluster_identifier
}

output "endpoint" {
  value = aws_rds_cluster.db.endpoint
}

output "db_master_username" {
  value     = aws_rds_cluster.db.master_username
  sensitive = true
}

output "db_master_password" {
  value     = aws_rds_cluster.db.master_password
  sensitive = true
}

output "db_name" {
  value = aws_rds_cluster.db.database_name
}

output "db_port" {
  value = aws_rds_cluster.db.port
}

output "reader_endpoint" {
  value = aws_rds_cluster.db.reader_endpoint
}

output "rds_subnet_group_name" {
  value = local.db_subnet_group_name
}

output "cluster_arn" {
  value = aws_rds_cluster.db.arn
}

output "instance_arn" {
  value = var.instance_count > 0 ? "${aws_rds_cluster_instance.db.*.arn}" : null
}
