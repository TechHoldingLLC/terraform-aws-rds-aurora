output "cluster_identifier" {
  value = aws_rds_cluster.db.cluster_identifier
}

output "endpoint" {
  value = aws_rds_cluster.db.endpoint
}

output "db_username" {
  value     = aws_rds_cluster.db.master_username
  sensitive = true
}

output "db_password" {
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