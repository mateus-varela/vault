locals {
  user_data_mysql_template = var.engine == "mysql" ? templatefile("${path.module}/templates/mysql.sh.tpl", {
    DATABASE_ENDPOINT = var.endpoint
    DATABASE_PORT     = var.port
    DATABASE_NAME     = var.database
    DATABASE_USER     = var.master_username
    DATABASE_PASSWORD = var.master_password
    DB_ENGINE         = var.engine_mysql

    HAPI_DEV_USERNAME = var.secrets["hapi_dev"].username
    TAC_DEV_USERNAME  = var.secrets["tac_dev"].username

    HAPI_DEV_PASSWORD = var.secrets["hapi_dev"].password
    TAC_DEV_PASSWORD  = var.secrets["tac_dev"].password

    TAC_TST_USERNAME = var.secrets["tac_tst"].username

    TAC_TST_PASSWORD = var.secrets["tac_tst"].password


  }) : null

  user_data_postgres_template = var.engine == "postgres" ? templatefile("${path.module}/templates/postgres.sh.tpl", {
    DATABASE_ENDPOINT = var.endpoint
    DATABASE_PORT     = var.port
    DATABASE_NAME     = var.database
    DATABASE_USER     = var.master_username
    DATABASE_PASSWORD = var.master_password
    DB_ENGINE         = var.engine_postgresql

    HAPI_DEV_USERNAME     = var.secrets["hapi_dev"].username
    KEYCLOAK_DEV_USERNAME = var.secrets["keycloak_dev"].username
    OPENFGA_DEV_USERNAME  = var.secrets["openfga_dev"].username

    HAPI_DEV_PASSWORD     = var.secrets["hapi_dev"].password
    KEYCLOAK_DEV_PASSWORD = var.secrets["keycloak_dev"].password
    OPENFGA_DEV_PASSWORD  = var.secrets["openfga_dev"].password

    HAPI_TST_USERNAME     = var.secrets["hapi_tst"].username
    KEYCLOAK_TST_USERNAME = var.secrets["keycloak_tst"].username

    HAPI_TST_PASSWORD     = var.secrets["hapi_tst"].password
    KEYCLOAK_TST_PASSWORD = var.secrets["keycloak_tst"].password

  }) : null


}
