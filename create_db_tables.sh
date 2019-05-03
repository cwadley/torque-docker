#!/bin/bash
DB_NAME=torque
mysql -h $DB_HOST -u $DB_USER -p$DB_PASS -D $DB_NAME < /var/torque/scripts/create_torque_log_table.sql
mysql -h $DB_HOST -u $DB_USER -p$DB_PASS -D $DB_NAME < /var/torque/scripts/create_torque_keys_table.sql
mysql -h $DB_HOST -u $DB_USER -p$DB_PASS -D $DB_NAME < /var/torque/scripts/create_torque_sessions_table.sql