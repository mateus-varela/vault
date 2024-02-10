#!/bin/bash

echo "BEGINNING OF SCRIPT"
sudo dnf update -y
sudo dnf install postgresql15 -y

echo "Creating rds_bootstrap folder"
sudo mkdir /rds_bootstrap


echo "Folder created and rds PEM installed successfully"

cat <<EOF >>/rds_bootstrap/postgres.sql

-- Criação das bases de dados
CREATE DATABASE hapi_dev;
CREATE DATABASE keycloak_dev;
CREATE DATABASE openfga_dev;
CREATE DATABASE hapi_tst;
CREATE DATABASE keycloak_tst;

-- Criação dos usuários
CREATE USER ${HAPI_DEV_USERNAME} WITH encrypted password '${HAPI_DEV_PASSWORD}';
CREATE USER ${KEYCLOAK_DEV_USERNAME} WITH encrypted password '${KEYCLOAK_DEV_PASSWORD}';
CREATE USER ${OPENFGA_DEV_USERNAME} WITH encrypted password '${OPENFGA_DEV_PASSWORD}';
CREATE USER ${HAPI_TST_USERNAME} WITH encrypted password '${HAPI_TST_PASSWORD}';
CREATE USER ${KEYCLOAK_TST_USERNAME} WITH encrypted password '${KEYCLOAK_TST_PASSWORD}';

-- Concede privilégios nas tabelas das bases de dados
GRANT ALL privileges on database hapi_dev to ${HAPI_DEV_USERNAME};
GRANT ALL privileges on database keycloak_dev to ${KEYCLOAK_DEV_USERNAME};
GRANT ALL privileges on database openfga_dev to ${OPENFGA_DEV_USERNAME};
GRANT ALL privileges on database hapi_tst to ${HAPI_TST_USERNAME};
GRANT ALL privileges on database keycloak_tst to ${KEYCLOAK_TST_USERNAME};

EOF

echo "Running psql command"
sudo PGPASSWORD=${DATABASE_PASSWORD} psql --host=${DATABASE_ENDPOINT} \
     --username=${DATABASE_USER} \
     --dbname=postgres \
 < /rds_bootstrap/postgres.sql



echo "END OF SCRIPT"
# Hara-kiri (since instance_initiated_shutdown_behavior = "terminate")
shutdown
