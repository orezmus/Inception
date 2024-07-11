#!/bin/ash

# Define the config file path
CONFIG_FILE="/tmp/config.sql"

cat << EOF > ${CONFIG_FILE}
CREATE DATABASE IF NOT EXISTS ${DB_NAME};
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PWD}';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '${DB_ROOT_PWD}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%' WITH GRANT OPTION;
USE ${DB_NAME};
FLUSH PRIVILEGES;
EOF

# Check if the database is already initialized
echo 'Initializing MariaDB database...'
# mysql_install_db --datadir=/var/lib/mysql

# Run bootstrap to execute the configuration SQL
mysqld < ${CONFIG_FILE}
echo 'Initializing MariaDB database...2'
# Start MariaDB normally
exec "$@"