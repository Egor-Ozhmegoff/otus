#!/bin/bash
rm -r ./backup/*_db 2> /dev/null
export MYSQL_PWD=grfana; mysql -u grafana -h 10.110.1.131 -e "STOP SLAVE;"
MYSQL=`export MYSQL_PWD=grafana; mysql -u grafana -h 10.110.1.131 --skip-column-names -e "SHOW DATABASES LIKE '%\_db';"`

for database in $MYSQL;
    do
    TABLES=`export MYSQL_PWD=grafana; mysql -u grafana -h 10.110.1.131 --skip-column-names -e "use $database; show tables;"`
    mkdir -m 777 ./backup/$database;
    for table in $TABLES;
        do
        export MYSQL_PWD=grafana; mysqldump -u grafana -h 10.110.1.131 --add-drop-table --add-locks --create-options --disable-keys\
        --extended-insert --single-transaction --quick --set-charset --events --routines\
        --triggers --tab=./backup/$database $database $table;
        done
    done
export MYSQL_PWD=grafana; mysql -u grafana -h 10.110.1.131 -e "START SLAVE;"