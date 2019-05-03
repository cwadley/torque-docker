CREATE DATABASE IF NOT EXISTS torque;
CREATE USER IF NOT EXISTS '{{torque_user}}'@'%' IDENTIFIED BY '{{torque_pass}}';
GRANT USAGE, FILE ON *.* TO '{{torque_user}}'@'%';
GRANT ALL PRIVILEGES ON torque.* TO '{{torque_user}}'@'%';

FLUSH PRIVILEGES;