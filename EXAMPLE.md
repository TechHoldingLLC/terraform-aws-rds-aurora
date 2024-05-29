# RDS
Below is an examples of calling this module.
 
## Create RDS of `aurora-postgresql`. 
```
module "rds_aurora_postgresql" {
  source                          = "./rds"
  name                            = "my-rds"
  engine                          = "aurora-postgresql"
  engine_version                  = "15.3"
  master_username                 = "username"
  master_password                 = "password"
  database_name                   = "api"  # Only alphanumeric and underscore are allowed
  instance_class                  = "db.t3.medium"
  instance_count                  = 1 ## more than one for failover
  backup_retention_period         = 1
  backup_window                   = "02:00-03:00"
  maintenance_window              = "sun:05:00-sun:06:00"
  enabled_cloudwatch_logs_exports = ["postgresql"] # For aurora-postgresql, only postgresql is allowed.
  certificate_identifier          = "rds-ca-rsa2048-g1"

  ## Network
  subnets             = ["subnet_1", "subnet_2"]
  vpc_id              = vpc_id
  publicly_accessible = false

  ## monitoring
  enhanced_monitoring_interval = 60

  ## performance insight
  performance_insights_enabled = true

  deletion_protection = true
  skip_final_snapshot = false

  ## Security group rules
  vpc_security_group_ids = [module.sg_aurora_postgresql.id]

  cluster_custom_parameters = [{
    apply_method = "pending-reboot"
    name         = "name"
    value        = "value"
  }]

  instance_custom_parameters = [
    # https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_WorkingWithParamGroups.html
    # Parameters are either static or dynamic.
    # Static: When you change a static parameter and save the DB cluster parameter group, the parameter change takes effect after you manually reboot 
    # Dynamic: When you change a dynamic parameter, by default the parameter change is applied to your DB cluster immediately, without requiring a reboot
    {
      apply_method = "pending-reboot"
      name         = "parameter"
      value        = "value"
    }
  ]
  providers = {
    aws = aws
  }
}
```

## Create RDS of `aurora-mysql`.
Following values will change, rest of the code will be same as above.
```
  engine                          = "aurora-mysql"
  engine_version                  = "8.0"
  enabled_cloudwatch_logs_exports = ["general", "audit", "error", "slowquery"] 

  ## Security group rules
  vpc_security_group_ids = [module.sg_aurora_mysql.id]
```

## Create RDS instances with serverless instance_class for `aurora-mysql`
Database capacity is measured in Aurora Capacity Units (ACUs). 1 ACU provides 2 GiB of memory and corresponding compute and networking.
```
module "rds_serverless" {
  source                          = "./rds"
  name                            = "${var.prefix}-my-rds"
  engine                          = "aurora-mysql"
  engine_version                  = "8.0"
  master_username                 = "username"
  master_password                 = "password"
  database_name                   = "api" # Only alphanumeric and underscore are allowed
  instance_class                  = "db.serverless"
  instance_count                  = 1 ## more than one for failover
  backup_retention_period         = 1
  backup_window                   = "02:00-03:00"
  maintenance_window              = "sun:05:00-sun:06:00"
  enabled_cloudwatch_logs_exports = ["general", "audit", "error", "slowquery"]
  certificate_identifier          = "rds-ca-rsa2048-g1"

  ## Define maximum and minimum capacity. Reference link: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#serverlessv2_scaling_configuration-argument-reference
  max_capacity = 2
  min_capacity = 1

  ## Network
  subnets             = ["subnet_1", "subnet_2"]
  vpc_id              = vpc_id
  publicly_accessible = false

  ## monitoring
  enhanced_monitoring_interval = 60

  ## performance insight
  performance_insights_enabled = true

  deletion_protection = true
  skip_final_snapshot = false

  ## Security group rules
  vpc_security_group_ids = [module.sg_aurora_mysql.id]

  cluster_custom_parameters = [{
    apply_method = "pending-reboot"
    name         = "name"
    value        = "value"
  }]

  instance_custom_parameters = [
    # https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_WorkingWithParamGroups.html
    # Parameters are either static or dynamic.
    # Static: When you change a static parameter and save the DB cluster parameter group, the parameter change takes effect after you manually reboot 
    # Dynamic: When you change a dynamic parameter, by default the parameter change is applied to your DB cluster immediately, without requiring a reboot
    {
      apply_method = "pending-reboot"
      name         = "parameter"
      value        = "value"
    }
  ]
  providers = {
    aws = aws
  }
}
```

## Create RDS instances with serverless instance_class for `aurora-postgresql`
Following values will change, rest of the code will be same as above.
```
  engine                          = "aurora-postgresql"
  engine_version                  = "15.3"
  enabled_cloudwatch_logs_exports = ["postgresql"] 

  ## Security group rules
  vpc_security_group_ids = [module.sg_aurora_postgresql.id]
```

## Create RDS when engine_mode is serverless for `aurora-postgresql`
The command to check availability of which version of engine is engine_mode = serverless compatible is `aws rds describe-db-engine-versions --engine <engine> --filters Name=engine-mode,Values=serverless --output text --query "DBEngineVersions[].EngineVersion" --profile <profile-name>`. Instance_count and enabled_cloudwatch_logs_exports are not supported for serverless engine_mode.
For `aurora-postgresql`, value for maximum_capacity and minimum_capacity starts with 2. 
```
module "rds_engine_mode_serverless" {
  source                  = "./rds"
  name                    = "${var.prefix}-my-rds"
  engine                  = "aurora-postgresql"
  engine_version          = "11.21"
  engine_mode             = "serverless"
  master_username         = "username"
  master_password         = "password"
  database_name           = "api" # Only alphanumeric and underscore are allowed
  backup_retention_period = 1
  backup_window           = "02:00-03:00"
  maintenance_window      = "sun:05:00-sun:06:00"
  certificate_identifier  = "rds-ca-rsa2048-g1"  

 ## Reference link: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#scaling_configuration-argument-reference
  scaling_configuration = {
    auto_pause               = true
    maximum_capacity         = 32
    minimum_capacity         = 2
    seconds_until_auto_pause = 300
    timeout_action           = "ForceApplyCapacityChange"
  }

  ## Network
  subnets             = ["subnet_1", "subnet_2"]
  vpc_id              = vpc_id
  publicly_accessible = false

  ## monitoring
  enhanced_monitoring_interval = 60

  ## performance insight
  performance_insights_enabled = true

  deletion_protection = true
  skip_final_snapshot = false

  ## Security group rules
  vpc_security_group_ids = [module.sg_aurora_postgresql.id]

  instance_custom_parameters = [
    # https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_WorkingWithParamGroups.html
    # Parameters are either static or dynamic.
    # Static: When you change a static parameter and save the DB cluster parameter group, the parameter change takes effect after you manually reboot 
    # Dynamic: When you change a dynamic parameter, by default the parameter change is applied to your DB cluster immediately, without requiring a reboot
    {
      apply_method = "pending-reboot"
      name         = "parameter"
      value        = "value"
    }
  ]
  providers = {
    aws = aws
  }
}
```

## Create RDS when engine_mode is serverless for `aurora-mysql`
Following values will change, rest of the code will be same as above.
```
  engine                  = "aurora-mysql"
  engine_version          = "5.7"
  scaling_configuration = {
    auto_pause               = true
    maximum_capacity         = 32
    minimum_capacity         = 1
    seconds_until_auto_pause = 300
    timeout_action           = "ForceApplyCapacityChange"
  }
```