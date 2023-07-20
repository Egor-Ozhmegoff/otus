#!/bin/bash
rm -r /opt/backup/*_db 2> /dev/null
export MYSQL_PWD=grafana; mysql -u grafana -e "STOP SLAVE;"
MYSQL=`export MYSQL_PWD=grafana; mysql --skip-column-names -e "SHOW DATABASES LIKE '%\_db';"`

for database in $MYSQL;
    do
    TABLES=`export MYSQL_PWD=grafana; mysql --skip-column-names -e "use $database; show tables;"`
    mkdir -m 777 /opt/backup/$database;
    for table in $TABLES;
        do
        export MYSQL_PWD=grafana; mysqldump --add-drop-table --add-locks --create-options --disable-keys\
        --extended-insert --single-transaction --quick --set-charset --events --routines\
        --triggers --tab=/opt/backup/$database $database $table;
        done
    done
export MYSQL_PWD=grafana; mysql -u grafana -e "START SLAVE;"