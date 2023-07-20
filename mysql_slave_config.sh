#!/bin/bash

sudo cp ./mysql/slave/mysql.conf.cnf /etc/mysql/mysql.conf.d/mysqld.cnf
export MYSQL_PWD=grafana; mysql -u grafana -h 10.110.1.130 -e "FLUSH TABLES WITH READ LOCK;"
MS_STATUS=`export MYSQL_PWD=grafana; mysql -u grafana -h 10.110.1.130 -e "SHOW MASTER STATUS;"`
CURRENT_LOG=`echo $MS_STATUS | awk '{print $6}'`
CURRENT_POS=`echo $MS_STATUS | awk '{print $7}'`

slave_config="CHANGE REPLICATION SOURCE TO SOURCE_HOST='mysql_master',SOURCE_USER='replica',SOURCE_PASSWORD='replicapass',SOURCE_LOG_FILE='$CURRENT_LOG',SOURCE_LOG_POS=$CURRENT_POS,GET_SOURCE_PUBLIC_KEY=1;"
sudo mysql -e "STOP SLAVE;"
sudo mysql -e "$slave_config"
sudo mysql -e "START SLAVE;"
export MYSQL_PWD=grafana; mysql -u root -h 10.110.1.130 -e "UNLOCK TABLES;"
sudo mysql -e "SHOW SLAVE STATUS \G"