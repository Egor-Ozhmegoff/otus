#!/bin/bash

echo 'server-id = 1' >> /etc/mysql/mysql.conf.d/mysqld.cnf
echo 'bind-address = 0.0.0.0' >> /etc/mysql/mysql.conf.d/mysqld.cnf
echo 'secure-file-priv=""' >> /etc/mysql/mysql.conf.d/mysqld.cnf

priv_stmt='CREATE USER "replica"@"%" IDENTIFIED WITH 'caching_sha2_password' BY "replicapass"; GRANT REPLICATION SLAVE ON *.* TO "replica"@"%"; FLUSH PRIVILEGES;'
sudo mysql -u root -e "$priv_stmt"
sudo mysql -u root -e "CREATE USER "grafana"@"%" IDENTIFIED  BY "grafana";GRANT ALL PRIVILEGES ON *.* TO "grafana"@"%";FLUSH PRIVILEGES;"
sudo mysql -u root -e "CREATE DATABASE grfana_db;"