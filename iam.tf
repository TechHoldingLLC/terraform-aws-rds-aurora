######################
## Enhanced monitoring
######################
resource "aws_iam_role" "enhanced_monitoring" {
  count              = var.enhanced_monitoring_interval > 0 ? 1 : 0
  name               = "${var.name}-rds-monitoring"
  assume_role_policy = data.aws_iam_policy_document.rds_trust_policy[0].json
}

data "aws_iam_policy_document" "rds_trust_policy" {
  count = var.enhanced_monitoring_interval > 0 ? 1 : 0
  statement {
    principals {
      type        = "Service"
      identifiers = ["monitoring.rds.amazonaws.com"]
    }
    actions = [
      "sts:AssumeRole",
    ]
  }
}

resource "aws_iam_role_policy_attachment" "enhanced_monitoring" {
  count      = var.enhanced_monitoring_interval > 0 ? 1 : 0
  role       = aws_iam_role.enhanced_monitoring[0].name
  policy_arn = "arn:${data.aws_partition.current.partition}:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}