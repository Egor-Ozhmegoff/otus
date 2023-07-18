#!/bin/bash

until export MYSQL_PWD=rootpass; mysql -u root -h mysql_master -e ";"
do
    echo "Waiting for mysql_master database connection..."
    sleep 4
done

priv_stmt='CREATE USER "mydb_slave_user"@"%" IDENTIFIED BY "mydb_slave_pwd"; GRANT REPLICATION SLAVE ON *.* TO "mydb_slave_user"@"%"; FLUSH PRIVILEGES;'
export MYSQL_PWD=rootpass; mysql -u root -h mysql_master -e '$priv_stmt'

until export MYSQL_PWD=rootpass; mysql -u root -h mysql_slave-e ";"
do
    echo "Waiting for mysql_slave database connection..."
    sleep 4
done

MS_STATUS=`export MYSQL_PWD=rootpass; mysql -u root -h mysql_master -e "SHOW MASTER STATUS"'
CURRENT_LOG=`echo $MS_STATUS | awk '{print $6}'`
CURRENT_POS=`echo $MS_STATUS | awk '{print $7}'`

start_slave_stmt="CHANGE MASTER TO MASTER_HOST='mysql_master',MASTER_USER='mydb_slave_user',MASTER_PASSWORD='mydb_slave_pwd',MASTER_LOG_FILE='$CURRENT_LOG',MASTER_LOG_POS=$CURRENT_POS; START SLAVE;"

export MYSQL_PWD=rootpass; mysql -u root -h mysql_slave -e '$start_slave_stmt'
export MYSQL_PWD=rootpass; mysql -u root -h mysql_slave -e 'SHOW SLAVE STATUS \G'