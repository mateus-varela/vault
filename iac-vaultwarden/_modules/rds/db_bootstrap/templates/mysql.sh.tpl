#!/bin/bash

echo "BEGINNING OF SCRIPT"
sudo dnf -y update
sudo rpm -Uvh https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
sudo rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2022
sudo yum install -y https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
sudo yum install -y mysql-community-client

echo "Creating rds_bootstrap folder"
sudo mkdir /rds_bootstrap
sudo wget https://s3.amazonaws.com/rds-downloads/rds-combined-ca-bundle.pem -O /rds_bootstrap/rds-combined-ca-bundle.pem

echo "Folder created and rds PEM installed successfully"

cat <<EOF >>/rds_bootstrap/mysql.sql

CREATE DATABASE IF NOT EXISTS hapi_dev;
CREATE DATABASE IF NOT EXISTS tac_dev;
CREATE DATABASE IF NOT EXISTS tac_tst;

CREATE USER '${TAC_DEV_USERNAME}'@'%' IDENTIFIED BY '${TAC_DEV_PASSWORD}' REQUIRE SSL;

CREATE USER '${HAPI_DEV_USERNAME}'@'%' IDENTIFIED BY '${HAPI_DEV_PASSWORD}' REQUIRE SSL;

CREATE USER '${TAC_TST_USERNAME}'@'%' IDENTIFIED BY '${TAC_TST_PASSWORD}' REQUIRE SSL;

USE tac_dev;
GRANT ALL PRIVILEGES ON tac_dev.* TO '${TAC_DEV_USERNAME}'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;

USE hapi_dev;
GRANT ALL PRIVILEGES ON hapi_dev.* TO '${HAPI_DEV_USERNAME}'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;

USE tac_tst;
GRANT ALL PRIVILEGES ON tac_tst.* TO '${TAC_TST_USERNAME}'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;

ALTER USER 'administrator'@'%' REQUIRE SSL;

EOF

echo "Running mysql command"
mysql 	--host=${DATABASE_ENDPOINT} \
		--port=${DATABASE_PORT} \
		--user=${DATABASE_USER} \
		--password='${DATABASE_PASSWORD}' \
		--ssl-ca=/rds_bootstrap/rds-combined-ca-bundle.pem \
		< /rds_bootstrap/mysql.sql


echo "END OF SCRIPT"
# Hara-kiri (since instance_initiated_shutdown_behavior = "terminate")
shutdown