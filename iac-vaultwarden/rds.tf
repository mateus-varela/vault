# module "DB_MYSQL" {
#   source                   = "./_modules/rds"
#   depends_on               = [module.SG_WORKERS_RDS, module.SG_DB_BOOTSTRAP]
#   create_with_bootstrap    = "true"
#   subnet_bootstrap_id      = module.SUBNETS.public_subnets[0]
#   bootstrap_security_group = module.SG_DB_BOOTSTRAP.security_group_id
#   vpc_security_group_ids   = module.SG_WORKERS_RDS.security_group_id
#   identifier               = "db-mysql-tst"
#   subnet_ids               = module.SUBNETS.private_subnets
#   engine                   = "mysql"
#   engine_version           = "5.7"
#   instance_type            = "db.t2.micro"
#   additional_users         = ["hapi_dev", "tac_dev", "tac_tst"]
#   tags                     = var.tags
# }


# module "DB_POSTGRES" {
#   source                   = "./_modules/rds"
#   depends_on               = [module.SG_WORKERS_RDS, module.SG_DB_BOOTSTRAP]
#   create_with_bootstrap    = "true"
#   subnet_bootstrap_id      = module.SUBNETS.private_subnets[0]
#   bootstrap_security_group = module.SG_DB_BOOTSTRAP.security_group_id
#   vpc_security_group_ids   = module.SG_WORKERS_RDS.security_group_id
#   identifier               = "db-postgresql-tst"
#   subnet_ids               = module.SUBNETS.private_subnets
#   engine                   = "postgres"
#   engine_version           = "14"
#   instance_type            = "db.t3.micro"
#   additional_users         = ["hapi_dev", "keycloak_dev", "openfga_dev", "hapi_tst", "keycloak_tst"]
#   tags                     = var.tags
# }
