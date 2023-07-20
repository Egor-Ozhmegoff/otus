#!/bin/bash

copy ./mysql/master/mysql.conf.cnf /etc/mysql/mysql.d/mysql.conf.cnf

priv_stmt='CREATE USER "replica"@"%" IDENTIFIED WITH 'caching_sha2_password' BY "replicapass"; GRANT REPLICATION SLAVE ON *.* TO "replica"@"%"; FLUSH PRIVILEGES;'
mysql -u root -e "$priv_stmt"
mysql -u root -e "CREATE USER "grafana"@"%" IDENTIFIED  BY "grafana";GRANT ALL PRIVILEGES ON *.* TO "grafana"@"%";FLUSH PRIVILEGES;"
mysql -u root -e "CREATE DATABASE grfana_db;"