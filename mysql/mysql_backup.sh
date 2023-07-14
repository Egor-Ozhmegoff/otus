#!/bin/bash
mysql -u root -e "STOP SLAVE;"
MYSQL=`mysql -u root --skip-column-names -e "SHOW DATABASES LIKE '%\_db';"`

for database in $MYSQL;
    do
    TABLES=`mysql -u root --skip-column-names -e "use test_db; show tables;"`
    mkdir -m 777 /tmp/$database;
    for table in $TABLES;
        do
        mysqldump -u root --add-drop-table --add-locks --create-options --disable-keys\
        --extended-insert --single-transaction --quick --set-charset --events --routines\
        --triggers --tab=/tmp/$database $database $table;
        done
    done
mysql -u root -e "START SLAVE;"
