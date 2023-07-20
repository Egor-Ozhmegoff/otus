#!/bin/bash

until export MYSQL_PWD=rootpass; mysql -u root -h mysql_master -e ";"
do
    echo "Waiting for mysql_master database connection..."
    sleep 4
done

priv_stmt='CREATE USER "replica"@"%" IDENTIFIED WITH 'caching_sha2_password' BY "replicapass"; GRANT REPLICATION SLAVE ON *.* TO "replica"@"%"; FLUSH PRIVILEGES;'
export MYSQL_PWD=rootpass; mysql -u root -h mysql_master -e "$priv_stmt"

until export MYSQL_PWD=rootpass; mysql -u root -h mysql_slave -e ";"
do
    echo "Waiting for mysql_slave database connection..."
    sleep 4
done
export MYSQL_PWD=rootpass; mysql -u root -h mysql_master -e "FLUSH TABLES WITH READ LOCK;"
MS_STATUS=`export MYSQL_PWD=rootpass; mysql -u root -h mysql_master -e "SHOW MASTER STATUS;"`
CURRENT_LOG=`echo $MS_STATUS | awk '{print $6}'`
CURRENT_POS=`echo $MS_STATUS | awk '{print $7}'`

slave_config="CHANGE REPLICATION SOURCE TO SOURCE_HOST='mysql_master',SOURCE_USER='replica',SOURCE_PASSWORD='replicapass',SOURCE_LOG_FILE='$CURRENT_LOG',SOURCE_LOG_POS=$CURRENT_POS,GET_SOURCE_PUBLIC_KEY=1;"

export MYSQL_PWD=rootpass; mysql -u root -h mysql_slave -e "$slave_config"
export MYSQL_PWD=rootpass; mysql -u root -h mysql_slave -e "START SLAVE;"
export MYSQL_PWD=rootpass; mysql -u root -h mysql_master -e "UNLOCK TABLES;"
export MYSQL_PWD=rootpass; mysql -u root -h mysql_slave -e "SHOW SLAVE STATUS \G"