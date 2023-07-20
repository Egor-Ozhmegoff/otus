#!/bin/bash

sudo copy ./mysql/master/mysql.conf.cnf /etc/mysql/mysql.conf.d/mysqld.cnf

priv_stmt='CREATE USER "replica"@"%" IDENTIFIED WITH 'caching_sha2_password' BY "replicapass"; GRANT REPLICATION SLAVE ON *.* TO "replica"@"%"; FLUSH PRIVILEGES;'
sudo mysql -u root -e "$priv_stmt"
sudo mysql -u root -e "CREATE USER "grafana"@"%" IDENTIFIED  BY "grafana";GRANT ALL PRIVILEGES ON *.* TO "grafana"@"%";FLUSH PRIVILEGES;"
sudo mysql -u root -e "CREATE DATABASE grfana_db;"