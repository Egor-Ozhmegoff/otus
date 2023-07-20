#!/bin/bash
rm -r /opt/mysql/backup/*_db 2> /dev/null
export MYSQL_PWD=rootpass; mysql -u root -h mysql_master -e "STOP SLAVE;"
MYSQL=`export MYSQL_PWD=rootpass; mysql -u root -h mysql_slave --skip-column-names -e "SHOW DATABASES LIKE '%\_db';"`

for database in $MYSQL;
    do
    TABLES=`export MYSQL_PWD=rootpass; mysql -u root -h mysql_slave --skip-column-names -e "use $database; show tables;"`
    mkdir -m 777 /opt/mysql/backup/$database;
    for table in $TABLES;
        do
        export MYSQL_PWD=rootpass; mysqldump -u root -h mysql_slave --add-drop-table --add-locks --create-options --disable-keys\
        --extended-insert --single-transaction --quick --set-charset --events --routines\
        --triggers --tab=/opt/mysql/backup/$database $database $table;
        done
    done
export MYSQL_PWD=rootpass; mysql -u root -h mysql_slave -e "START SLAVE;"