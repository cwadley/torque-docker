#!/bin/bash

nc -z $DB_HOST 3306
while [ $? -ne 0 ]; do
	sleep 1s
	nc -z $DB_HOST 3306
done

init_sql=$(cat /init_db/initialize_db.sql)
init_sql=$(sed "s/{{torque_user}}/${DB_USER}/g" <<< $init_sql)
init_sql=$(sed "s/{{torque_pass}}/${DB_PASS}/g" <<< $init_sql)
mysql -h $DB_HOST -u root -p$MYSQL_ROOT_PASSWORD <<< $init_sql