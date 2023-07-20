#!/bin/bash
rm -r ./backup/*_db 2> /dev/null
sudo mysql "STOP SLAVE;"
MYSQL=`sudo mysql --skip-column-names -e "SHOW DATABASES LIKE '%\_db';"`

for database in $MYSQL;
    do
    TABLES=`sudo mysql --skip-column-names -e "use $database; show tables;"`
    mkdir -m 777 ./backup/$database;
    for table in $TABLES;
        do
        export MYSQL_PWD=grafana; mysqldump -u grafana --add-drop-table --add-locks --create-options --disable-keys\
        --extended-insert --single-transaction --quick --set-charset --events --routines\
        --triggers --tab=./backup/$database $database $table;
        done
    done
sudo mysql -e "START SLAVE;"