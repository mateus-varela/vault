

variable "name" {
  description = "Name to be used as a basename on all the resources identifiers"
  default     = "RDS_BOOSTRAP_EPHEMERAL"
}

variable "subnet_id" {
  description = "Subnet in which the ephemeral instance is created"
  default     = ""
}

variable "security_group_ids" {
  description = "A list of security groups the ephemeral instance will belong to"
  default     = []
}

variable "endpoint" {
  description = "RDS connection endpoint"
  default     = ""
}

variable "port" {
  description = "RDS connection port"
  default     = ""
}

variable "master_username" {
  description = "RDS master user name"
  default     = ""
}

variable "master_password" {
  description = "RDS master password"
  default     = ""
}

variable "engine_mysql" {
  description = "RDS engine"
  default     = "mysql"
}

variable "engine_postgresql" {
  description = "RDS engine"
  default     = "postgresql"
}


variable "database" {
  description = "RDS database name"
  default     = ""
}
variable "engine" {
  description = "RDS engine eg mariadb"
}

variable "shell_script" {
  description = "A shell script template that will be run from the ephemeral instanceRDS database name"
  default     = ""
}

variable "sql_script" {
  description = "A SQL script that will be run from the ephemeral instance against a MySQL/Aurora RDS DB"
  default     = ""
}

variable "ephemeral_instance_type" {
  description = "Ephemeral instance type"
  default     = "t2.small"
}

variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default     = {}
}


variable "create_with_bootstrap" {
}

variable "secrets" {
  description = "Map of secret values to apply"
}
