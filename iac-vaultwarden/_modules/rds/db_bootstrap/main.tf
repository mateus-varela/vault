locals {
  user_data = (
    var.engine == "mysql" ?
    local.user_data_mysql_template :
    var.engine == "postgres" ?
    local.user_data_postgres_template : ""
  )
}
resource "aws_instance" "ephemeral_instance" {
  count         = var.create_with_bootstrap == true ? 1 : 0

  subnet_id     = var.subnet_id
  instance_type = var.ephemeral_instance_type
  ami                    = "ami-0513ae30100cf3cf5"
  vpc_security_group_ids = var.security_group_ids
  user_data              = local.user_data
  tags                   = tomap({ Name = format("%s-EPHEMERAL_INSTANCE", var.name) })

  instance_initiated_shutdown_behavior = "terminate"

  root_block_device {
    volume_type           = "gp2"
    volume_size           = "80"
    delete_on_termination = "true"
  }
  volume_tags = tomap({ Name = format("%s-EPHEMERAL_INSTANCE", var.name) })
}

