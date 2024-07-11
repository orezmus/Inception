#!/bin/ash

cat << EOF > config.sql
CREATE DATABASE IF NOT EXISTS $DB_NAME;
CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PWD';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$DB_ROOT_PWD';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%' WITH GRANT OPTION;
USE $DB_NAME;
FLUSH PRIVILEGES;
EOF

# Initialize MariaDB database
mysql_install_db

# Start MySQL in the background
mysqld --skip-networking &

# Wait for MySQL to be ready
while ! mysqladmin ping --silent; do
  echo 'MySQL init process in progress...'
  sleep 1
done

# Run the setup script
mysql < /tmp/config.sql

# Stop background MySQL process and start it normally
killall mysqld

exec "$@"